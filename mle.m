function [Angle,t] = mle(X,Y,M)
%poseCalc - Description
%
% Syntax:[R,t] = poseCalc(X,Y,camera)
%
% Pose Calculation Algorithm
% Input:
% X - 3 x n world coordinates of n targets 
% Y - 3 x n focus unified image coordinates of n projections of targets 
% Output:
% R - 3 x 3 rotation matrix
% t - 3 x 1 translation vector

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