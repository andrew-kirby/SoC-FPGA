%% RSQRT Bit-True Verification
% Authors: Andy Kirby & Cameron Blegen
%
% Performs bit-true RSqrt operations.

%% Set fixed point properties
W = 8; % Whole number portion
F = 8; % Fractional portion

Fm = fimath('RoundingMethod'        ,'Zero',... %'Floor',...???
            'OverflowAction'        ,'Wrap',...
            'ProductMode'           ,'SpecifyPrecision',...
            'ProductWordLength'     ,W,...
            'ProductFractionLength' ,F,...
            'SumMode'               ,'SpecifyPrecision',...
            'SumWordLength'         ,W,...
            'SumFractionLength'     ,F);

%% Set test case properties
NUM_TESTS = 2^(W + F);

%% Create test vector
test_vector = zeros(NUM_TESTS, 1);
for i = 1:NUM_TESTS
   test_vector(i) = i-1;
   test_vector(i) = i / (2^F);
end


%% Output test vector

%% Output test solutions


% a = fi(v,s,w,f,F) returns a fixed-point object with value v, signed property value s, wordlength w, fraction-length f and embedded.fimath F.
% 
%
