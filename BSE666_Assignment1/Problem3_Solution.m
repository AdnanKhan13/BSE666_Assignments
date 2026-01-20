%% Q3 part (a) solution:

H = 2;
t_exact = linspace(0,2*sqrt(H),400);
h_exact = (sqrt(H) - t/2).^2;

figure
plot(t_exact,h_exact,'w','LineWidth',2)
xlabel('Time t')
ylabel('h(t)')
title('Analytical Solution')
grid on
 
%% ----------------------------------------
%% Q3 part (b) solution:

dt = 0.05;   
t_max = 2*sqrt(H);
N = floor(t_max/dt);

%% for explicit sol
h_exp = zeros(1, N+1);
t_num = zeros(1, N+1);
h_exp(1) = H;

for n = 1:N
    t_num(n+1) = t_num(n) + dt;
    h_exp(n+1) = h_exp(n) - dt*sqrt(h_exp(n));
    if h_exp(n+1) < 0
        h_exp(n+1) = 0;
        break
    end
end

n_exp = n;

%% for Implicit sol
h_imp = zeros(1, N+1);
h_imp(1) = H;

for n = 1:N
    y = (-dt + sqrt(dt^2 + 4*h_imp(n))) / 2;
    h_imp(n+1) = y^2;
    if h_imp(n+1) < 0
        h_imp(n+1) = 0;
        break
    end
end

n_imp = n;

%% for plot comparison
figure
plot(t_exact, h_exact, 'w', 'LineWidth', 1.5); hold on
plot(t_num(1:n_exp+1), h_exp(1:n_exp+1), 'ro--', 'LineWidth', 1.5)
plot(t_num(1:n_imp+1), h_imp(1:n_imp+1), 'bs--', 'LineWidth', 1.5)

xlabel('Time t')
ylabel('h(t)')
title('Analytical vs Explicit vs Implicit')
legend('Analytical','Explicit Euler','Implicit Euler')
grid on