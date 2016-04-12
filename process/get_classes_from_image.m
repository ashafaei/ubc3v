function [ classes, dense_labels ] = get_classes_from_image( input_image )
%GET_CLASSES_FROM_IMAGE converts the RGB image to dense classes indexed
% from 1

assert(isfield(input_image, 'cdata') && isfield(input_image, 'alpha'), 'Assure the input has cdata and alpha channels');
dense_labels = zeros(size(input_image.alpha), 'single');

color_map = [
    255 106 0
    255 0 0
    255 178 127
    255 127 127
    182 255 0
    218 255 127
    255 216 0
    255 233 127
    0 148 255
    72 0 255
    48 48 48
    76 255 0
    0 255 33
    0 255 255
    0 255 144
    178 0 255
    127 116 63
    127 63 63
    127 201 255
    127 255 255
    165 255 127
    127 255 197
    214 127 255
    161 127 255
    107 63 127
    63 73 127
    63 127 127
    109 127 63
    255 127 237
    127 63 118
    0 74 127
    255 0 110
    0 127 70
    127 0 0
    33 0 127
    127 0 55
    38 127 0
    127 51 0
    64 64 64
    73 73 73
    0 0 0
    191 168 247
    192 192 192
    127 63 63
    127 116 63
];

classes = struct('class', 0, 'indices', []);
n_classes = size(color_map, 1);
classes(1:n_classes) = classes;

color_map = int64(color_map);
R = int64(input_image.cdata(:, :, 1));
G = int64(input_image.cdata(:, :, 2));
B = int64(input_image.cdata(:, :, 3));

if islogical(input_image.alpha),
    alpha = input_image.alpha;
else
    alpha = input_image.alpha == uint8(255);
end

for i=1:n_classes,
    result = alpha & abs(R-color_map(i,1)) < 3 & abs(G-color_map(i,2)) < 3 & abs(B-color_map(i,3)) < 3;
    dense_labels(result) = i;
    [rows, cols] = ind2sub(size(R), find(result));
    classes(i).class = i;
    classes(i).indices = [rows cols];
end

end

