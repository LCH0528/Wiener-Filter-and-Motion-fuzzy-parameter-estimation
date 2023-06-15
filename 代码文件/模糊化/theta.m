clear
clc
close all

% I=checkerboard(16,8,8);
I=im2gray(imread('eight.tif'));
figure(1)
subplot(2,4,1)
imshow(I)
% title("原图像","FontSize",16)
figure(2)
subplot(2,4,1)
F=fftshift(fft2(I));
imshow(log(abs(F)+1),[])
% title("原图像频谱","FontSize",16)

LEN=20;
THETA=[0 30 45 60 90 120 135];
for i=1:length(THETA)
    psf=fspecial("motion",LEN,THETA(i));
    blurred=imfilter(I,psf,'circular','conv');
    figure(1)
    subplot(2,4,i+1)
    imshow(blurred)
%     title(['运动模糊图像(模糊角度：',num2str(THETA(i)),')'],"FontSize",16)
    figure(2)
    subplot(2,4,i+1)
    G=fftshift(fft2(blurred));
    imshow(log(abs(G)+1),[])
%     title(['模糊角度：',num2str(THETA(i))],"FontSize",16)
end



