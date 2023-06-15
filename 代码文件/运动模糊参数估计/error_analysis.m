clear
clc
close all


% I=checkerboard(16,4,4);
I=im2gray(imread("cameraman.jpg"));
noise_var=1e-4;


%-----模糊角度误差分析----- 
disp('-----模糊角度误差分析-----')
tic
LEN=[5,10,15,20,30,50];
THETA=0:5:180;
line_type={'r-o','k-*','m-d','c-s','g-v','b-h'};    %绘图线型配表
dtheta=zeros(length(LEN),length(THETA));
figure;
for i=1:length(LEN)
    for j=1:length(THETA)
        %-----模糊化-----
        PSF=fspecial('motion',LEN(i),THETA(j));
        blurred=imfilter(I,PSF,'circular','conv');
        g=imnoise(blurred,"gaussian",0,noise_var);
        theta_best=theta_search(g,0);
        dtheta(i,j)=theta_best-THETA(j);
        if dtheta(i,j)>=90
            dtheta(i,j)=dtheta(i,j)-180;
        end
        if dtheta(i,j)<=-90
            dtheta(i,j)=dtheta(i,j)+180;
        end
    end
    plot(THETA,dtheta(i,:),line_type{1,i})
    hold on
end
ylim([-90 90])
set(gca,'YTick',-90:15:90)
xlabel('模糊角度\theta/(°)','FontSize',18)
ylabel('绝对误差/(°)','FontSize',18)
legend('模糊长度：5','模糊长度：10','模糊长度：15','模糊长度：20','模糊长度：30','模糊长度：50')
toc
disp('----------')



%-----模糊长度误差分析----- 
disp('-----模糊长度误差分析-----')
tic
LEN=[2,3,4,5,8,10:5:50,60:10:100];
THETA=[0 30 45 60 90 120];
line_type={'r-o','k-*','m-d','c-s','g-v','b-h'};    %绘图线型配表
dlen=zeros(length(THETA),length(LEN));
figure;
for i=1:length(THETA)
    for j=1:length(LEN)
        %-----模糊化-----
        PSF=fspecial('motion',LEN(j),THETA(i));
        blurred=imfilter(I,PSF,'circular','conv');
        g=imnoise(blurred,"gaussian",0,noise_var);
        len_best=len_search(g,THETA(i));
        dlen(i,j)=len_best-LEN(j);
    end
    plot(LEN,dlen(i,:),line_type{1,i})
    hold on
end
ylim([-100 100])
set(gca,'XTick',[0:5,10:5:50,60:10:100])
xlabel('模糊长度L','FontSize',18)
ylabel('绝对误差','FontSize',18)
legend('模糊角度：0°','模糊角度：30°','模糊角度：45°','模糊角度：60°','模糊角度：90°','模糊角度：120°')
toc
disp('----------')



