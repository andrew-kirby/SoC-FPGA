function [y0] = computeY0(x, table, W, F, Fm)

    % Determine leading zeros
    binary = x.bin;
    for Z = 0:length(x.bin)-1
        if binary(Z+1) ~= '0'
           break; 
        end     
    end
    % Beta
    B = W - F - Z - 1;
    % Alpha
    A = -2*B + 0.5*B;
    if mod(B, 2) % odd
        A = A+0.5;
    end
    % Xa and Xb
    % Force word results size
    Fm.ProductWordLength = W;
    Fm.ProductFractionLength = F;
    Fm.SumWordLength = W;
    Fm.SumFractionLength = F;
    
    Xa = x * 2^A;    
    Xb = x * 2^(-B);
    
    Xa = fi(Xa, 0, W, F, Fm);
    Xb = fi(Xb, 0, W, F, Fm);
    
    % Get table attributes
    addr_bits = table{end-1};
    if F < addr_bits
       addr_bits = F; 
    end
    precision = table{end};
    
    % Lookup in table
    binary = Xb.bin;
    address = binary(length(binary)-F+1:length(binary)-F+addr_bits);
    address = bin2dec(address);
    Xb_exp_bits = table{address+1}.output_bits;
    
    % Force word results size
    Fm.ProductWordLength = W+precision+1;
    Fm.ProductFractionLength = F+precision+1;
    Fm.SumWordLength = W+precision+1;
    Fm.SumFractionLength = F+precision+1;
    % Make sure the operands obey this scheme
    Xb_exp = fi([], 0, precision+1, precision, Fm);
    Xb_exp.bin = Xb_exp_bits;
    
    Xa = fi(Xa, 0, W, F, Fm);
    
    % Compute y0
    y0 = Xa * Xb_exp;
    % Last check for odd Beta
    if mod(B, 2) % odd
         % Force word results size
        Fm.ProductWordLength = W+precision+1+16;
        Fm.ProductFractionLength = F+precision+16;
        Fm.SumWordLength = W+precision+1+16;
        Fm.SumFractionLength = F+precision+16;
        % Make sure the operands obey this scheme
        y0 = fi(y0, 0, W+precision+1, F+precision+1, Fm);       
        two_exp = fi([], 0, 16, 16, Fm);
        two_exp.bin = '1011010100000100';
        
        y0 = y0 * two_exp;
    end 
    y0 = fi(y0, 0, W, F, Fm);
end