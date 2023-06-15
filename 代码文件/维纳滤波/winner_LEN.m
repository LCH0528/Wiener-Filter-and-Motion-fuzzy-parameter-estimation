clear
clc
close all

I=checkerboard(16,4,4);
% I=im2gray(imread("lenna.jpg"));
noise_var=1e-5;
LEN=[5,12,20];
THETA=45;


[g1,J11,J12,J13]=winner_filter(I,noise_var,LEN(1),THETA);
[g2,J21,J22,J23]=winner_filter(I,noise_var,LEN(2),THETA);
[g3,J31,J32,J33]=winner_filter(I,noise_var,LEN(3),THETA);


figure;
subplot(1,4,1)
imshow(I)
% title('原图像','FontSize',18)
subplot(1,4,2)
imshow(g1,[])
% title(['退化图像(模糊长度：',num2str(LEN(1)),')'],'FontSize',18)
subplot(1,4,3)
imshow(g2,[])
% title(['退化图像(模糊长度：',num2str(LEN(2)),')'],'FontSize',18)
subplot(1,4,4)
imshow(g3,[])
% title(['退化图像(模糊长度：',num2str(LEN(3)),')'],'FontSize',18)


figure;
subplot(3,3,1)
imshow(J11,[])
% title(['对退化图像进行逆滤波(模糊长度：',num2str(LEN(1)),')'],'FontSize',16)
subplot(3,3,2)
imshow(J12,[])
% title('使用NSR对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,3)
imshow(J13,[])
% title('使用自相关函数对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,4)
imshow(J21,[])
% title(['对退化图像进行逆滤波(模糊长度：',num2str(LEN(2)),')'],'FontSize',16)
subplot(3,3,5)
imshow(J22,[])
% title('使用NSR对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,6)
imshow(J23,[])
% title('使用自相关函数对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,7)
imshow(J31,[])
% title(['对退化图像进行逆滤波(模糊长度：',num2str(LEN(3)),')'],'FontSize',16)
subplot(3,3,8)
imshow(J32,[])
% title('使用NSR对退化图像进行维纳滤波','FontSize',16)
subplot(3,3,9)
imshow(J33,[])
% title('使用自相关函数对退化图像进行维纳滤波','FontSize',16)


disp(['(运动长度：',num2str(LEN(1)),')'])
calculate_MSE(I,J13)
calculate_SNR(I,J13,g1)
disp('----------')
disp(['(运动长度：',num2str(LEN(2)),')'])
calculate_MSE(I,J23)
calculate_SNR(I,J23,g2)
disp('----------')
disp(['(运动长度：',num2str(LEN(3)),')'])
calculate_MSE(I,J33)
calculate_SNR(I,J33,g3)
disp('----------')


