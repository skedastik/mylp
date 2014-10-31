function [enter_var, leaving_var, z_delta] = mylp_greedy(A, b, c, b_vars, enter_vars)
    n            = length(enter_vars);
    leaving_idx  = -1;
    enter_idx    = -1;
    z_delta      = -1;
    
    % Iterate through all possible entering variables
    for cur_enter_idx = 1:n
        [new_leaving_idx, new_z_delta] = mylp_get_valid_leaving(A, b, c, b_vars, enter_vars, cur_enter_idx);
        
        % Choose enter/leaving variable pair that maximizes objective increase
        if (new_z_delta > z_delta)
            z_delta      = new_z_delta;
            enter_idx    = cur_enter_idx;
            
            % By definition, all valid leaving variables result in the same objective increase, so choose any of them.
            leaving_idx  = new_leaving_idx(1);
        end
    end
    
    leaving_var = b_vars(leaving_idx);
    enter_var   = enter_vars(enter_idx);
end
