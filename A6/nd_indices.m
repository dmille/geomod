function [indices] = nd_indices(n_beziers, n_noisy_pts)
%%% i = which number bezier
%%% ppb = points per bezier
  cumulative = 0;
  used_pts = 0;
  num_to_use = 0;
  ppb = n_noisy_pts/n_beziers;
  indices = zeros(n_beziers,2);
  for i=1:n_beziers
    cumulative = cumulative + ppb;
    num_to_use = round(cumulative) - used_pts;
                                %    first = ((i-1) * num_to_use) + 1;
    first = used_pts + 1;
    last = (used_pts + num_to_use) + 1;  
    indices(i,:) = [first,last];
    used_pts = used_pts + num_to_use;
  end
  indices(end,2) = n_noisy_pts;
end
