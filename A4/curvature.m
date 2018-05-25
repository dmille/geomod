% Use decaseljau function to generate Bezier curve from control points.
t = linspace(0,1,250)';
control_points = [1 1;2 3;3 4;4 0;6 2;8 4;10 0];

% generate Bezier points using control points and t
bezier_curve = decasteljau(control_points,t);

% get first and second derivatives in x and y directions
dx = gradient(bezier_curve(:,1));
dy = gradient(bezier_curve(:,2));
ddx = gradient(dx);
ddy = gradient(dy);

% get numerator and denominator for curvature formula
num = dx .* ddy - ddx .* dy;
denom1 = dx .* dx + dy .* dy;
denom2 = sqrt(denom1);
denom3 = denom2 .* denom2 .* denom2;

% k is curvature. 
k = num ./ denom3;

%hold on
%plot(bezier_curve(:,1), bezier_curve(:,2));
%plot(bezier_curve(:,1), k);
%hold off

% %example 2 using the parula colormap from matlab
figure
ha = plot(bezier_curve(:,1), bezier_curve(:,2),'.-', 'LineWidth',10, 'DisplayName',' 0.5');

n=length(t);
%cd = uint8(randi(255,4,n));
%cd = [uint8(parula(n)*255) uint8(ones(n,1))].'; %'
% red = [1 0 0];
% white = [1 1 1];
% blue = [0 0 1];
% colorramp = [[linspace(red(1),white(1),n/2)',linspace(red(2),white(2),n/2)',linspace(red(3),white(3),n/2)']' [linspace(white(1),blue(1),n/2)',linspace(white(2),blue(2),n/2)',linspace(white(3),blue(3),n/2)']'];
% colorramp = uint8([colorramp.*255;ones(1,n)]);
%cd(:,4)=0;


limitmax = max(abs(max(k)),abs(min(k)));
kcolor = zeros(4,n);
for i=1:n
    if(k(i) < 0)
        rg = 255 - (abs(k(i)) * 255 / limitmax);
        kcolor(:,i) = [rg;rg;255;1];
    else if(k(i) > 0)
            gb = 255 - (k(i) * 255 / limitmax);
            kcolor(:,i) = [255;gb;gb;1];
        else
            kcolor(:,i) = [255;255;255;1];
        end
    end
end
kcolor = uint8(kcolor);
        
drawnow
set(ha.Edge, 'ColorBinding','interpolated', 'ColorData',kcolor);
        