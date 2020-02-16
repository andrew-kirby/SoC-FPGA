function [y] = rsqrt(x, table, num_iter, W, F, Fm)
    y0 = computeY0(x, table, W, F, Fm);
    disp(horzcat('y0: ', num2str(y0.double)))
    y = newtonIterationBlock(y0, x, num_iter, W, F, Fm);
end