function [] = draw_pose(pose, char_id)
% char_id is optional input.

if nargin < 2,
    char_id = 1;
end
char_colors = {
    'r', 'r';
    'b', 'b';
    'g', 'g';
    };
if numel(pose.joint_names) == 18,
    edges = [
        1 2
        2 3
        3 4
        4 5
        5 6
        6 7
        7 8
        8 9
        6 10
        10 11
        11 12
        13 14
        14 15
        16 17
        17 18
    ];
end

for i= 1:size(edges, 1),
    coords = [pose.joint_locations(edges(i, 1), :); pose.joint_locations(edges(i, 2), :)];
    line(coords(:, 1), coords(:, 2), coords(:, 3), ...
        'Color', char_colors{char_id, 1}, 'LineWidth', 3, ...
        'Marker', 'o', 'MarkerEdgeColor', char_colors{char_id, 2});
end
    
end