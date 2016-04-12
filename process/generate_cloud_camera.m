function [ cloud, labels, cloud_full, labels_full, mask ] = generate_cloud_camera( camera, mapper )
%GENERATE_CLOUD_CAMERA generates the cloud data for a camera

if numel(mapper) == 1,
    xmap = mapper.xmap;
    ymap = mapper.ymap;
else
    xmap = reshape([mapper(:, :).x], [424 512]);
    ymap = reshape([mapper(:, :).y], [424 512]);
    xmap = flip(xmap, 2);
end

if isfield(camera, 'class_image')
    if islogical(camera.class_image.alpha)
        mask = camera.class_image.alpha;
    else
        mask = camera.class_image.alpha==255;
    end
else
    mask = camera.depth_image.alpha==255;
end

cloud = zeros([424 512 3]);

% Input from Maya
zdepth = convert_to_zdepth(camera.depth_image.cdata);
cloud(:, :, 3) = zdepth(:, :);
cloud(:, :, 1) = xmap .* cloud(:, :, 3);
cloud(:, :, 2) = ymap .* cloud(:, :, 3);
translate_vals = camera.translation;

% This procedure determine the correct
% rotation for Maya space -> Kinect space.
% found with trial and error!
rotyx = camera.rotation(1);
if rotyx > 0,
    rotyx = 180-rotyx;
else
    rotyx = -rotyx;
end
rotyy = camera.rotation(2);
if prod(translate_vals([1 3])) >0,
    if rotyy < 0,
        rotyy = -rotyy;
    else
        rotyy = -180+rotyy;
    end
else
    if rotyy < 0,
        rotyy = -180+rotyy;
    else
        rotyy = -rotyy;
    end
end

np = reshape(cloud, [424*512 3]);
rot_mat =   rotz(0*camera.rotation(3)) ...
            * roty(rotyy) ...
            * rotx(rotyx);
% Don't have to apply it on all, can be sped up.
np = np * rot_mat';
cloud_full = bsxfun(@plus, np, translate_vals);

cloud = cloud_full(mask(:), :);
if isfield(camera, 'class_image')
    [~, labels_full] = get_classes_from_image(camera.class_image);
else
    labels_full = zeros(size(cloud_full, 1), 1);
end
labels_full = labels_full(:);
labels = labels_full(mask(:));
end

