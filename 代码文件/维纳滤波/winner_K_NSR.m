clear
clc
close all

%I=checkerboard(16,4,4);
I=im2gray(imread("lenna.jpg"));
noise_var=1e-4;
LEN=10;
THETA=45;

psf=fspecial("motion",LEN,THETA);
blurred=imfilter(I,psf,'circular','conv');
blurred_noise=imnoise(blurred,"gaussian",0,noise_var);


figure;
subplot(2,4,1)
imshow(I)
% title('原图像','FontSize',9)
subplot(2,4,2)
imshow(blurred_noise)
% title('加了高斯噪声的运动模糊图像','FontSize',9)


NSR=[1 10 100 1000 1e4 1e5]*1e-5;   %checkerboard
%NSR=[0.1 10 250 2000 1e5]*1e-5;   %cameraman.jpg


for i=1:length(NSR)
J=deconvwnr(edgetaper(blurred_noise,psf),psf,NSR(i));
subplot(2,4,i+2)
imshow(J)
% title(['对加了高斯噪声的运动模糊图像进行维纳滤波（K=',num2str(NSR(i)),'）'],'FontSize',9)
disp(['(K值：',num2str(NSR(i)),')'])
calculate_MSE(I,J)
calculate_SNR(I,J,blurred_noise)
disp('----------')
end

