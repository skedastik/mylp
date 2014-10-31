function [enter_var, leaving_var] = mylp_bland(A, b, c, b_vars, enter_vars)
    % Select the entering variable with the lowest index
    [enter_var, enter_idx] = min(enter_vars);
    
    % Get all valid leaving variables
    valid_leaving_idx = mylp_get_valid_leaving(A, b, b_vars, enter_vars, enter_idx);
    
    % Select the leaving variable with the lowest index
    leaving_var = min(b_vars(valid_leaving_idx));
end
