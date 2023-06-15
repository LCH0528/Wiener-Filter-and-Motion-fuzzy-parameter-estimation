function K_best=K_search(theta_best,len_best,g,I)
    
    options=optimoptions('particleswarm','SwarmSize',50,'HybridFcn','fmincon','MaxIterations',500);
    f_min=1e8; 
    
    if nargin==4
        f=@(K0)MSE_search(I,g,theta_best,len_best,K0);
    elseif nargin==3
        psf=fspecial("motion",len_best,theta_best);
        f_J=@(K0)deconvwnr(edgetaper(g,psf),psf,K0);
        f=@(K0)10000-entropy(f_J(K0));
    end

    for j=1:5
        [K0,f0]=particleswarm(f,1,0,1,options);
        if f0<f_min
            K_best=K0;
            f_min=f0;
        end
    end

end