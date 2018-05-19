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
X_pow = linspace(x_min, x_max, plot_res)';
Y_pow = power_interpolation(X, Y, X_pow);
plot(X_pow, Y_pow);
pause();
hold off;

% Randomly spaced
X = x_min + (x_max-x_min) * rand(n, 1);

a = 1;
m = 5;
Y = plot_poly(X, a, m); 
hold on;
X_pow = linspace(-3, 3, plot_res)';
Y_pow = power_interpolation(X, Y, X_pow);
plot(X_pow, Y_pow);
pause();
hold off;