function [y] = rsqrt(x, table, num_iter, W, F, Fm)
%     disp(horzcat('x: ', num2str(x.double)))
%     disp(horzcat('x: ', x.bin))
    y0 = computeY0(x, table, W, F, Fm);
%     disp(horzcat('y0: ', num2str(y0.double)))
%     disp(horzcat('y0: ', y0.bin))
    y = newtonIterationBlock(y0, x, num_iter, W, F, Fm);
end