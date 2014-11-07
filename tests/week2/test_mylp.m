clear all;
close all;
clc;

addpath("../../");

unittest_dir = "part2TestCases/unitTests/";

for i = 1:10
    fname = ["dict" mat2str(i)];
    
    [z0, A, b, c, b_vars, nb_vars] = mylp_load([unittest_dir fname]);
    
    [z0, ~,~,~,~,~, errnum, ~, info] = ...
        mylp(z0, A, b, c, b_vars, nb_vars, @mylp_bland);
    
    fid = fopen([unittest_dir fname ".output"]);
    token = fgetl(fid);
    
    if (strcmp(token, "UNBOUNDED"))
        test_assert(fname, errnum, 1);
    else
        objective_ans = sscanf(token, "%f", [1,1]);
        pivots_ans = fscanf(fid, "%d", [1,1]);
        test_assert(fname, [z0, info.iterations], [objective_ans, pivots_ans]);
    end
    
    fclose(fid);
end

printf("Done.\n");
