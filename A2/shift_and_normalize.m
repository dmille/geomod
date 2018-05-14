function [X, Y] = shift_and_normalize(X,Y)
%SHIFT_AND_NORMALIZE Summary of this function goes here
%   Detailed explanation goes here
    X_mean = mean(X);
    Y_mean = mean(Y);
    
    % Shift
    X = X - X_mean;
    Y = Y - Y_mean;

    % Normalize
    X = X / norm(X);
    Y = Y / norm(Y);
end

