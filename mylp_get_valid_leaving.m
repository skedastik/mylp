function leaving_idx = mylp_get_valid_leaving(A, b, b_vars, enter_vars, enter_idx)
    %MYLP_GET_VALID_LEAVING returns all valid leaving variables for the given subset of a dictionary.
    %
    %   [enter_var, leaving_var] = MYLP_GET_VALID_LEAVING(A, b, b_vars, enter_vars, enter_idx)
    %
    %   ARGUMENTS
    %
    %   [A, b, b_vars, enter_vars] describe a subset of a dictionary where all 
    %     non-basic vars (`enter_vars`) must be valid. There must be at least 
    %     one valid leaving variable in `b_vars`.
    %
    %   `enter_idx` must specify the index of the chosen entering variable in 
    %     the `enter_vars` array.
    %    
    %   OUTPUT
    %    
    %   `leaving_idx` is an array of indices of all valid leaving variables.
    %

    % Extract entering variable's column
    enter_col = A(:,enter_idx);
    
    % Get indices of negative rows
    row_idx = find(enter_col < 0);
    
    % Divide pertinent elements of b by corresponding elements of entering variable's column.
    b_div_a = b(row_idx) ./ enter_col(row_idx);
    
    % Get the indices of the maximum of the result. These are the row indices of all valid leaving variables.
    leaving_idx = row_idx(find(b_div_a == max(b_div_a)));
end
