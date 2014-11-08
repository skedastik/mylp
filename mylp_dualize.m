function [z_d, A_d, b_d, c_d, b_vars_d, nb_vars_d] = mylp_dualize(z, A, b, c, b_vars, nb_vars)
    z_d       = -z;
    A_d       = -A';
    b_d       = -c;
    c_d       = -b;
    b_vars_d  = nb_vars;        % Swap basic and non-basic to maintain index...
    nb_vars_d = b_vars;         % ...correspondence.
end
