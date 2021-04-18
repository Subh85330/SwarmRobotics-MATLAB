
function [P_d] = MT19AMD007_Task3_system(t,Y0)
[~,~,~,n,k,Way_pt,rho,~,~,dy] =  MT19AMD007_Task3_inputs();

a = ([]);
b = ([]);
for i=2:2:size(Y0)
    a(i/2) = Y0(i-1);
    b(i/2) = Y0(i);
end
c=[a; b];
d_p = ([]);
p_d = ([]);
for i=1:n
    if i==n
        d_p(:,i) = c(:,1)*(1-rho) - c(:,i);
    else
        d_p(:,i) = c(:,i+1)*(1-rho) - c(:,i);
    end
    p_d(:,i)=k*((dy*d_p(:,i))+(rho*dy*(Way_pt)));
end
P_d = reshape(p_d,[],1); 
end