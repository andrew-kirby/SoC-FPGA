%% ------------------------------------------------------------------------
% A function to generate and output a test vector with the given number of
% tests.
function [test_vector, fis] = generateTestVector(W, F, Fm, filename, num_tests)
    H = waitbar(0);

    %% Set test case properties
    max_val = 2^(W) - 1;
    if strcmp(num_tests, 'full')
        num_tests = max_val;
    end
    interval = max_val / num_tests;
%     example_fi = fi(Fm); %fi([], 0, F, Fm);
    

    %% Create test vector
    test_vector = cell(num_tests, 1);
    fis = cell(num_tests, 1);
%     for i = 1:num_tests
    for i = 1:num_tests
       msg = horzcat('Generating test ', num2str(i), ' of ', num2str(num_tests), '...');
       waitbar(i/num_tests, H, msg);
       number = ((i-1)*interval/(2^F));
       fixed_point = fi(number, 0, W, F, Fm);
       fis(i) = {fixed_point};
       test_vector(i) = {bin(fixed_point)};
    end
    %% Manual test vectors
%     fixed_point = fi(number, 0, W, F, Fm);
%     fixed_point.bin = ''
%     fis(i) = {fixed_point};
%     test_vector(i) = {bin(fixed_point)};
    
    %% Output test vector
    writecell(test_vector, filename);
    delete(H)
end