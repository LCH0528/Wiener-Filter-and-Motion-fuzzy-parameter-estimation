function calculate_MSE(I,J)
    MSE=sum((I(:)-J(:)).^2)/prod(size(I));
    disp(['均方误差MSE=',num2str(MSE)])
end