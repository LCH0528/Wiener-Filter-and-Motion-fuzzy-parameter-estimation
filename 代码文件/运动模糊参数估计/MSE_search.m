function MSE0 = MSE_search(I,g,theta,len,K0)
    psf=fspecial("motion",len,theta);
    J=deconvwnr(edgetaper(g,psf),psf,K0);
    MSE0=sum((I(:)-J(:)).^2)/prod(size(I));
end