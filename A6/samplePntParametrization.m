function [tout] = samplePntParametrization(points)
% samplePtParametrization Summary of this function goes here
%   calculates total distance from first point to other points along the
%   given curve and parameterizes them with t where first point t=0 and
%   last t=1. t = distance from first point / total distance (first to
%   last)

    n = length(points);
    t = zeros(1,n);
    s = 0;

    diff = points - circshift(points,-1); % calculate the differences between x(i) and x(i+1)
    v = vecnorm(diff(1:end-1, :)'); % calculate the euclidean norm of each difference
    tout = [0 cumsum(v)/sum(v)]; % produces normalized cumulative sum array and sets the first element to 0 (special case)
end

