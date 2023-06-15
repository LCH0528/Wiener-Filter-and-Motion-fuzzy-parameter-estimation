function theta_best=theta_search(f,flag)
%---退化图像的频谱---
    f=im2double(f);
    F=fftshift(fft2(f));
    F=log(abs(F)+1);
    [M,N]=size(F);
    figure;
    imshow(F,[])

%---退化图像的二次频谱---
    F2=fftshift(fft2(F));
    F2=log(abs(F2)+1);
    figure;
    subplot(1,2,1)
    imshow(F2,[])

    [px,py]=find(F2==max(F2(:)));   %找出十字亮线的中心：灰度最大的点的位置

if flag==1
%---去除十字亮线---
    p=mean(F2(:));
    F2(px,:)=p;
    F2(:,py)=p;
    subplot(1,2,2)
    imshow(F2,[])
%---灰度变换（实际图像）---
    F2=imadjust(rescale(F2,0,1),[0.8 1],[0.9 1]);
    figure;
    subplot(1,2,1)
    imshow(F2(px-10:px+10,py-10:py+10),[])
end

%---边缘检测和二值化--- 
    T=graythresh(F2);
    bw=edge(F2,'canny',T);
    subplot(1,2,2)
if flag==1
    imshow(bw(px-10:px+10,py-10:py+10))
else
    imshow(bw)
end


%---对二值化图像进行radon变换，找到运动模糊角度的估计值---
    t=0:0.1:180;
%     R=radon(bw,t);      %radon变换
    R=radon(bw,t)./radon(ones(size(bw)),t);      %归一化radon变换：抑制"对角线干扰"
    R=max(R);
    figure;
    plot(t,R)
    xlabel('角度/(°)','FontSize',18)
    ylabel('R_{max}','FontSize',18)
    [~,a]=max(R);
    theta_best=atan(tan((t(a)-90)*pi/180))*180/pi;
    theta_best=mod(theta_best,180);

end