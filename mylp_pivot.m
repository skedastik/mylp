function [z0, A, b, c, b_vars, nb_vars, errnum, status, enter_var, leaving_var] = mylp_pivot(z0, A, b, c, b_vars, nb_vars, analysis_func)
    %MYLP_PIVOT performs a single pivot on an LP dictionary.
    %
    %   [z0, A, b, c, b_vars, nb_vars, errnum, status, enter_var, leaving_var] = MYLP_PIVOT (z0, A, b, c, b_vars, nb_vars)
    %
    %   ARGUMENTS
    %
    %   [z0, A, b, c, b_vars, nb_vars] describe the input dictionary. The dictionary must be in standard form.
    %
    %   `analysis_func` is a function that performs entering and leaving 
    %     variable analysis. It is only invoked if candidate entering and 
    %     leaving variables exist. It must have the following signature:
    %
    %       [enter_var, leaving_var] =  ANALYSIS_FUNC(A, b, c, b_vars, enter_vars)
    %
    %     Where `A` and `c` are subsets of the input dictionary corresponding 
    %     to the columns of the candidate `enter_vars` (these are guaranteed to 
    %     be valid entering variables). The function should return appropriate 
    %     entering and leaving variables.
    %    
    %   OUTPUT
    %    
    %   [z0, A, b, c, b_vars, nb_vars] describe the input dictionary after a single pivot.
    %    
    %   `errnum` is one of the following:
    %       
    %     0
    %         No error.
    %     1   
    %         Dictionary is unbounded.
    %    
    %   `status` is any combination of the following bit masks:
    %     0
    %         Status is undefined.
    %     1
    %         Input dictionary is final.
    %     2
    %         Pivot stalled.
    %
    %   `enter_var` is the index of the entering variable, or -1 if undefined.
    %
    %   `leaving_var` is the index of the leaving variable, or -1 if undefined.
    %       
    
    errnum = 0;
    status = 0;
    enter_var = -1;
    leaving_var = -1;
    
    % ENTERING AND LEAVING VARIABLE ANALYSIS

    % Look for non-basic variables w/ coefficients higher than 0. These are candidate entering variables.
    idx = find(c > 0);
    enter_vars = nb_vars(idx);
    
    if (length(enter_vars) == 0)
        % If there are no non-basic variables w/ coefficients higher than 0, then the input dictionary is the final dictionary.
        status = bitor(status, 1);
        return;
    end
    
    % Extract a subset of A corresponding to the columns of the candidate entering variables.
    Ap = A(:,idx);
    
    if (any(prod((Ap >= 0))))
        % If all entries in a column corresponding to any valid entering variable are non-negative, the dictionary is unbounded.
        errnum = 1;
        return;
    end
    
    % Perform entering and leaving variable analysis, passing a subset of A and c to the analysis function.
    [enter_var, leaving_var, z_delta] = analysis_func(Ap, b, c(idx), b_vars, enter_vars);
    
    % If the objective increase is effectively zero, report stalling.
    if (z_delta < 1e-15)
        status = bitor(status, 2);
    end
    
    % ROW OPERATIONS
    
    [m,n] = size(A);
    
    % Get indices of of entering and leaving vars.
    i = find(b_vars == leaving_var);
    j = find(nb_vars == enter_var);
    
    % Merge b, A, z0, and c into a single matrix for convenience
    D = [b A; [z0 c']];
    
    % Swap entering and leaving variables: Make the entering var basic, the leaving var non-basic.
    b_vars(i) = enter_var;
    nb_vars(j) = leaving_var;
    
    % Update row i by dividing it by -A_ij
    D(i,:) /= -A(i,j);
    
    % Perform row operations (substitutions) on remaining rows...
    enter_row = D(i,:);
    j += 1;                     % Increment j so that it indexes D
    for ii = 1:m+1
        if (ii != i)
            coeff = D(ii,j);
            D(ii,j) = 0;        % Var at (ii,j) is being substituted
            D(ii,:) += coeff * enter_row;
        end
    end
    
    % Unpack D into b, A, z0, and c
    b     = D(1:m, 1);
    A     = D(1:m, 2:end);
    z0    = D(m+1, 1);
    c     = D(m+1, 2:end)';        % Tranpose for column vector
end
