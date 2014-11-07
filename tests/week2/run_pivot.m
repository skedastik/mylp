addpath("../");
addpath("../../");

test_dir = "part1TestCases/assignmentParts/";
output_dir = "part1-output/";

for i = 1:5
    fname = ["part" mat2str(i) ".dict"];
    
    [z0, A, b, c, b_vars, nb_vars] = mylp_load([test_dir fname]);
    
    [z, ~,~,~,~,~, errnum, ~, enter, leave] = ...
        mylp_pivot(z0, A, b, c, b_vars, nb_vars, @mylp_bland);
    
    fid = fopen([output_dir fname ".out"], "w");
    
    if (errnum == 0)
        fputs(fid, [mat2str(enter) "\n"]);
        fputs(fid, [mat2str(leave) "\n"]);
        fputs(fid, mat2str(z));
    else
        fputs(fid, "UNBOUNDED");
    end
    
    fclose(fid);
end

printf("Done.\n");
