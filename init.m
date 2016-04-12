%% The init script
% You just need to run it once.

add_path = @(x) addpath(genpath(x));

add_path('./io/');
add_path('./metadata/');
add_path('./demos/');
add_path('./viz/');
add_path('./process/');
