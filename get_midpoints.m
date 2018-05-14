function [X_new, Y_new] = get_midpoints(X, Y)
%GET_MIDPOINTS Summary of this function goes here
%   Detailed explanation goes here
    X_shift = circshift(X, 1);
    Y_shift = circshift(Y, 1);
    X_new = 1/2 * (X + X_shift);
    Y_new = 1/2 * (Y + Y_shift);
end

