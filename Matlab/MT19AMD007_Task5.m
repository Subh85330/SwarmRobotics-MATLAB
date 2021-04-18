%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%       Submitted By - Subham (MT19AMD007)      %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
close all
clear global

global n dyna k rho Wp direc alp
direc=1; % 1 for anti-clockwise and -1 for clockwise
n=3;
k=1;
% ini_values = [220 50 60 430 30 190 150 280];  % [x1 y1 x2 y2 ...... xn yn]
ini_values = [441.0675 307.1550 224.5613 432.1549 224.5623 182.1551];
x0= [ini_values(1) ini_values(3) ini_values(5)];
y0= [ini_values(2) ini_values(4) ini_values(6)];
p0=[x0; y0];

Wp=[300 425 175
    444.3375 227.8313 227.8313];
rho=0.75;

alp = -1.107;
t_span=[0 100];
[t, p] = ode45(@MT19AMD007_Task5_system,t_span,p0);


x_cg=mean(x0);
y_cg=mean(y0);

r=zeros([1 n]);
for i=1:n
    r(i)=sqrt((x_cg-x0(i))^2 + (y_cg-y0(i))^2);
end

omega=2*sin(alp);
a=zeros(n,n);
for i=1:n
    for j=1:n
        if j==i
            a(i,j)=-1;
            if j==n
                a(i,1)=1;
            else
                a(i,j+1)=1;
            end
        end
    end
end
A=k*kron(a,dyna);
V=A*p(end,:)';
v=zeros(1,n);
for i=2:2:2*n
    v(i/2)=sqrt(V(i-1)^2 + V(i)^2);
end

R=abs(v(1)/omega);

ot=(2*pi*R)/v(1); 
disp('Initial Values:');
fprintf('Centre:\n\t x= %.4f m\t y=%.4f m\n\n',x_cg,y_cg);
for i=1:n
    str=['Initial Radius of Agent ',num2str(i),'=%.4f m\n'];
    fprintf(str,r(i));
end
fprintf('\nalp= %.4f rad\n',alp);
fprintf('\nOmega= %0.4f rad/s\n\n',omega);
for i=2:2:2*n
    v(i/2)=sqrt(V(i-1)^2 + V(i)^2);
    str=['Steady State Velocity of Agent ',num2str(i/2),'= %.4f m/s\n'];
    fprintf(str,v(i/2));
end
fprintf('\nRadius of Final Circle= %.4f m\n',R);
fprintf('Orbital Time Period= %.4f s\n',ot);
fig=figure("name", "Subham (MT19AMD007)", "numbertitle", "off");

for i=1:length(t)
    plot(p(1:i,1),p(1:i,2),p(1:i,3),p(1:i,4),'--',p(1:i,5),p(1:i,6),'g-.',p(1:i,7),p(1:i,8),'.-')
    xlabel('Horizontal position -X, in meters');
    ylabel('Vertical position -Y, in meters');
    drawnow
    drawnow

end
hold on
wp=[Wp_f Wp_f(:,1)];
plot(wp(1,:),wp(2,:),'ro-')

grid on
plot(x0,y0,'kx',x_cg,y_cg,'*', Wp(1), Wp(2),'o')
legend('Orientation','Horizontal')
title('Trajectories of the Agents')
xlabel('Horizontal position -X, in meters');
ylabel('Vertical position -Y, in meters');
drawnow
xline(x_cg,':');
yline(y_cg,':');
lgd = legend({'Agent 1','Agent 2','Agent 3','Agent 4','Waypoint_four','initial position','Centre', 'Way-Points'}, 'Location', 'northwest', 'color', 'none');
legend('boxoff')
legend('Orientation','vertical')
hold off