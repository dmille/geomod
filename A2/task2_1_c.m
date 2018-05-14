close all

hold on

% set display window stuff
set(gcf,'color','white')
%set(gcf, 'Position', get(0, 'Screensize'));

% axis stuff
%axis manual  % tell matlab not adjust the axis automatically
axis equal   % prevent matlab from scaling x and y direction differently 
axis off

%number of vertices of polygon
n = 20;
iter = 100;

%create 2xn matrix of random values
P = rand(n, 2);
%P = [0 0;0 1;1 1;1 0];
%P = [P;P(1) P(2)];

%build halfing matrix
half = ones(1,n) * 0.5;
halfScaling = diag(half);
half = ones(1,n-1) * 0.5;
halfScaling = halfScaling + diag(half, +1);
halfScaling(n) = 0.5;

%create sparse matrix
halfSparse = sparse(halfScaling);

% set plotting style
X = 0;Y = 0;
poly_handle = plot(X,Y,'-ko','markeredgecolor','b','markerfacecolor','w','markersize',10);


%iterations
for i=1:iter+1 % +1 because we draw first
    % add set of points at the end that is the same as first to close
    % polygon
    plotP = [P;P(1) P(n+1)];

    % draw new polygone
    set(poly_handle,'xdata',plotP(:,1),'ydata',plotP(:,2));
    drawnow
    pause(.01);
    
    %update points
    P = halfSparse * P;
end
hold off