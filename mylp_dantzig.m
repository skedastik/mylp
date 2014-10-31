function [enter_var, leaving_var] = mylp_dantzig(A, b, c, b_vars, enter_vars)
    % Select the entering variable with the largest coefficient
    [~, enter_idx] = max(c);
    enter_var = enter_vars(enter_idx);
    
    % Get all valid leaving variables
    valid_leaving_idx = mylp_get_valid_leaving(A, b, b_vars, enter_vars, enter_idx);
    
    % Select any valid leaving var
    leaving_var = b_vars(valid_leaving_idx(1));
end
