function [enter_var, leaving_var] = mylp_bland(A, b, c, b_vars, enter_vars)
    % Select the entering variable with the lowest index
    [enter_var, enter_idx] = min(enter_vars);
    
    % Find all valid leaving variables...

    % Extract entering variable's column
    enter_col = A(:,enter_idx);
    
    % Get indices of negative rows
    row_idx = find(enter_col < 0);
    
    % Divide pertinent elements of b by corresponding elements of entering variable's column.
    b_div_a = b(row_idx) ./ enter_col(row_idx);
    
    % Get the indices of the maximum of the result. These are the row indices of all valid leaving variables.
    valid_leaving_idx = row_idx(find(b_div_a == max(b_div_a)));
    
    % Select the leaving variable with the lowest index
    leaving_var = min(b_vars(valid_leaving_idx));
end
