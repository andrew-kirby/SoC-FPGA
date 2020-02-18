%% RSQRT Bit-True Verification
% Authors: Andy Kirby & Cameron Blegen
%
% Performs bit-true RSqrt operations.

%% Set fixed point properties
W = 64; % Whole number portion
F = 32; % Fractional portion
%% Set other properties
tests = 1000;
input_filename = 'input.txt';
test_filename = 'matlab_results.txt';
results_filename = 'output.txt';
% results_filename = 'vhdl_results.txt';

% Fm = fimath('RoundingMethod'        ,'Zero',... %'Floor',...???
Fm = fimath('RoundingMethod'        ,'Floor',...
            'OverflowAction'        ,'Wrap',...
            'ProductMode'           ,'SpecifyPrecision',...
            'ProductWordLength'     ,4*W,...
            'ProductFractionLength' ,4*F,...
            'SumMode'               ,'SpecifyPrecision',...
            'SumWordLength'         ,4*W,...
            'SumFractionLength'     ,4*F,...
            'CastBeforeSum'        ,1);

%% Create a test vector
[test_vector, test_vector_fis] = generateTestVector(W, F, Fm, input_filename, tests);

%% Create lookup table
Xb_table_address_bits = 8;
Xb_table_precision_bits = 12;
Xb_lookup_table = createXBLookupTable(Xb_table_address_bits,Xb_table_precision_bits);
Xb_lookup_table = [Xb_lookup_table, Xb_table_address_bits, Xb_table_precision_bits];

%% Create bit-true solutions (as computed using the fi toolbox)
[solutions, solutions_fis] = generateSolutions(W, F, Fm, test_vector, 16, Xb_lookup_table, test_filename);

%% Test the results
clc
compareResults(input_filename, test_filename, results_filename, W, F, Fm, 1);

%% Check specific numbers
clc
disp('----------------------')
index = 3; % 21 starts good (1000 bad) (1500 good) (bad after 15000?)
num = test_vector_fis{index};
% num.bin = '0000000000000000000000000000000000000000000000000000000000000001';
num.bin = '000000000000000000000000000000000000000000000011111110000011111111';
% num.bin = '1111111111111111111111111111111111111111111111111111111111111111';
% num.bin = '1000000000000000000000000000000000000000000000000000000000000000';
disp(horzcat('Input double: ', num2str(num.double)))
disp(horzcat('Input binary: ', num.bin))
y = rsqrt(num, Xb_lookup_table, 16, W, F, Fm);
disp(horzcat('Computed Answer: ', num2str(y.double)))
disp(horzcat('Computed Answer: ', y.bin))
disp(horzcat('Double answer: ', num2str(1/sqrt(num.double))))
disp('-----------------------')






