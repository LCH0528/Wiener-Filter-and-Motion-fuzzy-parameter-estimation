clear
clc
close all

%I=checkerboard(16,8,8);
I=im2gray(imread('cameraman.jpg'));
LEN=10;
THETA=45;
psf=fspecial("motion",LEN,THETA);
blurred=imfilter(I,psf,"circular",'conv');

mean_noise=0;
var_noise=1e-4;
blurred_noise=imnoise(blurred,"gaussian",mean_noise,var_noise);
noise=blurred_noise-blurred;
I_noise=I+noise;

figure;
subplot(1,3,1)
imshow(I)
%title('原图像','FontSize',18)
subplot(1,3,2)
imshow(blurred)
% title('运动模糊图像','FontSize',18)
subplot(1,3,3)
imshow(blurred_noise)
% title('加了高斯噪声的运动模糊图像','FontSize',18)


F=fft2(I);
F0=fftshift(F);
B=fft2(blurred);
B0=fftshift(B);
G=fft2(blurred_noise);
G0=fftshift(G);


figure;
subplot(2,3,1)
imshow(log(abs(F0)+1),[])
% title('原图像的幅度谱','FontSize',18)
subplot(2,3,2)
imshow(log(abs(B0)+1),[])
% title('运动模糊图像的幅度谱','FontSize',18)
subplot(2,3,3)
imshow(log(abs(G0)+1),[])
% title('加了高斯噪声的运动模糊图像的幅度谱','FontSize',18)
subplot(2,3,4)
imshow(angle(F0),[])
% title('原图像的相位谱','FontSize',18)
subplot(2,3,5)
imshow(angle(B0),[])
% title('运动模糊图像的相位谱','FontSize',18)
subplot(2,3,6)
imshow(angle(G0),[])
% title('加了高斯噪声的运动模糊图像的相位谱','FontSize',18)


N=fft2(noise);
P_n=abs(N).^2;
n_A=sum(P_n(:))/prod(size(noise));
P_f=abs(F).^2;
f_A=sum(P_f(:))/prod(size(I));
NSR=n_A./f_A;
NCORR=real(ifft2(abs(N).^2));
ICORR=real(ifft2(abs(F).^2));


blurred0=edgetaper(blurred,psf);
J11=deconvwnr(blurred0,psf);
J12=deconvwnr(blurred0,psf,NSR);
J13=deconvwnr(blurred0,psf,NCORR,ICORR);
blurred_noise0=edgetaper(blurred_noise,psf);
J21=deconvwnr(blurred_noise0,psf);
J22=deconvwnr(blurred_noise0,psf,NSR);
J23=deconvwnr(blurred_noise0,psf,NCORR,ICORR);


figure;
subplot(2,3,1)
imshow(J11)
% title('对运动模糊图像进行逆滤波','FontSize',12)
subplot(2,3,2)
imshow(J12)
% title('使用NSR对运动模糊图像进行维纳滤波','FontSize',12)
subplot(2,3,3)
imshow(J13)
% title('使用自相关函数对运动模糊图像进行维纳滤波','FontSize',12)
subplot(2,3,4)
imshow(J21)
% title('对加了高斯噪声的运动模糊图像进行逆滤波','FontSize',12)
subplot(2,3,5)
imshow(J22)
% title('使用NSR对加了高斯噪声的运动模糊图像进行维纳滤波','FontSize',12)
subplot(2,3,6)
imshow(J23)
% title('使用自相关函数对加了高斯噪声的运动模糊图像进行维纳滤波','FontSize',12)


disp('对运动模糊图像进行逆滤波')
calculate_MSE(I,J11)
calculate_SNR(I,J11,blurred)
disp('----------')
disp('使用NSR对运动模糊图像进行维纳滤波')
calculate_MSE(I,J12)
calculate_SNR(I,J12,blurred)
disp('----------')
disp('使用自相关函数对运动模糊图像进行维纳滤波')
calculate_MSE(I,J13)
calculate_SNR(I,J13,blurred)
disp('----------')
disp('对加了高斯噪声的运动模糊图像进行逆滤波')
calculate_MSE(I,J21)
calculate_SNR(I,J21,blurred_noise)
disp('----------')
disp('使用NSR对加了高斯噪声的运动模糊图像进行维纳滤波')
calculate_MSE(I,J22)
calculate_SNR(I,J22,blurred_noise)
disp('----------')
disp('使用自相关函数对加了高斯噪声的运动模糊图像进行维纳滤波')
calculate_MSE(I,J23)
calculate_SNR(I,J23,blurred_noise)
disp('----------')


