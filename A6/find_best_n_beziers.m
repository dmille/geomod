function [n_beziers] = find_best_n_beziers(noisy_data)
  tsampling = linspace(0,1,100)';

  thresh = 0.005;

  n = 0;

  prev_error = 1000;
  error = 500;

  while(abs(prev_error - error) > thresh)
    n = n+1;
    prev_error = error;
    control_pts = fit_bezier(noisy_data, n);
    curve = [nan nan];
    for i=[1:n]
      curve = [curve; decasteljau(bezier_ind(control_pts, i), tsampling)];
    end
    error = curve_error(noisy_data, curve);
  end
  n_beziers = n;

end
