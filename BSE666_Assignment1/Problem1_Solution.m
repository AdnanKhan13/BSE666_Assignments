Q = linspace(0.1, 10);
G = 15./Q - 0.3*log(Q) - 2.5;
plot(Q, G);
xlabel('Q');
ylabel('G(Q)');
title("G(Q) v/s Q");

func_G = @(q) 15./q - 0.3*log(q) - 2.5;
q0 = [0.1, 10];
root = fzero(func_G, q0);
fprintf('root = %d', root)

Q = zeros(1,6);
Q(1) = 1;
for n = 1:5
    Q(n+1) = 15/(0.3*log(Q(n))+2.5);
end
fprintf('Q6 = %d', Q)

diff = abs(Q - root);
semilogy(1:6, diff, '-o')


