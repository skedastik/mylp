clear all;
close all;
clc;

unittest_dir = "part1TestCases/unitTests/";

for i = 1:10
    fname = ["dict" mat2str(i)];
    
    [z0, A, b, c, b_vars, nb_vars] = mylp_load([unittest_dir fname]);
    
    [z0, ~,~,~,~,~, errnum, ~, enter, leave] = ...
        mylp_pivot(z0, A, b, c, b_vars, nb_vars, @mylp_bland);
    
    fid = fopen([unittest_dir fname ".output"]);
    token = fgetl(fid);
    
    if (strcmp(token, "UNBOUNDED"))
        test_assert(fname, errnum, 1);
    else
        enter_ans     = sscanf(token, "%d", [1,1]);
        leave_ans     = fscanf(fid, "%d", [1,1]);
        objective_ans = fscanf(fid, "%f", [1,1]);
        
        test_assert(fname, [enter, leave, z0], [enter_ans, leave_ans, objective_ans]);
    end
    
    fclose(fid);
end

printf("Done.\n");
