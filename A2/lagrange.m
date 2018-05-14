function [y] = lagrange(X, Y, xx)
%LAGRANGE Summary of this function goes here
%   Detailed explanation goes here
    [n, ~] = size(X);
    y = 0;
    for i = 1:n
        term = Y(i);
        for j = 1:n
            if(i ~= j)
                term = term .* (xx - X(j))/(X(i) - X(j));
            end
        end
        y = y + term;
    end
end

