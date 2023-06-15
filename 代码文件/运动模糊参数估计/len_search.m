function len_best=len_search(g,theta_best)
%---倒谱法估计运动模糊尺度---
    g=medfilt2(g);
    G=fft2(g);
    G=log(1+abs(G));
    C_g=real(ifft2(G));

    C_g_rot=imrotate(C_g,-theta_best);
    C_g_mean=mean(C_g_rot);

    ind=0;
    for i=1:length(C_g_mean)
        if C_g_mean(i)<0
            ind=i;
            break
        end
    end

    if ind==0
        lowest_peak=1e4;
        for i=1:round(length(C_g_mean)/2)
            if lowest_peak > C_g_mean(i)
                lowest_peak = C_g_mean(i);
                ind=i;
            end
        end
    end

    len_best=ind;


%---作图---

    %---灰度平均值曲线---
    figure;
    plot(C_g_mean)
    hold on
    plot(len_best,C_g_mean(len_best),'ro')
    xlim([0,length(C_g_mean)])
    xlabel('列数','FontSize',18)
    ylabel('灰度平均值','FontSize',18)


    %---倒频谱（中心化）---
%     figure;
%     imshow(C_g)
%     C_g_mid=fftshift(C_g);
%     figure;
%     imshow(C_g_mid)
    
    
%     figure;
%     s=surf(fliplr(C_g_mid));
%     s.EdgeColor='none';
%     view(theta_best,0)
%     
%     [M,N]=size(g);
%     xlim([M/2-50,M/2+50])
%     ylim([N/2-50,N/2+50])
%     
%     xlabel('x','FontSize',16)
%     ylabel('y','FontSize',16)
%     zlabel('C_g','FontSize',16)
%     colorbar
%     figure;
%     s=surf(fliplr(C_g_mid));
%     s.EdgeColor='none';
%     view(2)
%     xlabel('x','FontSize',18)
%     ylabel('y','FontSize',18)
%     colorbar


    %---直方图均衡化---
    C_g=histeq(C_g);

    figure;
    subplot(2,2,1)
    imshow(C_g)
    C_g_rot=imrotate(C_g,-theta_best);
    subplot(2,2,3)
    imshow(C_g_rot,[])
    subplot(2,2,[2 4])
    imhist(C_g)

    
%     figure;
%     s=surf(fliplr(C_g));
%     s.EdgeColor='none';
%     xlabel('x','FontSize',16)
%     ylabel('y','FontSize',16)
%     zlabel('灰度值','FontSize',16)
%     colorbar
%     figure;
%     s=surf(fliplr(C_g));
%     s.EdgeColor='none';
%     view(2)
%     xlabel('x','FontSize',18)
%     ylabel('y','FontSize',18)
%     colorbar


    %---中心化---
    C_g_mid=fftshift(C_g);
    figure;
    imshow(C_g_mid)


%     figure;
%     s=surf(fliplr(C_g_mid));
%     s.EdgeColor='none';
%     xlabel('x','FontSize',16)
%     ylabel('y','FontSize',16)
%     zlabel('灰度值','FontSize',16)
%     colorbar
%     figure;
%     s=surf(fliplr(C_g_mid));
%     s.EdgeColor='none';
%     view(2)
%     xlabel('x','FontSize',18)
%     ylabel('y','FontSize',18)
%     colorbar

end