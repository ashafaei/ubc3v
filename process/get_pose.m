function [ pose ] = get_pose( instance, skip_names)
% Make the reference pose from the instance.

joint_names = {'HeadPGX';'HipsPGX';
    'LeftArmPGX';'LeftFingerBasePGX';
    'LeftFootPGX';'LeftForeArmPGX';
    'LeftHandPGX';'LeftInHandIndexPGX';
    'LeftInHandThumbPGX';'LeftLegPGX';
    'LeftShoulderPGX';'LeftToeBasePGX';
    'LeftUpLegPGX';'Neck1PGX';
    'NeckPGX';'RightArmPGX';
    'RightFingerBasePGX';'RightFootPGX';
    'RightForeArmPGX';'RightHandPGX';
    'RightInHandIndexPGX';'RightInHandThumbPGX';
    'RightLegPGX';'RightShoulderPGX';
    'RightToeBasePGX';'RightUpLegPGX';
    'Spine1PGX';'SpinePGX'};

targets18 = { 'Head', 1;
        'Neck', 14;
        'Spine2', 24;
        'Spine1', 27;
        'Spine', 28;
        'Hip', 26;
        'RHip', 23;
        'RKnee', 18;
        'RFoot', 25;
        'LHip', 10; 
        'LKnee', 5;
        'LFoot', 12;
        'RShoulder', 19;
        'RElbow', 20;
        'RHand', 17;
        'LShoulder', 6;
        'LElbow', 7;
        'LHand', 4;
        };

pose = struct();

if nargin < 2 || isempty(skip_names),
    skip_names = false;
end

if isempty(instance),
   pose.joint_names = targets18(:, 1);
   return;
end

if isstruct(instance.posture),
    pose.joint_names = targets18(:, 1);
    if ~isempty(instance)
        pose.joint_locations = cell2mat(cellfun(@(x) instance.posture.(joint_names{x})(13:15), targets18(:, 2), 'UniformOutput', false));
    end
end

if skip_names,
    pose = rmfield(pose, 'joint_names');
    pose.joint_locations = single(pose.joint_locations);
end

end
