%% ------------------------------------------------------------------------
% Compute a given number of iterations of Newton's method
function [y] = newtonIterationBlock(guess, x, num_iterations, W, F, Fm)
    y = newtonIteration(guess, x, W, F, Fm);
    for i = 2:num_iterations
        y = newtonIteration(y, x, W, F, Fm);
    end
%     disp('---')
%     disp(guess.double)
%     disp(x.double)
%     disp(y.double)
end