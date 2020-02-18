function [table] = createXBLookupTable(Nbits_address, Nbits_output_fraction)

%-----------------------------------------
% Create lookup table for (x_beta)^(-3/2)
%-----------------------------------------
%     Nbits_address = 12;  % How many fraction bits will be used as the address?
%     Nbits_output_fraction  = 12;  % The number of fractional bits in result.  The output word size will be Nbits_output + 1, since we need a bit for the 2^0 position.
    Nwords = 2^Nbits_address;
    for i=0:(Nwords-1)  % Need to compute each memory entry (i.e. memory size)
        x_beta_table{i+1}.address = i;  % Memory Address
        fa = fi(i,0,Nbits_address,0);
        fa_bits = fa.bin;               % Memory Address in binary
        fb = fi(0, 0, Nbits_address+1, Nbits_address);  % Set number of bits for result
        fb.bin = ['1' fa_bits]; % set the value using the binary representation. The address is our input value 1 <= x_beta < 2  where the leading 1 has been added.
        x_beta_table{i+1}.input_value = double(fb);  % convert this binary input to it's double representation
        x_beta_table{i+1}.input_bits = fa.bin;  % keep track of the input bits
        fy = fi(double(fb)^(-3/2),0,Nbits_output_fraction+1,Nbits_output_fraction);  % compute (x_beta)^(-3/2) and convert to fixed-point 
        x_beta_table{i+1}.output_value = double(fy); % store the result as a double
        x_beta_table{i+1}.output_bits = fy.bin;   % store the resulting binary representation

    end
    table = x_beta_table;
end