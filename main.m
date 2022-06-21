
clear
close all

% load test
% imageData=double(imread('gt_1_old.png'));
% a= double(imread('gt_1.png'));

load test
a= double(imread('high.png'));

paried=1;

figure(1), imshow(imageData./255);
s=2;
lambda=010;
beta=0010;
%extraction des differents canaux
red=imageData(:,:,1);
green=imageData(:,:,2);
blue=imageData(:,:,3);
        
%Saturation
img_sat_red=SimplestColorBalance(red,s);
img_sat_green=SimplestColorBalance(green,s);
img_sat_blue=SimplestColorBalance(blue,s);
        
%Periodisation
img_prd_red=periodique(img_sat_red);
img_prd_green=periodique(img_sat_green);
img_prd_blue=periodique(img_sat_blue);


        
img_prd(:,:,1)=img_prd_red;
img_prd(:,:,2)=img_prd_green;
img_prd(:,:,3)=img_prd_blue;

tic
 [fft_u,ga]=Qmymain(img_prd,lambda,beta);
toc


[M,N,~]=size(imageData);
u=real(fft_u);
u_red=u(:,:,1);
u_green=u(:,:,2);
u_blue=u(:,:,3);

%%saturation
result(:,:,1)=SimplestColorBalance(u_red(1:M,1:N),s);
result(:,:,2)=SimplestColorBalance(u_green(1:M,1:N),s);
result(:,:,3)=SimplestColorBalance(u_blue(1:M,1:N),s);

        
figure; subplot(2,2,1), imshow(imageData/255), title('Degraded');
if paried==1
    PSNR=psnr(result./255,a./255);
    disp('paried')
    subplot(2,2,2), imshow(result/255), title(['Result PSNR=',num2str(PSNR),'dB']);
else
    PSNR='non';
    disp('no reference')
    NIQE=niqe(result./255);%Natural Image Quality Evaluator
    subplot(2,2,2), imshow(result/255), title(['Result NIQE=',num2str(NIQE)]);
end

subplot(2,2,3), imhist(mean(imageData(:,:,1),3)/255), title('Hist');
subplot(2,2,4), imhist(mean(result(:,:,1),3)/255), title('Hist');
figure;imshow(result./255)
figure;
subplot(1,2,1), imshow(a/255), title('gt');
subplot(1,2,2), imshow(result./255), title(['Result PSNR=',num2str(PSNR),'dB']);

 
