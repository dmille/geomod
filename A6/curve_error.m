function [error] = curve_error(noisy_data, bezier_curve)
  m_nd = size(noisy_data, 1);
  m_bc = size(bezier_curve, 1);
  
  error = 0;
  for i=[1:m_nd]
    error = error + min( sum((repmat(noisy_data(i,:), m_bc, 1) - bezier_curve) .^ 2, 2));
  end
  
end
