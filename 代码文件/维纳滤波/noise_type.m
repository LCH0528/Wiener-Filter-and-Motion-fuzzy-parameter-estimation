clear
clc
close all

I=checkerboard(16,8,8);
%I=im2gray(imread('eight.tif'));
LEN=10;
THETA=45;
psf=fspecial("motion",LEN,THETA);
blurred=imfilter(I,psf,'circular','conv');

g1=imnoise(blurred,"gaussian",0,1e-2);
noise1=g1-blurred;
g2=imnoise(blurred,'salt & pepper',0.15);
noise2=g2-blurred;

figure;
subplot(2,4,1)
imshow(I)
title('原图像')
subplot(2,4,2)
imshow(blurred)
title('运动模糊图像')
subplot(2,4,3)
imshow(g1)
title('加了高斯噪声的运动模糊图像')
subplot(2,4,4)
imshow(g2)
title('加了椒盐噪声的运动模糊图像')


ICORR=real(ifft2(abs(fft2(I)).^2));
NCORR1=real(ifft2(abs(fft2(noise1)).^2));
NCORR2=real(ifft2(abs(fft2(noise2)).^2));

J1=deconvwnr(edgetaper(blurred,psf),psf,0);
J2=deconvwnr(edgetaper(g1,psf),psf,NCORR1,ICORR);
J3=deconvwnr(edgetaper(g2,psf),psf,NCORR2,ICORR);
subplot(2,4,6)
imshow(J1)
title('对运动模糊图像进行维纳滤波')
subplot(2,4,7)
imshow(J2)
title('对加了高斯噪声的运动模糊图像进行维纳滤波')
subplot(2,4,8)
imshow(J3)
title('对加了椒盐噪声的运动模糊图像进行维纳滤波')


disp("运动模糊图像")
calculate_MSE(I,J1)
calculate_SNR(I,J1,blurred)
disp('----------')
disp('加了高斯噪声的运动模糊图像')
calculate_MSE(I,J2)
calculate_SNR(I,J2,g1)
disp('----------')
disp('加了椒盐噪声的运动模糊图像')
calculate_MSE(I,J3)
calculate_SNR(I,J3,g2)
disp('----------')


