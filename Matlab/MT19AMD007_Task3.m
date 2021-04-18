
clc
clear
close all


[x,y,P,no_agents,kv,WP,rho,dir,alpha,aa] =  MT19AMD007_Task3_inputs();

time_span=[0 100];
[t, states_values] = ode45(@MT19AMD007_Task3_system,time_span,P);

xx=0; yy=0;
for i=2:2:2*no_agents
    xx=xx+states_values(end,i-1);
    yy=yy+states_values(end,i);
end
x_center = xx/no_agents;
y_center = yy/no_agents;



a_temp = ([]);
for i=1:no_agents
    for j=1:no_agents
        if j==i
            a_temp(i,j)=-1;
            if j==no_agents
                a_temp(i,1)=1-rho;
            else
                a_temp(i,j+1)=1-rho;
            end
        end
    end
end

C1=kv*kron(a_temp,aa);
C2=repmat(WP,no_agents,1);
Vl=C1*states_values(end,:)' + (kv*rho*kron(eye(no_agents),aa)*C2);

Vel = ([]);

for i=2:2:2*no_agents
    Vel(i/2)=sqrt(Vl(i-1)^2 + Vl(i)^2);
end

Omega = max(imag(eig(C1)))*sin(alpha);
Rid = abs(Vel(1)/Omega);
orb_t = (2*pi*Rid)/Vel(1);

figure("name", "Subham (MT19AMD007)", "numbertitle", "off")
for i=1:length(t)
    plot(states_values(1:i,1),states_values(1:i,2),'.-m',states_values(1:i,3),states_values(1:i,4),'.-r',...
        states_values(1:i,5),states_values(1:i,6),'.-g',states_values(1:i,7),states_values(1:i,8),'.-b',x,y,'k*',...
        x_center,y_center,'+',WP(1),WP(2),'o')
    xlabel('Horizontal position -X, in meters');
    ylabel('Vertical position -Y, in meters');
    title('Cyclic Pursuit for \rho = 0.14 and WP = [200,300]- Position Map')
    axis equal
    xline(x_center,':');
    yline(x_center,':');
    grid on
    drawnow
end
