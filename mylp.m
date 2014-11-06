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
    %    
    %   `status` is one of the following:
    %     0
    %         Status is undefined.
    %     1
    %         Final dictionary encountered.
    %
    %   `info` is a struct with the following fields:
    %     iterations
    %         The number of pivots before mylp returned.
    %     stalls
    %         The number of stalled pivots before mylp returned.
    %  
    
    errnum = 0;
    status = 0;
    info.iterations = 0;
    info.stalls = 0;
    z = z0;
    
    %=== TODO: INITIALIZATION PHASE ============================================
    
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
            return;
        end
    end
end
