function p_dot = MT19AMD007_Task5_system(~,z)
    global n dyna k rho Wp direc alp
    persistent p_last
    x=zeros(1,n);
    y=zeros(1,n);
    for i=2:2:size(z)
        x(i/2)=z(i-1);
        y(i/2)=z(i);
    end
    p=[x
       y];
   if isempty(p_last)
       p_last=zeros(2,n);
   end
    dp=zeros(2,n);
    p_tdot=zeros(2,n);
    for i=1:n
        if i==n
            dp(:,i) = p(:,1)*(1-rho) - p(:,i);
            vl=rho*Wp + ((1-rho)*p(:,1));
        else
            dp(:,i) = p(:,i+1)*(1-rho) - p(:,i);
            vl=rho*Wp + ((1-rho)*p(:,i+1));
        end
%         alp=atan((vl(2)-p(2,i))/(vl(1)-p(1,i))) - atan((p_last(2,i)-p(2,i))/(p_last(1,i)-p(1,i)));
        dyna=[cos(alp) sin(alp)
             -sin(alp) cos(alp)];
         p_tdot(:,i)=k*((dyna*dp(:,i))+(rho*dyna*(Wp)));
    end
    p_last=p;
    p_dot = reshape(p_tdot,[],1); %converting a matrix of n x m to column vector of size nm
end