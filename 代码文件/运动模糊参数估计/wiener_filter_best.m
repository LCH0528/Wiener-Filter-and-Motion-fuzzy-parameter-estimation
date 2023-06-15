function [theta_best,len_best,K_best]=wiener_filter_best(g,I)
    flag=0;
    if nargin==1
        flag=1;
    end
    disp('-----运动模糊角度估计-----')
    tic
    theta_best=theta_search(g,flag);
    disp(['运动模糊角度估计值：',num2str(theta_best)])
    toc
    disp('-----------')
    
    disp('-----运动模糊长度估计-----')
    tic
    len_best=len_search(g,theta_best);
    disp(['运动模糊长度估计值：',num2str(len_best)])
    toc
    disp('-----------')
    
    disp('-----K值估计-----')
    tic
    if nargin==2
        K_best=K_search(theta_best,len_best,g,I);
    elseif nargin==1
        K_best=K_search(theta_best,len_best,g);
    end
    disp(['K的估计值：',num2str(K_best)])
    toc
    disp('-----------')
end