%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%       Submitted By - Subham (MT19AMD007)      %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear variables
clear global
close all
clc
%% Inputs
global n dyna k rho Wp direc alpha
direc=-1; 
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


%% alpha
x=(pi/2)-(pi/n);
a=1;
b=1-rho;
c=sqrt(a^2 + b^2  - (2*a*b*cos(2*pi/n))); %Law of Cosine
temp=asin(b*sin(2*pi/n)/c); %Law of sine
theta=x-temp;
alpha=direc*((pi/n) +(theta)); % 0.1265 for n=5, 0.0926 for n=4
dyna=[cos(alpha) sin(alpha)
     -sin(alpha) cos(alpha)];

%% Solution of System
ts=[0 100];
[t, p] = ode45(@MT19AMD007_Task4_system,ts,p0);

%% Calculations
xc=sum(Wp(1,:))/n;
yc=sum(Wp(2,:))/n;

a=zeros(n,n);
for i=1:n
    for j=1:n
        if j==i
            a(i,j)=-1;
            if j==n
                a(i,1)=1-rho;
            else
                a(i,j+1)=1-rho;
            end
        end
    end
end
A=k*kron(a,dyna);
W=reshape(Wp,2*n,1);
V=A*p(end,:)' + (k*rho*kron(eye(n),dyna)*W);
v=zeros(1,n);
for i=2:2:2*n
    v(i/2)=sqrt(V(i-1)^2 + V(i)^2);
end

omega=max(imag(eig(A)))*sin(alpha);

R=abs(v(1)/omega);

ot=(2*pi*R)/v(1); %distance/velocity, distance = circumference of Circle

%% Plot
figure("name", "Subham (MT19AMD007)", "numbertitle", "off")
for i=1:length(t)
    plot(p(1:i,1),p(1:i,2),p(1:i,3),p(1:i,4),'--',p(1:i,5),p(1:i,6),'g-.',...
        x0,y0,'k*')
    xlabel('Horizontal position -X, in meters');
    ylabel('Vertical position -Y, in meters');
    drawnow

end
hold on
fig.WindowState='maximized';
axis equal
axis([min(min(min(p),min(min(Wp))))-10 max(max(max(p),max(max(Wp))))+10 ...
    min(min(min(p),min(min(Wp))))-10 max(max(max(p),max(max(Wp))))+10])
grid on
plot(x0,y0,'kx','MarkerSize',10)
wp=[Wp Wp(:,1)];
plot(xc,yc,'*',wp(1,:),wp(2,:),'o-')
title('Trajectories of the Agents')
xlabel('Position in X-direction (in m) \rightarrow')
ylabel('Position in Y-direction (in m)\rightarrow')
xline(xc,':');
yline(yc,':');
lgd=legend('Agent 1','Agent 2','Agent 3','Agent 4','initial position',...
    'Centoid','Way Points');
legend('Orientation','Horizontal')
lgd.NumColumns=2;
lgd.Location='northeastoutside';
hold off

%% Steady State Motion Plot, for clear view
figure("name", "Subham (MT19AMD007)", "numbertitle", "off")
s=ceil(length(t)/2);
hold on
axis equal
axis([min(min(min(p),min(min(Wp))))-10 max(max(max(p),max(max(Wp))))+10 ... 
    min(min(min(p),min(min(Wp))))-10 max(max(max(p),max(max(Wp))))+10])
plot(p(s:end,1),p(s:end,2),p(s:end,3),p(s:end,4),'--',p(s:end,5),p(s:end,6),...
    'g-.',p(s:end,7),p(s:end,8),'.-')
grid on
plot(xc,yc,'*',wp(1,:),wp(2,:),'ro-')
title('Steady State Trajectories of the Agents')
xlabel('Position in X-direction (in m) \rightarrow')
ylabel('Position in Y-direction (in m)\rightarrow')
xline(xc,':');
yline(yc,':');
hold off


%% To show as in Lecture  PDF Files
h={'n','\rho','x-cg','y-cg','\alpha','\omega','V','R','T'};
data=[n, rho, xc, yc, alpha, omega, v(1), R, ot];
disp(table(data(1),data(2),data(3),data(4),data(5),data(6),data(7),data(8),...
    data(9),'VariableNames',h))
%% Output on Command Window
disp('Initial Values:');
fprintf('Centroid:\n\t x= %.4f m\t y=%.4f m\n\n',xc,yc);
fprintf('\nalpha= %.4f rad\n',alpha);
fprintf('\nOmega= %0.4f rad/s\n\n',omega);
for i=2:2:2*n
    v(i/2)=sqrt(V(i-1)^2 + V(i)^2);
    str=['Steady State Velocity of Agent ',num2str(i/2),'is %.4f m/s\n'];
    fprintf(str,v(i/2));
end
fprintf('\nRadius of Final Circle is %.4f m\n',R);
fprintf('Orbital Time Period is %.4f s\n',ot);