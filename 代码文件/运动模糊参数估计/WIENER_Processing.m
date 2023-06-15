clear
clc
close all

%-----参考图片的模糊化和维纳滤波-----
% I=checkerboard(16,4,4);
I=im2gray(imread("lenna.jpg"));
noise_var=1e-4;
LEN=15;
THETA=30;

%-----模糊化-----
PSF=fspecial('motion',LEN,THETA);
blurred=imfilter(I,PSF,'circular','conv');
g=imnoise(blurred,"gaussian",0,noise_var);


%-----维纳滤波-----
[theta_best,len_best,K_best]=wiener_filter_best(g,I);
tic
K0=K_search(THETA,LEN,g,I);
disp(['K的实际值：',num2str(K0)])
toc

%-----显示图像-----
psf=fspecial("motion",len_best,theta_best);
J=deconvwnr(edgetaper(g,psf),psf,K_best);
figure;
subplot(1,4,1)
imshow(I)
subplot(1,4,2)
imshow(g)
subplot(1,4,3)
imshow(J)
subplot(1,4,4)
psf=fspecial("motion",LEN,THETA);
J0=deconvwnr(edgetaper(g,psf),psf,K0);
imshow(J0)

%-----客观评价指标-----
disp('-----客观评价指标-----')
disp('估计模糊参数：')
calculate_MSE(I,J)
calculate_SNR(I,J,g)
disp('实际模糊参数：')
calculate_MSE(I,J0)
calculate_SNR(I,J0,g)
disp('-----------')

