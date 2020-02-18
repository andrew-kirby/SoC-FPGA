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