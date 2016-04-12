function [ camera_names_list ] = get_camera_names( instance )
%GET_CAMERA_NAMES Summary of this function goes here
%   Detailed explanation goes here
cameras = fieldnames(instance);
camera_names_list = cameras(cellfun(@(x) ~strcmp(x, 'posture'), cameras));

end

