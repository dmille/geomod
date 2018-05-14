close all

% set display window stuff
set(gcf,'color','white')
%set(gcf, 'Position', get(0, 'Screensize'));

% axis stuff
%axis manual  % tell matlab not adjust the axis automatically
axis equal   % prevent matlab from scaling x and y direction differently 
axis off

hold on

%X = [0 1 1 1];
%Y = [0 1 1 0];

% set number of vertices and iterations
n = 20;
iter = 100;

% set arrays of points
X = rand(1,n);
Y = rand(1,n);

% add one element to the end of arrays that is the same as first element to
% close the polygon
X(length(X)+1) = X(1);
Y(length(Y)+1) = Y(1);

% set plotting style
poly_handle = plot(X,Y,'-ko','markeredgecolor','b','markerfacecolor','w','markersize',10);




for i=1:iter+1 % +1 because we draw first
    %plot new polygon
    set(poly_handle,'xdata',X,'ydata',Y);
    drawnow
    pause(.01)
    
    %update vertices
    for k=1:n
        X(k) = 0.5*(X(k) + X(k+1));
        Y(k) = 0.5*(Y(k) + Y(k+1));
    end
    X(n+1) = X(1);
    Y(n+1) = Y(1);
end
hold off