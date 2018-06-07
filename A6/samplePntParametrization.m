function [tout] = samplePntParametrization(points)
% samplePtParametrization Summary of this function goes here
%   calculates total distance from first point to other points along the
%   given curve and parameterizes them with t where first point t=0 and
%   last t=1. t = distance from first point / total distance (first to
%   last)

    n = length(points);
    t = zeros(1,n);
    s = 0;
    
    for i=2:n
        s = s + pdist([points(i);points(i-1)]);
        t(i) = s;
    end
    tout = t/s;
end

