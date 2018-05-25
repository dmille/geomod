function [B_curve] = decasteljau(con_pts,t)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    if(size(con_pts,1) == 1)
        B_curve = con_pts;
    else 
        B_curve = (1 - t) .* decasteljau(con_pts(1:end-1,:),t) + t .* decasteljau(con_pts(2:end,:),t);
    end
end

