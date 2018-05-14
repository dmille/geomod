function [Y_ls] = least_squares(X, Y, X_ls, d)
%LEAST_SQUARES Summary of this function goes here
%   Detailed explanation goes here
    P = power_matrix(X, d);
    A = inv((P' * P)) * P' * Y;    
    Y_ls = power_matrix(X_ls, d) * A;
end

