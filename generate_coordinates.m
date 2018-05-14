function [X, Y] = generate_coordinates(n_coord, min_x, max_x, min_y, max_y)
%GENERATE_COORDINATES Summary of this function goes here
%   Detailed explanation goes here
X = zeros(n_coord);
Y = zeros(n_coord);

X = min_x + (max_x-min_x) * rand(n_coord, 1);
Y = min_y + (max_y-min_y) * rand(n_coord, 1);

end

