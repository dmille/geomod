min_x = 0; max_x = 10;
min_y = 0; max_y = 10;
n = 20;
iters = 200;
fps = 5;

delay = 1/fps;

[X, Y] = generate_coordinates(n, min_x, max_x, min_y, max_y);

i = [1:n, 1:n];
j = [1:n, 2:n, 1];
s = ones(n+n, 1) * 0.5;
M = sparse(i, j, s);
[V,D] = eigs(M);
D
for i = 1:iters
    X = M * X;
    Y = M * Y;    
    [X,Y] = shift_and_normalize(X,Y);
    plot_polygon(X,Y);
    pause(delay);
end