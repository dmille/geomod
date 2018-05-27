controlPts = [0 0; 0 5; 6 -3; 5 0; 3 5; 2 0];
tsampling=linspace(0,1,250)';
[mycurve, curvature] = decasteljau_with_curvature(controlPts, tsampling);

ha = plot(mycurve(:,1), mycurve(:,2), '.-', 'LineWidth',10, 'DisplayName',' 0.5');

abs_curvature = abs(curvature);
rescaled_curvature = 255 - rescale(abs_curvature, 0, 255);
n = length(curvature);

cd = [uint8(rescaled_curvature) uint8(rescaled_curvature) uint8(rescaled_curvature) uint8(ones(n,1))];
cd(curvature >= 0, 1) = 255;
cd(curvature <= 0, 3) = 255;

cd = cd';

drawnow

set(ha.Edge, 'ColorBinding','interpolated','ColorData',cd);
