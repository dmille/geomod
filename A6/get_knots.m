function [knots] = get_knots(noisy_data, ppb, n_beziers)
  noisy_data(:,:)
  knots = zeros(n_beziers+1,2)
  for i=1:n_beziers
    knots(i,:) = noisy_data(((i-1) * ppb) + 1, :)
  end
  knots(n_beziers+1, :) = noisy_data(end, :)
end
