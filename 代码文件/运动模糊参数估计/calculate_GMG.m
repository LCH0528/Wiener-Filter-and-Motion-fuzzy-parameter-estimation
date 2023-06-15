function GMG=calculate_GMG(I)
    [M,N]=size(I);
    dx=diff(I).^2;
    dx=dx(:,1:end-1);
    dy=diff(I,1,2).^2;
    dy=dy(1:end-1,:);
    GMG=sum(sum(sum(sqrt(double((dx+dy)/2.0)))))/((M-1)*(N-1));
end