clear all;
close all;
clc;

global num_tests = 110;

function [ms, ns] = mylp_profile(analysis_func, rule_name)
    global num_tests;
    
    iterations = zeros(num_tests, 1);
    stalls     = zeros(num_tests, 1);
    ms         = zeros(num_tests, 1);
    ns         = zeros(num_tests, 1);
    
    for i = 0:num_tests-1
        fname = ["test" mat2str(i) ".dict"];
    
        [z0, A, b, c, b_vars, nb_vars] = mylp_load(["moreUnitTests/" fname]);
    
        [~,~,~,~,~,~,~,~, info] = ...
            mylp(z0, A, b, c, b_vars, nb_vars, analysis_func);
            
        [m,n] = size(A);
        
        iterations(i+1) = info.iterations;
        stalls(i+1)     = info.stalls;
        ms(i+1)         = m;
        ns(i+1)         = n;
    end
    
    total_iterations = sum(iterations);
    stall_percentage = (sum(stalls) / total_iterations) * 100;
    
    printf("%-32s%-16d%-16.2f\n", rule_name, total_iterations, stall_percentage);
end

printf("Profiling simplex over %d tests...\n\n", num_tests);
printf("%-32s%-16s%-16s\n", "Heuristic", "# Pivots", "% Stall");
printf("-------------------------------------------------------\n");

[ms, ns] = mylp_profile(@mylp_bland, "Bland's Rule");
mylp_profile(@mylp_dantzig, "Largest Coefficient");

printf("\n%-32sStd. Dev.\n", "Average dictionary size");
printf("-------------------------------------------------------\n");
printf("m = %-28.2f%.2f\n", mean(ms), std(ms));
printf("n = %-28.2f%.2f\n", mean(ns), std(ns));

printf("\nDone.\n");
