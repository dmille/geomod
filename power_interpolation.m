function [Y_pow] = power_interpolation(X, Y, X_pow)
%POWER_INTERPOLATION Summary of this function goes here
%   Detailed explanation goes here
    V = vandermonde(X);
    A = V\Y;
    max_degree = size(A, 1) - 1;
    
    vandermonde(X_pow);
    Y_pow = power_matrix(X_pow, max_degree) * A;    
end

