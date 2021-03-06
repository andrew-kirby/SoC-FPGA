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
    
%     disp(horzcat('A: ', num2str(A))) %test
    
    %Compute Xa
    Fm.ProductWordLength = W*3;
    Fm.ProductFractionLength = F+W*2;
    Fm.SumWordLength = W*3;
    Fm.SumFractionLength = F+W*2;
%     Fm.ProductWordLength = W;
%     Fm.ProductFractionLength = F;
%     Fm.SumWordLength = W;
%     Fm.SumFractionLength = F;
%     
    x_large = fi(x, 0, W*3, F+W*2, Fm);
    Xa = x_large * 2^A;
%     Xa = x * 2^A;
    
%     Xa = fi(Xa, 0, W, F, Fm);
    
    % Xa and Xb
    % Force word results size
    Fm.ProductWordLength = W;
    Fm.ProductFractionLength = F;
    Fm.SumWordLength = W;
    Fm.SumFractionLength = F;
    
    Xb = x * 2^(-B);
    
    Xb = fi(Xb, 0, W, F, Fm);
    
    % Get table attributes
    addr_bits = table{end-1};
    if F < addr_bits
       addr_bits = F; 
    end
    precision = table{end};
    
    % Lookup in table
    binary = Xb.bin;
%     disp(horzcat('Xb: ', Xb.bin)) %test
    address = binary(length(binary)-F+1:length(binary)-F+addr_bits);
%     disp(horzcat('address: ', address)) %test
    address = bin2dec(address);
    Xb_exp_bits = table{address+1}.output_bits;
%     disp(horzcat('table result: ', Xb_exp_bits)) %test
    
    % Force word results size
    Fm.ProductWordLength = W*3+precision+1;
    Fm.ProductFractionLength = F+W*2+precision+1;
    Fm.SumWordLength = W*3+precision+1;
    Fm.SumFractionLength = F+W*2+precision+1;
%     Fm.ProductWordLength = W+precision+1;
%     Fm.ProductFractionLength = F+precision+1;
%     Fm.SumWordLength = W+precision+1;
%     Fm.SumFractionLength = F+precision+1;
    % Make sure the operands obey this scheme
    Xb_exp = fi([], 0, precision+1, precision, Fm);
    Xb_exp.bin = Xb_exp_bits;
    
    Xa = fi(Xa, 0, W*3, F+W*2, Fm);
%     Xa = fi(Xa, 0, W, F, Fm);
%     disp(horzcat('Xa: ', Xa.bin)) %test
    
    % Compute y0
    y0 = Xa * Xb_exp;
    
    % Last check for odd Beta
    if mod(B, 2) % odd
         % Force word results size
        Fm.ProductWordLength = W*3+precision+1+16;
        Fm.ProductFractionLength = F+W*2+precision+16;
        Fm.SumWordLength = W*3+precision+1+16;
        Fm.SumFractionLength = F+W*2+1+precision+16;
%         Fm.ProductWordLength = W+precision+1+16;
%         Fm.ProductFractionLength = F+precision+16;
%         Fm.SumWordLength = W+precision+1+16;
%         Fm.SumFractionLength = F+1+precision+16;
        % Make sure the operands obey this scheme
        y0 = fi(y0, 0, W*3+precision+1, F+W*2+precision+1, Fm); 
%         y0 = fi(y0, 0, W+precision+1, F+precision+1, Fm);       
        two_exp = fi([], 0, 16, 16, Fm);
        two_exp.bin = '1011010100000100';
        
        y0 = y0 * two_exp;
    end 
%     disp(horzcat('y0 (precast): ', num2str(y0.double))) %test
%     disp(horzcat('y0 (precast): ', y0.bin)) %test
    y0 = fi(y0, 0, W, F, Fm);
end