clear
clc
close all

%I=checkerboard(16,4,4);
I=im2gray(imread("cameraman.jpg"));
noise_var=1e-4;
LEN=15;
THETA=30;

psf=fspecial("motion",LEN,THETA);
blurred=imfilter(I,psf,"circular","conv");
g=imnoise(blurred,"gaussian",0,noise_var);


tic
K=2e-6;
dK=2e-6;
while K<=2e-2
    J1=deconvwnr(edgetaper(g,psf),psf,K);
    J2=deconvwnr(edgetaper(g,psf),psf,K+dK);
    MSE1=sum((I(:)-J1(:)).^2)/prod(size(I));
    MSE2=sum((I(:)-J2(:)).^2)/prod(size(I));
    if MSE1<=MSE2
        break
    end
    K=K+dK;
end
toc


K=linspace(0,2e-2,1e4);
K=K(2:end);
MSE=zeros(size(K));

disp('粗搜索')

tic
for i=1:length(K)
    J=deconvwnr(edgetaper(g,psf),psf,K(i));
    MSE(i)=sum((I(:)-J(:)).^2)/prod(size(I));
end
toc

[~,i]=min(MSE);
disp(['粗搜索得到的K=',num2str(K(i)),',MSE=',num2str(min(MSE))])


%MSE-K关系曲线
figure;
plot(K,MSE)
xlabel('K')
ylabel('MSE')




disp('细搜索')

tic
K_best=K_search(THETA,LEN,g,I);   %粒子群算法
toc

J=deconvwnr(edgetaper(g,psf),psf,K_best);
figure;
subplot(1,3,1)
imshow(I)
title('原图像')
subplot(1,3,2)
imshow(g)
title('运动模糊图像')
subplot(1,3,3)
imshow(J)
title('使用最佳K值对运动模糊图像进行维纳滤波')

disp(['细搜索得到的K=',num2str(K_best)])
calculate_MSE(I,J)
calculate_SNR(I,J,g)


%-----绘制最佳适应度随迭代次数的变化图-----
tic
MSE=1e8;
options=optimoptions('particleswarm','SwarmSize',50,'HybridFcn','fmincon'...
    ,'MaxIterations',10000,'PlotFcn','pswplotbestf');
[K0,MSE0]=particleswarm(@(K0)MSE_search(I,g,THETA,LEN,K0),1,0,1,options);
xlim([1,inf])
toc



