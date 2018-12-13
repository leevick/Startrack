clc;clear;close all;

%%%%Convention of notations%%%%%
% Use the image coordinate system where the origin of the system O is set as the top-left corner of image
% 




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

rot = acos((V_t'*V)./norm(V_t)./norm(V));

fprintf('alpha = %.3f\n',rot/pi*180);


function [angle,X,Y] = init(P_1,P_2)
	


end





function [angle,t] = mle(X,Y,M)
%mle - Description
%
% Syntax:[angle,t] = mle(X,Y,M)
%
% Pose Calculation Algorithm
% Input:
% X - 2 x n locations of star centroid
% Y - 2 x n locations of star centroid 
% Output:
% angle - rotation angle
% t - 2 x 1 translation vector

%%Camera Params%%
H = Y/X;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Maximun likelihood estimation for the H
% using the function(10), P7
%options = optimset('LargeScale','off');
options.Algorithm = 'levenberg-marquardt';
x = lsqnonlin( @simon_H, reshape(H,1,9) , [],[],options,Y, X);
H=reshape(x,3,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
H=(inv(M))*H;
Zc1 = 1/norm(H(:,1),2);
Zc2 = 1/norm(H(:,2),2);

Zc = sqrt(Zc1*Zc2);

H = H*Zc;
t = H(:,3);

H(:,3) = cross(H(:,1),H(:,2));

Angle = [ -asin(H(2,3))/pi*180;atan(H(2,1)/H(2,2))/pi*180;atan(H(1,3)/H(3,3))/pi*180];

end

function f = simon_H(H, m, M)
    
    %h=[H([1:3]); H([4:6]); H([7:8]),1];
    H=reshape(H,3,3);
    h=H;
    
    m=[m([1:2],:); ones(1,size(m,2))];
    M=[M([1:2],:); ones(1,size(M,2))];
    
    X=h*M;
    X=[X(1,:)./X(3,:) ; X(2,:)./X(3,:); X(3,:)./X(3,:)];
    
    res=m-X;
    req=[res(1,:), res(2,:)]; 
    
    
    f = req;
end
