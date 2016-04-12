function [ output_args ] = convert_to_zdepth( input_args )
%CONVERT_TO_ZDEPTH generates the z values from the image inputs of UBC3v.

% The 8-bit band encompasses the range 50 to 800 cm.
output_args = (double(input_args(:, :, 1))./255 .* (800-50) + 50)*1.03;
end

