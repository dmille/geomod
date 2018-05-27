function [mycurve] = plot_intermediate(controlPts, t)
%PLOT_INTERMEDIATE Summary of this function goes here
%   Detailed explanation goes here

    if(size(controlPts,1) == 1)
        mycurve = controlPts;
    else
        p1 = plot_intermediate(controlPts(1:end-1,:), t);
        p2 = plot_intermediate(controlPts(2:end,:), t);
        mycurve = (1 - t) .* p1 + t .* p2;
    end
    if(size(controlPts,1) > 2)
       plot([p1(1),p2(1)], [p1(2),p2(2)]);
    end
end

