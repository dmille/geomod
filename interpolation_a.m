n = 10;
x_min = -2;
x_max = 2;

X_uniform = linspace(x_min, x_max, n)';
X_random = x_min + (x_max-x_min) * rand(n, 1);

a = 1;
m = 2;
Y = plot_poly(X_uniform, a, m);
hold on;

m = 3;
plot_poly(X_random, a, m); 

