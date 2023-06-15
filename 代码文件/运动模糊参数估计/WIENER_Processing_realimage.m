clear
clc
close all

%-----实际图片的维纳滤波-----
I=im2gray(imread('realimage1_4.jpg'));

%-----维纳滤波-----
[theta_best,len_best,K_best]=wiener_filter_best(I);

%-----显示图像-----
psf=fspecial("motion",len_best,theta_best);
J=deconvwnr(edgetaper(I,psf),psf,K_best);
figure;
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imshow(J)

%-----客观评价指标-----
disp('-----客观评价指标-----')
H_I=entropy(I);
H_J=entropy(J);
disp(['熵：退化图像：',num2str(H_I),'；维纳滤波后的图像：',num2str(H_J)])
GMG_I=calculate_GMG(I);
GMG_J=calculate_GMG(J);
disp(['平均灰度梯度：退化图像：',num2str(GMG_I),'；维纳滤波后的图像：',num2str(GMG_J)])
SF_I=calculate_SF(I);
SF_J=calculate_SF(J);
disp(['空间频率：退化图像：',num2str(SF_I),'；维纳滤波后的图像：',num2str(SF_J)])
disp('-----------')

