%% ------------------------------------------------------------------------
% A function to generate and output a test vector with the given number of
% tests.
function [test_vector, fis] = generateTestVector(W, F, Fm, filename, num_tests)
    H = waitbar(0);    

    %% Create test vector
    test_vector = cell(num_tests, 1);
    fis = cell(num_tests, 1);
    
    % Test edge cases
    fixed_point = fi(0, 0, W, F, Fm);
    i = 1;
    % Starting Values
    fixed_point.bin(1:end) = '0'; fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)}; i = i+1;
    fixed_point.bin(1:end) = '0'; fixed_point.bin(end-1:end) = '1'; fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)}; i = i+1;
    fixed_point.bin(1:end) = '0'; fixed_point.bin(end-2:end) = '1'; fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)}; i = i+1;
    fixed_point.bin(1:end) = '0'; fixed_point.bin(end-5:end) = '1'; fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)}; i = i+1;
    % Ending Values
    fixed_point.bin(1:end) = '0'; fixed_point.bin(1) = '1'; fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)}; i = i+1;
    fixed_point.bin(1:end) = '0'; fixed_point.bin(1:5) = '1'; fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)}; i = i+1;
    fixed_point.bin(1:end) = '0'; fixed_point.bin(5:6) = '1'; fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)}; i = i+1;
    fixed_point.bin(1:end) = '1'; fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)}; i = i+1;
    % Random values
    for i = i:num_tests
       msg = horzcat('Generating test ', num2str(i), ' of ', num2str(num_tests), '...');
       waitbar(i/num_tests, H, msg);
       % Create random binary string
       binary = randi([0 1], 1, W);
       binary = num2str(binary);
       binary = binary(binary ~= ' ');
       fixed_point = fi(0, 0, W, F, Fm); fixed_point.bin = binary;
       fis(i) = {fixed_point}; test_vector(i) = {bin(fixed_point)};
    end
    %% Output test vector
    writecell(test_vector, filename);
    delete(H)
end