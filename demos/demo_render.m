close all;

% First we need to load some examples.
% Let's take sequences 1 to 10 from the train set of the easy-pose dataset.
% Each dataset has a sub-collection, we load the sub-collection 150.
instances = load_multicam('easy-pose', 'train', 150, 1:10);

%% The Raw Data

% Each instance has the data from each camera and the grountruth posture.
% Let's pick a random frame and show the raw data.
target_frame = randi(10);
instance = instances(target_frame);

figure(1);
% Show the depth images.
subplot(2, 3, 1); imagesc(instance.Cam1.depth_image.cdata); colormap(gray);
subplot(2, 3, 2); imagesc(instance.Cam2.depth_image.cdata); colormap(gray);
subplot(2, 3, 3); imagesc(instance.Cam3.depth_image.cdata); colormap(gray);
% Show the groundtruth images.
subplot(2, 3, 4); imshow(instance.Cam1.class_image.cdata);
subplot(2, 3, 5); imshow(instance.Cam2.class_image.cdata);
subplot(2, 3, 6); imshow(instance.Cam3.class_image.cdata);

%% Processed data

% Now we need the depth map matrix from Kinect 2. This toolkit includes a
% copy in ./metadata/mapper.mat; The depth map is used to reconstruct 3d
% point cloud from the depth images.
map_file = load('mapper.mat');
mapper = map_file.mapper;
clear map_file;

render_multicam(instances(8), mapper);
