clc;clear;close all;
ASNR = 2;
N = 200;
rng default;

X = rand(1,N);
Y = rand(1,N);
I = rand(1,N)*15;
P = [X;Y];
C = mean(P,2);
D = P - repmat(C,[1,N]);
D = vecnorm(D).*D.*I;
V = sum(D,2);


n = normrnd(0,1,1,N);

I_t = I + n;

theta = rand(1,1)*pi/2;

fprintf('theta = %.3f\n',theta/pi*180);

R = [cos(theta),-sin(theta);sin(theta),cos(theta)];

P_t = R*[X;Y];

X_t = P_t(1,:);
Y_t = P_t(2,:);
C_t = mean(P_t,2);
D_t = P_t - repmat(C_t,[1,N]);

D_t = vecnorm(D_t).*D_t.*I_t;
V_t = sum(D_t,2);

rot = acos((V_t'*V)./norm(V_t)./norm(V))/pi*180;

fprintf('alpha = %.3f\n',rot);





% figure;
% subplot(1,2,1);
% scatter(X,Y);
% subplot(1,2,2);
% scatter(x,y);
% xlabel(['$\theta$ = ',num2str(theta*180/pi)],'Interpreter','latex');
