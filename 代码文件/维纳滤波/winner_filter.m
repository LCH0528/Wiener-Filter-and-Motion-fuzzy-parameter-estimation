function [g,J1,J2,J3]=winner_filter(I,noise_var,LEN,THETA)
    psf=fspecial("motion",LEN,THETA);
    blurred=imfilter(I,psf,'circular','conv');
    g=imnoise(blurred,"gaussian",0,noise_var);
    noise=g-blurred;

    F=fft2(I);
    N=fft2(noise);
    P_f=abs(F).^2;
    P_n=abs(N).^2;
    f_A=sum(P_f(:))/prod(size(I));
    n_A=sum(P_n(:))/prod(size(noise));
    NSR=n_A/f_A;
    ICORR=real(ifft2(P_f));
    NCORR=real(ifft2(P_n));

    g0=edgetaper(g,psf);
    J1=deconvwnr(g0,psf);
    J2=deconvwnr(g0,psf,NSR);
    J3=deconvwnr(g0,psf,NCORR,ICORR);
end