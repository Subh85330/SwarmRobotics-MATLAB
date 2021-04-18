function p_dot = MT19AMD007_Task4_system(~,z)
    global n dyna k rho Wp
    x=zeros(1,n);
    y=zeros(1,n);
    for i=2:2:size(z)
        x(i/2)=z(i-1);
        y(i/2)=z(i);
    end
    p=[x
       y];
    dp=zeros(2,n);
    p_tdot=zeros(2,n);
    for i=1:n
        if i==n
            dp(:,i) = p(:,1)*(1-rho) - p(:,i);
        else
            dp(:,i) = p(:,i+1)*(1-rho) - p(:,i);
        end
         p_tdot(:,i)=k*((dyna*dp(:,i))+(rho*dyna*(Wp(:,i))));
    end
    %converting a matrix of n x m to column vector of size nm
    p_dot = reshape(p_tdot,[],1);
end