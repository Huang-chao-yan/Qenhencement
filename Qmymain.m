function [u,ga]=Qmymain(img,lambda,eta)
ga=gammaQ(double2q(img));
img=ga;
Qimg=double2q(img);
Qga=double2q(ga);

p=0.6;
T      = cos(pi/4) + unit(quaternion(0.299,0.587,0.114))*sin(pi/4);
Tt     = conj(T);
C      = T*Qimg*Tt - Tt*Qimg*T;
I      = T*Qimg*Tt + Tt*Qimg*T;
fbarC=mean(C);
fbarI=mean(I);

Cga      = T*Qga*Tt - Tt*Qga*T;
Iga      = T*Qga*Tt + Tt*Qga*T;

%% C  u^B
naC=natna(C,p);
numeratorC = naC.* C + lambda.* fbarC +eta.* Cga;
denominatorC = naC + lambda + eta;
uC = numeratorC ./ denominatorC;


%% I   u^D
naI=natna(I,p);
numeratorI = naI.* I + lambda.* fbarI +eta.* Iga;
denominatorI = naI + lambda + eta;
uI = numeratorI ./ denominatorI;

%% u
d = 1/2*Tt*(uC+uI)*T;

u = double2q(d,-1);

end

function na=natna(Qimg,p)
   [rows,cols] = size(Qimg);
  u1 = padarray(Qimg,[0,1],'both','circular');
  alpha = (abs(u1(:,2:cols+1)-u1(:,1:cols))/sqrt(3)+eps).^(p-1);
  alpha = padarray(alpha,[0,1],'post','circular');
w1 = alpha(:,1:cols).^2 + alpha(:,2:cols+1).^2;
u2 = padarray(Qimg,[1,0],'both','circular');
beta = (abs(u2(2:rows+1,:)-u2(1:rows,:))/sqrt(3)+eps).^(p-1);
beta = padarray(beta,[1,0],'post','circular');
w2 = beta(1:rows,:).^2 + beta(2:rows+1,:).^2;
na=w1+w2;
end