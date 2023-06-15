function SF=calculate_SF(I)
    [M,N]=size(I);
    RF=sqrt(sum(sum(sum(diff(I,1,2).^2)))/(M*N));
    CF=sqrt(sum(sum(sum(diff(I).^2)))/(M*N));
    SF=sqrt(RF.^2+CF.^2);
end