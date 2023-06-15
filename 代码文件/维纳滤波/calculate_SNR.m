function calculate_SNR(I,J,g)
    SNR=10*log10(sum(I(:).^2)/sum((I(:)-J(:)).^2));
    PSNR=10*log10(255^2*prod(size(I,[1,2]))/sum((I(:)-J(:)).^2));
    ISNR=10*log10(sum((g(:)-I(:)).^2)/sum((J(:)-I(:)).^2));
    disp(['信噪比SNR=',num2str(SNR)])
    disp(['峰值信噪比PSNR=',num2str(PSNR)])
    disp(['信噪比改善因子ISNR=',num2str(ISNR)])
end