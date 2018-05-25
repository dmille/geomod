% Use decaseljau function to generate Bezier curve from control points. 
close all

% set display window stuff
set(gcf,'color','white')
%set(gcf, 'Position', get(0, 'Screensize'));

% axis stuff
axis manual  % tell matlab not adjust the axis automatically
axis equal   % prevent matlab from scaling x and y direction differently 
%axis off


singlet = 0.5;
t = linspace(0,1,100)';
control_points = [1 1;2 3;4 5;6 2];
plot(control_points(:,1), control_points(:,2),'-ko','markeredgecolor','k','markerfacecolor','r','markersize',10,'LineWidth',2);

decasteljau_lines(control_points,singlet);

bezier_curve = decasteljau(control_points,t);
plot(bezier_curve(:,1), bezier_curve(:,2), 'LineWidth',2);

