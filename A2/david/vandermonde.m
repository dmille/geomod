function [V] = vandermonde(X)
%HILBERT Summary of this function goes here
%   Detailed explanation goes here
    [n, ~] = size(X);
    V = [];
    for i = 0:n-1
        V = [V (X .^ i)];
    end
end

