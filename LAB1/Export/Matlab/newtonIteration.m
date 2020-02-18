%% ------------------------------------------------------------------------
% Compute one iteration of Newton's method of computing the rsqrt.
% Follow y_n+1 = y_n(3-x*y_n^2) / 2
% Remains bit-true to the operations going on in our vhdl implementation.
function [y] = newtonIteration(y_n, x, W, F, Fm)

    % Force word results size
    Fm.ProductWordLength = W*2;
    Fm.ProductFractionLength = F*2;
    Fm.SumWordLength = W*2;
    Fm.SumFractionLength = F*2;
    % Make sure the operands obey this scheme
    y_n = fi(y_n, 0, W, F, Fm);
    % Compute
    ypow2 = y_n * y_n;
   
    % Force word results size
    Fm.ProductWordLength = W*3;
    Fm.ProductFractionLength = F*3;
    Fm.SumWordLength = W*3;
    Fm.SumFractionLength = F*3;
    % Make sure the operands obey this scheme
    ypow2 = fi(ypow2, 0, W*2, F*2, Fm);
    x = fi(x, 0, W, F, Fm);
    % Compute
    % ypow2_cut = fi(ypow2, 0, W*2, F*2, Fm);
    if (ypow2.double * x.double) > 3
        disp("y0 wasn't close enough, ypow2*x > 3!!!!!");
    end
    ynx = fi(3, 0, W*3, F*3, Fm) - ypow2 * x;
    
    % Force word results size
    Fm.ProductWordLength = W*4;
    Fm.ProductFractionLength = F*4;
    Fm.SumWordLength = W*4;
    Fm.SumFractionLength = F*4;
    % Make sure the operands obey this scheme
    ynx = fi(ynx, 0, W*3, F*3, Fm);
    y_n = fi(y_n, 0, W, F, Fm);
    % Compute
    %ynx_cut = fi(ynx, 0, W*3, F*3, Fm);
    ynynx = y_n * ynx;
    y_large = ynynx / 2;
    
    % Cut back down to size
    y = fi(y_large, 0, W, F, Fm); % Should just take needed bits (check if it does this?)
   % y.bin = y.bin((3*F):(W+3*F))
end