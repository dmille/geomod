function [A] = lin_least_squares(control_points)
%LEAST_SQUARES Summary of this function goes here
%   Detailed explanation goes here
    P = power_matrix(control_points(:,1),1);
    A = inv((P' * P)) * P' * control_points(:,2);    
end

