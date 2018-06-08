function [control_pts] = fit_bezier(noisy_data, n_beziers)
  %% This function should fit a piecewise bezier to the curve

  %% m number of noisy points
  m = size(noisy_data,1);

  %% first and last indexes of points to use for each bezier curve  
  idxs = nd_indices(n_beziers, m);
  idxs
  b_ind = @(x) 3 * (x-1) + 1;

  for i=[1:n_beziers]
    control_pts(b_ind(i):b_ind(i)+3, :) = cubicBezierLeastSquaresPnts(noisy_data([idxs(i,1):idxs(i,2)],:));
  end
  size(control_pts)
  control_pts = make_C1_cont(control_pts);
end
