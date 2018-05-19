tsampling=linspace(0,1,250)';
controlPts = [1,1; 2,5; 5,5; 5,1];
%controlPts = [1,1; 1,5];

mycurve= decasteljau(controlPts,tsampling);

plot(mycurve(:,1), mycurve(:,2));