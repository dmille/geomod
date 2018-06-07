function [control_pts] = fit_bezier(noisy_data, n_beziers)
  %% This function should fit a piecewise bezier to the curve

  control_pts = zeros(3 * n_beziers + 1, 2);

  m = size(noisy_data,1);

  %% points per bezier
  ppb = m/n_beziers;

  knots = get_knots(noisy_data, ppb, n_beziers);

end
