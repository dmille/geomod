function [Y] = plot_poly(X, a, m)
%PLOT_POLY Summary of this function goes here
%   Detailed explanation goes here

    Y = a .* (X .^ m);

    plot(X,Y, 'x');
    axis([-3 3 -inf inf]);
end

