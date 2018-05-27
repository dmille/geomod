function [mycurve, curvature] = decasteljau_with_curvature(controlPts, tsampling)
%DECASTELJAU_WITH_CURVATURE Summary of this function goes here
%   Detailed explanation goes here
  mycurve = decasteljau(controlPts, tsampling);

  %% First derivative
  c_tmp = circshift(controlPts,-1,1);
  controlPts_1 = c_tmp(1:end-1,:) - controlPts(1:end-1,:); 
  c_1 = decasteljau(controlPts_1, tsampling);

  %% Second derivative
  c_tmp = circshift(controlPts_1,-1,1);
  controlPts_2 = c_tmp(1:end-1,:) - controlPts_1(1:end-1,:);
  c_2 = decasteljau(controlPts_2, tsampling);

  curvature = (c_1(:,1) .* c_2(:,2) - c_2(:,1) .* c_1(:,2)) ./ ((c_1(:,1) .^ 2 + c_1(:,2) .^ 2) .^ (3/2));

end

