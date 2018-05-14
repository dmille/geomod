%axis stuff
axis manual  % tell matlab not adjust the axis automatically
axis equal   % prevent matlab from scaling x and y direction differently 
axis off

polynomial_rep(1,3);

function polynomial_rep(coeff,degree)
    a = coeff;
    m = degree;

    %n = randperm(9,1)+1;
    n = 10;
    l = -2;
    r = 2;
    
    x = linspace(l,r,n);
    %x = sort(-5 + (5+5)*rand(10,1));
    
    y = a * x .^ m;
    plot(x,y,'-ko');
    xlim([-3 3]);
end


