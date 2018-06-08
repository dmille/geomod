function [indices] = nd_indices(ppb, n_noisy_pts, n_beziers)
%%% i = which number bezier
%%% ppb = points per bezier
  indices = zeros(n_beziers,2);
  for i=1:n_beziers
    first = ((i-1) * ppb) + 1;
    last = (i * ppb) + 1;  
    indices(i,:) = [first,last];
  end
  indices(end,2) = n_noisy_pts;
end
