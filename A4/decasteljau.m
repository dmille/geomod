function [mycurve] = decasteljau(controlPts, tsampling)
%DECASTELJAI Summary of this function goes here
%   Detailed explanation goes here
    if(size(controlPts,1) == 1)
        mycurve = controlPts;
    else
        mycurve = (1 - tsampling) .* decasteljau(controlPts(1:end-1,:), tsampling)...
            + tsampling .* decasteljau(controlPts(2:end,:), tsampling);
    end    
end

