%% ------------------------------------------------------------------------
% A function to generate and output the solutions to the test vector
function [solutions] = generateNewtonIterSolutions(W, F, Fm, test_vector, num_iterations, output_filename)
    solutions = cell(length(test_vector),1);
    for i = 1:length(test_vector)
        x_fi = fi([], 0, W, F, Fm);
        x_fi.bin = test_vector{i};
        yo_fi = fi([], 0, W, F, Fm);
        yo_fi.bin = '0000000010000000';
        result = newtonIterationBlock(yo_fi, x_fi, num_iterations, W, F, Fm);
        solutions{i} = result.bin;
    end
    
    writecell(solutions, output_filename);
end