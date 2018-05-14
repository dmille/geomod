n = 10;
plot_res = 200;
x_min = -2;
x_max = 2;

% Uniformly spaced
X = linspace(x_min, x_max, n)';

a = 1;
m = 2;
Y = plot_poly(X, a, m);
hold on;
X_lap = linspace(x_min, x_max, plot_res)';
Y_lap = lagrange(X, Y, X_lap);
plot(X_lap, Y_lap);
pause();
hold off;

% Randomly spaced
X = x_min + (x_max-x_min) * rand(n, 1);

a = 1;
m = 3;
Y = plot_poly(X, a, m); 
hold on;
X_lap = linspace(x_min, x_max, plot_res)';
Y_lap = lagrange(X, Y, X_lap);
plot(X_lap, Y_lap);
pause();
hold off;