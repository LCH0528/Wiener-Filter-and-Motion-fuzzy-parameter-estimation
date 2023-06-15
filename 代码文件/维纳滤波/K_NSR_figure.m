clear
clc
close all

%I=checkerboard(16,4,4);
I=im2gray(imread("lenna.jpg"));
noise_var=1e-5;
LEN=10;
THETA=45;

psf=fspecial("motion",LEN,THETA);
blurred=imfilter(I,psf,'circular','conv');
g=imnoise(blurred,"gaussian",0,noise_var);


K=linspace(0,2e-2,1e4);
K=K(2:end);
MSE=zeros(size(K));
SNR=MSE;
PSNR=MSE;
ISNR=MSE;

tic
for i=1:length(K)
    J=deconvwnr(edgetaper(g,psf),psf,K(i));
    MSE(i)=sum((I(:)-J(:)).^2)/prod(size(I));
    SNR(i)=10*log10(sum(I(:).^2)/sum((I(:)-J(:)).^2));
    PSNR(i)=10*log10(255^2*prod(size(I))/sum((I(:)-J(:)).^2));
    ISNR(i)=10*log10(sum((g(:)-I(:)).^2)/sum((J(:)-I(:)).^2));
end
toc


% figure;
% subplot(4,1,1)
% plot(K,MSE)
% xlabel('K')
% ylabel('MSE')
% subplot(4,1,2)
% plot(K,SNR)
% xlabel('K')
% ylabel('SNR/dB')
% subplot(4,1,3)
% plot(K,PSNR)
% xlabel('K')
% ylabel('PSNR/dB')
% subplot(4,1,4)
% plot(K,ISNR)
% xlabel('K')
% ylabel('ISNR/dB')


figure;
plot(K,MSE)
xlabel('K','FontSize',18)
ylabel('MSE','FontSize',18)
figure;
plot(K,SNR)
hold on
plot(K,PSNR)
plot(K,ISNR)
xlabel('K','FontSize',18)
ylabel('信噪比/dB','FontSize',18)
ylim([-10 80])
legend('SNR','PSNR','ISNR')




