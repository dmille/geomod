function [bout] = cubicBezierLeastSquaresPnts(points)
% cubicBezierControlPoints Given a set of n points, output is a cubic bezier least squares
% approximation 
%   Detailed explanation goes here
    n = length(points);
    
    p0 = points(1,:);         %first bezier control points in first point
    p3 = points(end,:);       %third bezier control points in last point
    
    if (n == 1)
        p1 = p0;
        p2 = p0;
    elseif (n == 2)
        p1 = p0;
        p2 = p3;
    elseif (n == 3)
        p1 = points(2,:);
        p2 = p1;

    else % start of main computation when n>3
        t = samplePntParametrization(points);
        
        %initialize variables to keep sums to 0
        solveP1_sum = 0;
        solveP2_sum = 0;
        b1b2_sum = 0;
        b1sq_sum = 0;
        b2sq_sum = 0;
        
        for i=1:n
            % Berstein polynomial basis
            b0 = (1-t(i))^3;
            b1 = 3*(1-t(i))^2 * t(i);
            b2 = 3*(1-t(i)) * t(i)^2;
            b3 = t(i)^3;
            
            % For least squares we minimize  
            % SUM(points(i) - p0b0 - p1b1 - p2b2 - p3b3)^2)
            % To get optimal min, set partial derivatives d/dp1 & d/dp2 = 0
            % Simplifies to 
            % SUM(b1*(points(i) - p0b0 - p3b3) = p1*SUM(b1^2)+p2SUM(b1b2)
            % and 
            % SUM(b2*(points(i) - p0b0 - p3b3) = p1*SUM(b1b2)+p2SUM(b2^2)
            %
            % We know p0,p3,b0,b1,b2,b3 so we can solve for p1 & p2 using
            % system of equations. Need to calculate
            % SUM(b1*b2), SUM(b1^2), SUM(b2^2), & SUMs on left of above eqs
            % keeping track of sums
            solveP1_sum = solveP1_sum + b1 * (points(i,:) - p0*b0 - p3*b3);
            solveP2_sum = solveP2_sum + b2 * (points(i,:) - p0*b0 - p3*b3);
            b1b2_sum = b1b2_sum + (b1 * b2);
            b1sq_sum = b1sq_sum + (b1 * b1);
            b2sq_sum = b2sq_sum + (b2 * b2);
        end
        
        % p1*b1sq_sum + p2*b1b2_sum = solveP1_sum
        % p1*b1b2_sum + p2*b2sq_sum = solveP2_sum
        % solve system of equations with \
        bMat = [b1sq_sum b1b2_sum;b1b2_sum b2sq_sum];
        solveMat = [solveP1_sum;solveP2_sum];
        p = bMat \ solveMat;
        
        p1 = p(1,:);
        p2 = p(2,:);
    end
    
bout = [p0;p1;p2;p3];
end

