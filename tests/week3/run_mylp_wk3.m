addpath("../");
addpath("../../");

test_dir = "part3TestCases/assignmentParts/";
output_dir = "part3-output/";

for i = 1:10
    fname = ["part" mat2str(i) ".dict"];
    
    [z0, A, b, c, b_vars, nb_vars] = mylp_load([test_dir fname]);
    
    [z, ~,~,~,~,~, errnum, ~,~] = ...
        mylp(z0, A, b, c, b_vars, nb_vars, @mylp_bland);
    
    fid = fopen([output_dir fname ".out"], "w");
    
    if (errnum == 0)
        fputs(fid, mat2str(z));
    elseif (errnum == 1)
        fputs(fid, "UNBOUNDED");
    elseif (errnum == 2)
        fputs(fid, "INFEASIBLE");
    end
    
    fclose(fid);
end

printf("Done.\n");
