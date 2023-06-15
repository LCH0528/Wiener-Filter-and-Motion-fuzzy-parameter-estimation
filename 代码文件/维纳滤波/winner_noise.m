clear
clc
close all

% I=checkerboard(16,4,4);
I=im2gray(imread("lenna.jpg"));
noise_var=[1e-5,1e-3,1e-1];
LEN=10;
THETA=45;


[g1,J11,J12,J13]=winner_filter(I,noise_var(1),LEN,THETA);
[g2,J21,J22,J23]=winner_filter(I,noise_var(2),LEN,THETA);
[g3,J31,J32,J33]=winner_filter(I,noise_var(3),LEN,THETA);


figure;
subplot(1,4,1)
imshow(I)
% title('原图像','FontSize',18)
subplot(1,4,2)
imshow(g1,[])
% title(['退化图像(噪声方差：',num2str(noise_var(1)),')'],'FontSize',18)
subplot(1,4,3)
imshow(g2,[])
% title(['退化图像(噪声方差：',num2str(noise_var(2)),')'],'FontSize',18)
subplot(1,4,4)
imshow(g3,[])
% title(['退化图像(噪声方差：',num2str(noise_var(3)),')'],'FontSize',18)


figure;
subplot(3,3,1)
imshow(J11,[])
% title(['对退化图像进行逆滤波(噪声方差：',num2str(noise_var(1)),')'],'FontSize',16)
subplot(3,3,2)
imshow(J12,[])
% title('使用NSR对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,3)
imshow(J13,[])
% title('使用自相关函数对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,4)
imshow(J21,[])
% title(['对退化图像进行逆滤波(噪声方差：',num2str(noise_var(2)),')'],'FontSize',16)
subplot(3,3,5)
imshow(J22,[])
% title('使用NSR对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,6)
imshow(J23,[])
% title('使用自相关函数对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,7)
imshow(J31,[])
% title(['对退化图像进行逆滤波(噪声方差：',num2str(noise_var(3)),')'],'FontSize',16)
subplot(3,3,8)
imshow(J32,[])
% title('使用NSR对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,9)
imshow(J33,[])
% title('使用自相关函数对退化图像进行维纳滤波','FontSize',16)


disp(['(噪声方差：',num2str(noise_var(1)),')'])
calculate_MSE(I,J13)
calculate_SNR(I,J13,g1)
disp('----------')
disp(['(噪声方差：',num2str(noise_var(2)),')'])
calculate_MSE(I,J23)
calculate_SNR(I,J23,g2)
disp('----------')
disp(['(噪声方差：',num2str(noise_var(3)),')'])
calculate_MSE(I,J33)
calculate_SNR(I,J33,g3)
disp('----------')

