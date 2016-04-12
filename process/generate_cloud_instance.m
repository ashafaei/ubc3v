function [ clouds ] = generate_cloud_instance( instance, mapper )
%GENERATE_CLOUD_instance generates cloud from a multicam instance

cameras = get_camera_names(instance);

clouds = struct('cloud', [], 'labels', [], 'name', [], 'full_cloud', [], 'full_colors', [], 'mask', [], 'colors', []);
clouds(1:numel(cameras)) = clouds;

for c=1:numel(cameras),
    clouds(c).name = cameras{c};
    [ cloud, labels, full_cloud, full_colors, mask ] = generate_cloud_camera( instance.(cameras{c}), mapper );
    clouds(c).cloud = cloud;
    clouds(c).labels = labels;
    clouds(c).full_cloud = full_cloud;
    clouds(c).full_colors = full_colors;
    clouds(c).mask = mask;
    if isfield(instance.(cameras{c}), 'class_image'),
        color = reshape(instance.(cameras{c}).class_image.cdata, [424*512 3]);
    else
        color = zeros(424*512, 3, 'uint8');
    end
    clouds(c).colors = color(mask(:), :);
end

end

