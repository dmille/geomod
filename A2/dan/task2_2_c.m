close all
hold on

%axis stuff
%axis manual  % tell matlab not adjust the axis automatically
%axis equal   % prevent matlab from scaling x and y direction differently 
%axis off

%n = randperm(9,1)+1;
n = 10;
l = -2;
r = 2;

x = linspace(l,r,n);
%x = sort(-5 + (5+5)*rand(1,10));
y = polynomial_rep(x,1,3);

plot(x,y,'-ko');%,xx,yy,'.');
xlim([-3 3]);
ylim([-30 30]);


hold off


function y = polynomial_rep(x,coeff,degree)
    a = coeff;
    m = degree;
    y = a * x .^ m;
end
