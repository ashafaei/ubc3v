function [ ] = render_multicam( instance, mapper )
% Example:
% instances = load_multicam('easy-pose', 'train', 1, 1:10);
% render_multicam(instances(1));

% It's not efficient to load the depth map every single time we want to
% visualize the data. The following code tries to take care of that.
if nargin < 2,
    if evalin('base', 'exist(''mapper'', ''var'')')
        mapper = evalin('base', 'mapper');
    else
        warning('Loading the default mapper');
        map_file = load('mapper.mat');
        mapper = map_file.mapper;
        assignin('base', 'mapper', mapper);
    end
end

% make sure we're dealing with the right data.
assert(numel(mapper)==1 || numel(mapper)==512*424, 'Bad input mapper');
assert(numel(instance)==1, 'One input at a time');

% Let's generate the cloud for our multicam instance.
clouds = generate_cloud_instance(instance, mapper);

% And now the groundtruth pose.
pose = get_pose(instance);

% Ok, show time.
figure;
for c=1:numel(clouds),
    subplot(2, numel(clouds), c);
    showPointCloud(clouds(c).cloud); cameratoolbar('SetCoordSys','y')
    hold on; draw_pose(pose); hold off;
    title(clouds(c).name);
    subplot(2, numel(clouds), c+numel(clouds));
    showPointCloud(clouds(c).cloud, clouds(c).colors); cameratoolbar('SetCoordSys','y')
    hold on; draw_pose(pose); hold off;
    title(clouds(c).name);
end
allp = cell2mat({clouds.cloud}');
figure;
subplot(1, 2, 1); showPointCloud(allp);
                    draw_pose(pose); cameratoolbar('SetCoordSys','y')
allc = cell2mat({clouds.colors}');
subplot(1, 2, 2); showPointCloud(allp, allc);
                    draw_pose(pose); cameratoolbar('SetCoordSys','y')
figure; showPointCloud(allp, allc); cameratoolbar('SetCoordSys', 'y');
end
