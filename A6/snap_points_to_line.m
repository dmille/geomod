function [out_points] = snap_points_to_line(points,line)
%snap_points_to_line Summary of this function goes here
%   takes points in a nx2 array and snaps them to a line using shortest
%   othogonal distance. line is an 2x1 array with line(1) = x-intercept adn
%   line(2) = slope.
    n = length(points);
    out_points = points;
    b = line(1);
    m = line(2);
    out_points(:,1) = ((1/m)*points(:,1)+points(:,2)-b)/(m+1/m);
    out_points(:,2) = [ones(n,1) out_points(:,1)] * line;
end

