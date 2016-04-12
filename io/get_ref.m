function [ result ] = get_ref( reference )
%GET_REF Retrieves the reference

% Load the config.
config;

switch(reference)
    case 'easy-pose'
        result = easy_pose_path;
    case 'inter-pose'
        result = inter_pose_path;
    case 'hard-pose'
        result = hard_pose_path;
    otherwise
        error('Reference %s is not recognized', reference);
end

end

