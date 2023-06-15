clear
clc
close all

%-----实际图片的维纳滤波-----
I=imread('realimage_car2.png');
I=rgb2gray(I);

%-----运动模糊角度估计-----
disp('-----运动模糊角度估计-----')
tic
theta_best=theta_search(I,1);
disp(['运动模糊角度估计值：',num2str(theta_best)])
theta_best=input('运动模糊角度主观估计值：')
toc
disp('-----------')

if theta_best>90
    theta_best=theta_best-180;
end
if theta_best<-90
    theta_best=theta_best+180;
end


% %-----"粒子群算法"估计运动模糊长度-----
% disp('"粒子群算法"估计运动模糊长度和K值')
% tic
% options=optimoptions('particleswarm','SwarmSize',50,'HybridFcn','fmincon','MaxIterations',500);
% J0=@(x)deconvwnr(edgetaper(I,fspecial("motion",x(1),theta_best)) ...
%     ,fspecial("motion",x(1),theta_best),x(2));
% f=@(x)10000-entropy(J0(x));
% x0=particleswarm(f,2,[2,1e-5],[20 0.1],options);
% L0=x0(1);    %初步估计运动模糊长度
% toc
% disp('-----------')
% 
% 
%-----用"网格法"估计运动模糊长度和K值-----
% % tic
% % disp('用"网格法"估计运动模糊长度和K值')
% % f_max=0;
% % for LEN=5:1:15
% %     for K=1e-3:1e-4:1e-1
% %         psf=fspecial('motion',LEN,theta_best);
% %         J_search=deconvwnr(edgetaper(I,psf),psf,K);
% %         f1=mean(double(J_search(:)));
% %           if f1>f_max
% %               len_best=LEN;
% %               K_best=K;
% %               f_max=f1;
% %           end
% %     end
% % end
% % disp('-----------')
% % toc

% K1=1e-3;
% len_best=L0;


%-----主观估计运动模糊长度和K值-----
disp('-----主观估计运动模糊长度和K值-----')
tic
len_best=[5 10 15 20];
K_best=[0.0001 0.001 0.01 0.05];
figure;
for i=1:length(K_best)
    for j=1:length(len_best)
        psf=fspecial("motion",len_best(j),theta_best);
        J=deconvwnr(edgetaper(I,psf),psf,K_best(i));
        subplot(length(K_best),length(len_best),(i-1)*length(len_best)+j)
        imshow(J)
    end
end
toc
disp('-----------')


len_best=input('运动模糊长度估计值：');
K_best=input('K的估计值：');


% % -----用第一次维纳滤波的结果估计K值-----
% disp('-----用第一次维纳滤波的结果估计K值-----')
% tic
% K1=5e-3;
% psf=fspecial('motion',len_best,theta_best);
% J01=deconvwnr(edgetaper(I,psf),psf,K1);
% p_f=sum(abs(J01(:)).^2)/prod(size(I));
% sigma_n2=sum(sum((double(I)-conv2(J01,psf,'same')).^2))/prod(size(I));
% K_best=sigma_n2/p_f;
% toc
% disp('-----------')


%-----显示图像-----
psf=fspecial("motion",len_best,theta_best);
J=deconvwnr(edgetaper(I,psf),psf,K_best);
figure;
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imshow(J)

%-----客观评价指标-----
J=deconvwnr(edgetaper(I,psf),psf,K_best);
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

