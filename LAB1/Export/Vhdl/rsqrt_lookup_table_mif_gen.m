%--------------------------------------------------------------------------
% Description:  Matlab script to create the lookup table used in creating
% the initial guess y0 to start Newtons Method for y = 1/sqrt(x);
%--------------------------------------------------------------------------
% Author:       Ross K. Snider
% Company:      Montana State University
% Create Date:  March 20, 2014
% Script Name:  rsqrt.m
% Tool Version: MATLAB: 8.2.0.701 (R2013b)
% Revision:     1.0
%--------------------------------------------------------------------------
% Copyright (c) 2013 Ross K. Snider.
% All rights reserved. Redistribution and use in source and binary forms 
% are permitted provided that the above copyright notice and this paragraph 
% are duplicated in all such forms and that any documentation, advertising 
% materials, and other materials related to such distribution and use 
% acknowledge that the software was developed by Montana State University 
% (MSU).  The name of MSU may not be used to endorse or promote products 
% derived from this software without specific prior written permission.
% THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
% IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. 
%--------------------------------------------------------------------------

clear all
close all
%-----------------------------------------------
% Newton's Method for y = 1/sqrt(x);
% Define F(y) = 1/(y^2) - x.
% Find F(y) = 0;
% Solution: y(k+1) = (y(k)*(3-x*y(k)^2))/2  where y0 is the initial guess
%------------------------------------------------

%-----------------------------------------
% Create lookup table for (x_beta)^(-3/2)
%-----------------------------------------
Nbits_address = 8;  % How many fraction bits will be used as the address?
Nbits_output_fraction  = 12;  % The number of fractional bits in result.  The output word size will be Nbits_output + 1, since we need a bit for the 2^0 position.
Nwords = 2^Nbits_address
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
%     i
%     x_beta_table{i+1}
%     pause
end

%----------------------------------------------------
% Create the Altera .mif file for the lookup table
%----------------------------------------------------
fid = fopen('rsqrt_table.mif','w');
%------------------------------------
% Write File Header
%------------------------------------
line = ['DEPTH = ' num2str(2^Nbits_address) ';'];  % The size of memory in words
fprintf(fid,'%s\n',line);
line = ['WIDTH = ' num2str(Nbits_output_fraction+1) ';']; % The size of data in bits
fprintf(fid,'%s\n',line);
line = ['ADDRESS_RADIX = BIN;'];  % The radix for address values
fprintf(fid,'%s\n',line);
line = ['DATA_RADIX = BIN;'];  % The radix for data values
fprintf(fid,'%s\n',line);
line = ['CONTENT'];  
fprintf(fid,'%s\n',line);
line = ['BEGIN'];  
fprintf(fid,'%s\n',line);  % start of (address : data pairs)
%------------------------------------
% Write Memory Data
%------------------------------------
for data_index = 1:Nwords
    line = [x_beta_table{data_index}.input_bits ' : ' x_beta_table{data_index}.output_bits ';   -- ' num2str(data_index) ' : (' num2str(x_beta_table{data_index}.input_value) ')^(-3/2)=' num2str(x_beta_table{data_index}.output_value) ];
    fprintf(fid,'%s\n',line);
end
%------------------------------------
% Write File End
%------------------------------------
line = ['END;'];  
fprintf(fid,'%s\n',line);  % start of (address : data pairs)
%------------------------------------
% Close File
%------------------------------------
fclose(fid);











