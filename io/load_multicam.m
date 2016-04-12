function [ instances ] = load_multicam( dataset, group_name, section_number, optional_frames)
% LOAD_MULTICAM loads from the multicam datasets.
% load_multicam('easy-pose', 'train', 1, 1:10), reads frames 1 to 10 from
% the train set of easy-pose. the section_number corresponds to the
% sub-collection number; each collection has 1001 frames. If you don't
% specify the frames, we load all the 1001 frames (takes longer).

home_path = get_ref(dataset);

% This is specific to the UBC3V datasets.
depth = 'depthRender';
class = 'groundtruth';
file_format = 'mayaProject.%06d.png';

base_path = [home_path group_name '/' num2str(section_number) '/'];

depth_path = [base_path 'images/' depth '/%s/' file_format];
class_path = [base_path 'images/' class '/%s/' file_format];
depth_path = strrep(depth_path, '\', '\\');
class_path = strrep(class_path, '\', '\\');

fprintf('Loading groundtruth file %d ...', section_number);
groundtruth_file = load([base_path 'groundtruth.mat']);
fprintf('\n');

camera_names = fieldnames(groundtruth_file.cameras);
fprintf('\t Identified %d cameras\n', numel(camera_names));

image_names = dir([base_path 'images/' depth '/' camera_names{1} '/*.png']);
fprintf('\t Expecting %d frames\n', numel(image_names));

if nargin < 3,
    optional_frames = 1:numel(image_names);
end

instances = struct();
camera_base = struct('translation', [], 'rotation', [], 'depth_image', [], 'class_image', []);
for i=1:numel(camera_names),
    instances.(camera_names{i})=camera_base;
end
instances.posture = [];
instances(1:numel(image_names)) = instances;

tic;
fprintf('\t Loading data ... ');
for i=optional_frames,
    for c=1:numel(camera_names),
        instances(i).(camera_names{c}).translation =groundtruth_file.cameras.(camera_names{c}).frames{i}.translate;
        instances(i).(camera_names{c}).rotation = groundtruth_file.cameras.(camera_names{c}).frames{i}.rotate;
        instances(i).(camera_names{c}).depth_image = importdata(sprintf(depth_path, camera_names{c}, i));
        instances(i).(camera_names{c}).depth_image.cdata = instances(i).(camera_names{c}).depth_image.cdata(:,:,1);
        instances(i).(camera_names{c}).class_image = importdata(sprintf(class_path, camera_names{c}, i));
    end
    instances(i).posture = groundtruth_file.joints{i};
end
fprintf('Finished reading in %.2fs\n', toc);

end

