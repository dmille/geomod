function [control_pts] = fit_bezier(noisy_data, n_beziers)
  %% This function should fit a piecewise bezier to the curve

  %% m number of noisy points
  m = size(noisy_data,1);

  %% points per bezier
  ppb = floor(m/n_beziers);

  %% first and last indexes of points to use for each bezier curve  
  idxs = nd_indices(ppb, m, n_beziers);
  
  for i=[1:n_beziers]
    control_pts(i:i+3, :) = cubicBezierLeastSquaresPnts(noisy_data([idxs(i,1):idxs(i,2)],:));
  end
  
end
