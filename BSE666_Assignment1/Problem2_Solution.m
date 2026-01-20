t_start = 0; t_end = 1; T_init = 1;
steps = [0.1, 0.05, 0.01];

fprintf('dt      | Exp Euler  | Imp Euler  | Crank-Nic\n');
fprintf('-------------------------------------------\n');

figure('Name', 'ODE Numerical Comparison');

for k = 1:length(steps)
    h = steps(k);
    time = t_start:h:t_end;
    n_pts = length(time);

    exact = exp(-time);


    T_exp = zeros(1, n_pts); T_imp = zeros(1, n_pts); T_cn = zeros(1, n_pts);
    T_exp(1) = T_init; T_imp(1) = T_init; T_cn(1) = T_init;


    for n = 1:n_pts-1
        T_exp(n+1) = T_exp(n) * (1 - h);
        T_imp(n+1) = T_imp(n) / (1 + h);
        T_cn(n+1)  = T_cn(n) * (1 - h/2) / (1 + h/2);
    end


    err_exp = sqrt(mean((T_exp - exact).^2));
    err_imp = sqrt(mean((T_imp - exact).^2));
    err_cn  = sqrt(mean((T_cn - exact).^2));

    fprintf('%.2f    | %.6f   | %.6f   | %.6f\n', h, err_exp, err_imp, err_cn);


    subplot(3, 1, k);
    plot(time, exact, 'w', 'LineWidth', 1.0); hold on;
    plot(time, T_exp, 'r--o', 'MarkerSize', 3);
    plot(time, T_imp, 'b--x', 'MarkerSize', 3);
    plot(time, T_cn, 'g--d', 'MarkerSize', 3);
    grid on;
    title(['Step size = ', num2str(h)]);
    if k == 1, legend('Exact', 'Explicit', 'Implicit', 'CN'); end
end