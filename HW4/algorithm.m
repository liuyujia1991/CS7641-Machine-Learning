function prob = algorithm(q)

% plot and return the probability

y_raw = load('sp500.mat');
y = y_raw.price_move;
y = -y/2+1.5;
T = size(y,1);

pi = [0.2,0.8];
A = [0.8, 0.2;0.2, 0.8];
B = [q, 1-q;1-q, q];

alpha = zeros(T,2);
beta =  zeros(T,2);

alpha(1,1) = pi(1).*B(1,y(1));
alpha(1,2) = pi(2).*B(2,y(1));
beta(T,:) = [1 1];

t = 1;
while t < T
    alpha(t+1,1) = B(1,y(t+1))*(A(1,1)*alpha(t,1) + A(2,1)*alpha(t,2));
    alpha(t+1,2) = B(2,y(t+1))*(A(1,2)*alpha(t,1) + A(2,2)*alpha(t,2));
    t = t+1;
end

t = T;
while t > 1 
    beta(t-1,1) = beta(t,1)*B(1,y(t))*A(1,1) + beta(t,2)*B(2,y(t))*A(1,2);
    beta(t-1,2) = beta(t,1)*B(1,y(t))*A(2,1) + beta(t,2)*B(2,y(t))*A(2,2);
    t=t-1;
end

P_joint = alpha.*beta;
P = P_joint;

for i=1:T
    P(i,:) = P(i,:)/(P(i,1)+P(i,2));
end

prob = P(T);
end
