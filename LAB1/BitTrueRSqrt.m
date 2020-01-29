%% RSQRT Bit-True Verification
% Authors: Andy Kirby & Cameron Blegen
%
% Performs bit-true RSqrt operations.

%% Set fixed point properties
W = 16; % Whole number portion
F = 8; % Fractional portion
tests = 1000;
input_filename = 'input.txt';
test_filename = 'matlab_results.txt';
results_filename = 'vhdl_results.txt';

Fm = fimath('RoundingMethod'        ,'Zero',... %'Floor',...???
            'OverflowAction'        ,'Wrap',...
            'ProductMode'           ,'SpecifyPrecision',...
            'ProductWordLength'     ,4*W,...
            'ProductFractionLength' ,4*F,...
            'SumMode'               ,'SpecifyPrecision',...
            'SumWordLength'         ,4*W,...
            'SumFractionLength'     ,4*F,...
            'CastBeforeSum'        ,1);

% Create a test vector
% test_vector = generateTestVector(W, F, Fm, input_filename, tests);

% Create bit-true solutions (as computed using the fi toolbox)
solutions = generateSolutions(W, F, Fm, test_vector, 3, test_filename);

% Test the results
compareResults(input_filename, test_filename, results_filename);

%% %% %% %% %% %% %% %% %% %% FUNCTIONS %% %% %% %% %% %% %% %% %% %% %% %%

% Compares the contents of each file, displaying the results
function compareResults(input, vhdl, matlab)
    in_id = fopen(input); input = textscan(in_id,'%s'); input = input{1}; fclose(in_id);
    v_id = fopen(vhdl); vhdl = textscan(v_id,'%s'); vhdl = vhdl{1}; fclose(v_id);
    m_id = fopen(matlab); matlab = textscan(m_id,'%s'); matlab = matlab{1}; fclose(m_id);
    
    num_misses = 0;
    for i = 1:length(input)
        if ~strcmp(vhdl{i}, matlab{i})
            disp(horzcat('MISMATCH: INPUT: ', input{i}, ' VHDL: ', vhdl{i}, ' MATLAB: ', matlab{i}))
            num_misses = num_misses + 1;
        end
    end
    
    disp(horzcat('Comparison finished. Total misses: ', num2str(num_misses)))
end

%% ------------------------------------------------------------------------
% Compute a given number of iterations of Newton's method
function [y] = newtonIterationBlock(guess, x, num_iterations, W, F, Fm)
    y = newtonIteration(guess, x, W, F, Fm);
    for i = 2:num_iterations
        y = newtonIteration(y, x, W, F, Fm);
    end
end

%% ------------------------------------------------------------------------
% Compute one iteration of Newton's method of computing the rsqrt.
% Follow y_n+1 = y_n(3-x*y_n^2) / 2
% Remains bit-true to the operations going on in our vhdl implementation.
function [y] = newtonIteration(y_n, x, W, F, Fm)
    ypow2 = y_n * y_n;
    ynx = fi(3, 0, W*3, F*3, Fm) - ypow2 * x;
    ynynx = y_n * ynx;
    y_large = ynynx / 2;
    y = fi(y_large, 0, W, F, Fm);
   % y.bin = y.bin((3*F):(W+3*F))
end

%% ------------------------------------------------------------------------
% A function to generate and output the solutions to the test vector
function [solutions] = generateSolutions(W, F, Fm, test_vector, num_iterations, output_filename)
    solutions = cell(length(test_vector),1);
    for i = 1:length(test_vector)
        yo_fi = fi([], 0, W, F, Fm);
        yo_fi.bin = test_vector{i};
        x_fi = fi([], 0, W, F, Fm);
        x_fi.bin = '0000000010000000';
        result = newtonIterationBlock(yo_fi, x_fi, num_iterations, W, F, Fm);
        solutions{i} = result.bin;
    end
    
    writecell(solutions, output_filename);
end

%% ------------------------------------------------------------------------
% A function to generate and output a test vector with the given number of
% tests.
function [test_vector] = generateTestVector(W, F, Fm, filename, num_tests)

    %% Set test case properties
    max_val = 2^(W) - 1;
    if strcmp(num_tests, 'full')
        num_tests = max_val;
    end
    interval = max_val / num_tests;
    example_fi = fi(Fm); %fi([], 0, F, Fm);
    

    %% Create test vector
    test_vector = cell(num_tests, 1);
    for i = 1:num_tests
       number = ((i-1)*interval/(2^F));
       fixed_point = fi(number, 0, W, F, Fm);
       test_vector(i) = {bin(fixed_point)};
    end

    %% Output test vector
    writecell(test_vector, filename);
end
