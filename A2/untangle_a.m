min_x = 0; max_x = 10;
min_y = 0; max_y = 10;
n_coords = 40;
iters = 300;
fps = 15;
delay = 1/fps;

[X, Y] = generate_coordinates(n_coords, min_x, max_x, min_y, max_y);
hold off;
for i = 1:iters    
    plot_polygon(X,Y);
    [X, Y] = get_midpoints(X,Y);
    pause(delay);
end

