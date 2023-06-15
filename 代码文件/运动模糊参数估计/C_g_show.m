clear
clc
close all

I=zeros(101,101);
I(50:52,50:52)=255;
I=mat2gray(I);
d=10;
noise_var=1e-4;
LEN=15;
THETA=30;

%-----模糊化-----
PSF=fspecial('motion',LEN,THETA);
g=imfilter(I,PSF,'circular','conv');
g=imnoise(g,"gaussian",0,noise_var);


figure;
subplot(1,4,1)
imshow(I)
subplot(1,4,2)
imshow(g(51-d:51+d,51-d:51+d))

G=fft2(g);
C_g=real(ifft2(log(abs(G)+1)));     %倒频谱
C_g=fftshift(C_g);                  %中心化
subplot(1,4,3)
imshow(C_g(51-d:51+d,51-d:51+d),[])
subplot(1,4,4)                      %直方图均衡化
imshow(histeq(C_g),[])

figure;
s=surf(fliplr(C_g));
s.EdgeColor='none';
view(THETA,0)
xlabel('x','FontSize',16)
ylabel('y','FontSize',16)
zlabel('C_g','FontSize',16)
colorbar
