close all

% set figure backgound to white.. if you don't like the default gray
set(gcf,'color','white')
%set(gcf, 'Position', get(0, 'Screensize'));

hold on

%X = [0 1 1 1];
%Y = [0 1 1 0];

X = rand(1,50);
Y = rand(1,50);

X(length(X)+1) = X(1);
Y(length(Y)+1) = Y(1);
%poly_handle = plot(X,Y);

%axis stuff
axis manual  % tell matlab not adjust the axis automatically
axis equal   % prevent matlab from scaling x and y direction differently 
axis off

%iterations
n = length(X);

for i=1:500
    for k=1:n-1
        X(k) = 0.5*(X(k) + X(k+1));
        Y(k) = 0.5*(Y(k) + Y(k+1));
    end
    X(n) = X(1);
    Y(n) = Y(1);
    %set(poly_handle,'xdata',X,'ydata',Y);
    %drawnow
    pause(.01)
    plot(X,Y);
end
hold off