hold on
points = [0 0;1 2;2 3;3 3;4 4;5 4.5;6 4;7 3;8 2];
cp = cubicBezierLeastSquaresPnts(points);

t = linspace(0,1,100)';
bezier = decasteljau(cp,t);

plot(knots(:,1),knots(:,2),'*','markeredgecolor','r');
plot(cp(:,1),cp(:,2),'-ko');
plot(bezier(:,1), bezier(:,2),'b');
