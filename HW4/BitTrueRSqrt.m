%% RSQRT Bit-True Verification
% Authors: Andy Kirby & Cameron Blegen
%
% Performs bit-true RSqrt operations.

%% Set fixed point properties
W = 16; % Whole number portion
F = 8; % Fractional portion
tests = 20000;
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
% solutions = generateSolutions(W, F, Fm, test_vector, 3, test_filename);

% Test the results
compareResults(input_filename, test_filename, results_filename, W, F, Fm, 1);

%% %% %% %% %% %% %% %% %% %% FUNCTIONS %% %% %% %% %% %% %% %% %% %% %% %%

% Compares the contents of each file, displaying the results
function compareResults(input, matlab, vhdl, W, F, Fm, verbose)
    in_id = fopen(input); input = textscan(in_id,'%s'); input = input{1}; fclose(in_id);
    v_id = fopen(vhdl); vhdl = textscan(v_id,'%s'); vhdl = vhdl{1}; fclose(v_id);
    m_id = fopen(matlab); matlab = textscan(m_id,'%s'); matlab = matlab{1}; fclose(m_id);
    
    num_misses = 0;
    for i = 1:length(input)
        % Convert file values to doubles for easy displaying
        in = fi([], 0, W, F, Fm); v = fi([], 0, W, F, Fm); m = fi([], 0, W, F, Fm);
        in.bin = input{i}; v.bin = vhdl{i}; m.bin = matlab{i};
        if ~strcmp(vhdl{i}, matlab{i})
            if verbose
            disp(horzcat('MISMATCH (TEST ', num2str(i), ')', ...
                ': INPUT: ', input{i}, '--', num2str(in.double), ...
                '       VHDL: ', vhdl{i}, '--', num2str(v.double), ...
                '       MATLAB: ', matlab{i}, '--', num2str(m.double)))
            end
            num_misses = num_misses + 1;
        else
            if verbose
            disp(horzcat('MATCH (TEST ', num2str(i), ')', ...
                ': INPUT: ', input{i}, '--', num2str(in.double), ...
                '       VHDL: ', vhdl{i}, '--', num2str(v.double), ...
                '       MATLAB: ', matlab{i}, '--', num2str(m.double)))
            end
        end
    end
    
    disp(horzcat('Comparison finished. Total matches: ', num2str(length(input)-num_misses), ' Total misses: ', num2str(num_misses)))
end

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

%% ------------------------------------------------------------------------
% A function to generate and output the solutions to the test vector
function [solutions] = generateSolutions(W, F, Fm, test_vector, num_iterations, output_filename)
    solutions = cell(length(test_vector),1);
    for i = 1:length(test_vector)
        x_fi = fi([], 0, W, F, Fm);
        x_fi.bin = test_vector{i};
        yo_fi = fi([], 0, W, F, Fm);
        yo_fi.bin = '0000000010000000';
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
