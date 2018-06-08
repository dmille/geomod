function [P] = power_matrix(X, max_degree)
%POWER_MATRIX Summary of this function goes here
%   Detailed explanation goes here
    P = [];
    for i = 0:max_degree
        P = [P (X .^ i)];
    end
end

