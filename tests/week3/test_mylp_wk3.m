% clear all;
% close all;
% clc;
%
% addpath("../");
% addpath("../../");
%
% function testDir(unittest_dir)
%     for i = 0:0
%         fname = ["test" mat2str(i) ".dict"]
%
%         [z0, A, b, c, b_vars, nb_vars] = mylp_load([unittest_dir fname]);
%
%         [z0, ~,~,~,~,~, errnum, ~,~] = ...
%             mylp(z0, A, b, c, b_vars, nb_vars, @mylp_bland);
%
%         fid = fopen([unittest_dir fname ".output"]);
%         token = fgetl(fid);
%
%         if (strcmp(token, "UNBOUNDED"))
%             test_assert(fname, errnum, 1);
%         elseif (strcmp(token, "INFEASIBLE"))
%             test_assert(fname, errnum, 2);
%         else
%             objective_ans = sscanf(token, "%f", [1,1]);
%             test_assert(fname, [z0], [objective_ans]);
%         end
%
%         fclose(fid);
%     end
% end
%
% testDir("part3TestCases/unitTests/10/");
%
% printf("Done.\n");


clear all;
close all;
clc;

addpath("../");
addpath("../../");

function testDir(unittest_dir)
    for i = 0:99
        fname = ["test" mat2str(i)];
        
        [z0, A, b, c, b_vars, nb_vars] = mylp_load([unittest_dir fname ".dict"]);

        [z0, ~,~,~,~,~, errnum, ~,~] = ...
            mylp(z0, A, b, c, b_vars, nb_vars, @mylp_bland);

        fid = fopen([unittest_dir fname ".output"]);
        token = fgetl(fid);

        if (strcmp(token, "UNBOUNDED"))
            test_assert(fname, errnum, 1);
        elseif (strcmp(token, "INFEASIBLE"))
            test_assert(fname, errnum, 2);
        else
            objective_ans = sscanf(token, "%f", [1,1]);
            test_assert(fname, [z0], [objective_ans]);
        end

        fclose(fid);
    end
end

testDir("part3TestCases/unitTests/10/");

printf("Done.\n");
