clc;clear;close all;
ASNR = 2;
N = 100;
rng default;

X = rand(N,1);
Y = rand(N,1);
C = mean([X,Y]);
I_star = rand(N,1)*15;

Ns = normrnd(0,1,N,1);

i_star = I_star + N;

theta = rand(1,1)*pi/2;

R = [cos(theta),-sin(theta);sin(theta),cos(theta)];

P = R*[X';Y'];

x = P(1,:)';
y = P(2,:)';
c = mean([x,y]);




% figure;
% subplot(1,2,1);
% scatter(X,Y);
% subplot(1,2,2);
% scatter(x,y);
% xlabel(['$\theta$ = ',num2str(theta*180/pi)],'Interpreter','latex');
