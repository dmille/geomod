% Use decaseljau function to generate Bezier curve from control points. 

t = linspace(0,1,100)';
control_points = [1 1;2 3;4 5;6 2];

bezier_curve = decasteljau(control_points,t);

plot(bezier_curve(:,1), bezier_curve(:,2));