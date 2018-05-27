tsampling=linspace(0,1,250)';
controlPts = [1,1; 2,5; 5,5; 5,1];
%controlPts = [1,1; 1,5];
hold off;
hold on;

mycurve= decasteljau(controlPts,tsampling);
plot_intermediate(controlPts, 0.3);
plot(mycurve(:,1), mycurve(:,2));
