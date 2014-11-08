% TODO
% 
% Use pre-defined constants rather than literals for errnums and status values.

function [z, A, b, c, b_vars, nb_vars, errnum, status, info] = mylp(z0, A, b, c, b_vars, nb_vars, analysis_func)
    %MYLP is a simplex-based LP solver.
    %
    %   [z0, A, b, c, b_vars, nb_vars, errnum, status, enter_var, leaving_var] = MYLP (z0, A, b, c, b_vars, nb_vars)
    %
    %   ARGUMENTS
    %
    %   [z0, A, b, c, b_vars, nb_vars] describe the input dictionary. The 
    %     dictionary must be in standard form.
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
    %   [z0, A, b, c, b_vars, nb_vars] describe the input dictionary after running simplex.
    %    
    %   `errnum` is one of the following:
    %       
    %     0
    %         No error.
    %     1   
    %         Dictionary is unbounded.
    %     2
    %         Dictionary is infeasible.
    %    
    %   `status` is one of the following:
    %     0
    %         Status is undefined.
    %     1
    %         Final dictionary encountered.
    %
    %   `info` is a struct with the following fields:
    %     iterations
    %         The total number of pivots before mylp returned.
    %     stalls
    %         The total number of stalled pivots before mylp returned.
    %  
    
    errnum = 0;
    status = 0;
    info.iterations = 0;
    info.stalls = 0;
    z = z0;
    
    %=== INITIALIZATION PHASE ==================================================
    
    % If any b < 0, input dictionary is infeasible and must be initialized.
    if (any(b < 0))
        % We will use the dual complement to obtain the initial dictionary. Recall the definition of the dual complement:
        %
        %
        %       PRIMAL                     DUAL
        %                                        
        %       max.    dTx                max.   -bTy
        %       s.t.    Ax <= b            s.t.   -ATy <= -d
        %                x >= 0                       y >= 0
        %
        %       ('T' denotes transpose)
        %
        % The key thing to realize is that -c corresponds to b in the dual. Because we are free to change the objective during the initialization phase, we choose an objective d such that its negation yields only positive values, thereby guaranteeing feasibility of the dual.
        
        % Construct the initial dual
        [z_d, A_d b_d, c_d, b_vars_d, nb_vars_d] = mylp_dualize(z, A, b, c, b_vars, nb_vars);
        
        % Any positive values will do for dual's b vector
        b_d = ones(length(c), 1);
        
        while (true)
            [z_d, A_d b_d, c_d, b_vars_d, nb_vars_d, errnum, status, ~,~] = ...
                mylp_pivot(z_d, A_d, b_d, c_d, b_vars_d, nb_vars_d, analysis_func);
            
            if (!bitand(status, 1))
                info.iterations++;
            end
        
            if (bitand(status, 2))
                info.stalls++;
            end
            
            % Break if final dual dictionary encountered. This is the feasible initial primal dictionary.
            if (bitand(status, 1))
                % Retain the original c and nb_vars...
                c_orig = c;
                nb_vars_orig = nb_vars;
                
                % ...before converting dual back to primary.
                [z, A, b, c, b_vars, nb_vars] = mylp_dualize(z_d, A_d, b_d, c_d, b_vars_d, nb_vars_d);
                
                % We need to restore the original objective via substitution. This means using c_orig and nb_vars_orig to compute new z, c.
                
                % Some of the variables referred to in nb_vars_orig are now basic variables. Get the indices corresponding to these basic variables.
                [~, b_col_idx, b_row_index] = intersect(nb_vars_orig, b_vars);
                
                % The other variables referred to in nb_vars_orig are non-basic variables. Get the indices corresponding to these non-basic variables.
                [~, nb_orig_idx, nb_idx] = intersect(nb_vars_orig, nb_vars);
                
                if (length(b_col_idx) > 0)
                    % Substitute basic vars into z and c
                    c_sel = c_orig(b_col_idx)';
                    z = c_sel * b(b_row_index);
                    c = (c_sel * A(b_row_index, :))';
                end
                
                if (length(nb_orig_idx) > 0)
                    % Add non-basic var coefficients to c
                    c(nb_idx) += c_orig(nb_orig_idx);
                end
                
                break;
            end
        
            % If dual dictionary is unbounded, primal is infeasible. Return.
            if (errnum == 1)
                errnum = 2;     % Upgrade error to INFEASIBLE
                return;
            end
        end
    end
    
    %=== OPTIMIZATION PHASE ====================================================
    
    while (true)
        [z, A, b, c, b_vars, nb_vars, errnum, status, ~,~] = ...
            mylp_pivot(z, A, b, c, b_vars, nb_vars, analysis_func);
        
        if (!bitand(status, 1))
            info.iterations++;
        end
        
        if (bitand(status, 2))
            info.stalls++;
        end
        
        % Return if dictionary is unbounded, or final dictionary encountered.
        if (errnum == 1 ||  bitand(status, 1))
            % Unset the stall bit set by mylp_pivot, it is not part of mylp's status
            status = bitset(status, 2, 0);
            
            return;
        end
    end
end
