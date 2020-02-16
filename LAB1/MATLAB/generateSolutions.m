%% ------------------------------------------------------------------------
% A function to generate and output the solutions to the test vector
function [solutions, solutions_fis] = generateSolutions(W, F, Fm, test_vector, num_iterations, table, output_filename)
    H = waitbar(0);
    solutions = cell(length(test_vector),1);
    solutions_fis = cell(length(test_vector),1);
    for i = 1:200%length(test_vector)
        x_fi = fi([], 0, W, F, Fm);
        x_fi.bin = test_vector{i};
        result = rsqrt(x_fi, table, num_iterations, W, F, Fm);
        disp(result.double)
        solutions_fis{i} = result;
        solutions{i} = result.bin;
        msg = horzcat('Generating solution ', num2str(i), ' of ', num2str(length(test_vector)), '...');
        waitbar(i/length(test_vector), H, msg);
    end
    
    writecell(solutions, output_filename);
    delete(H);
end