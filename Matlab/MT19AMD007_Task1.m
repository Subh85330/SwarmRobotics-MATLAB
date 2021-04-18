%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%       Submitted By - Subham (MT19AMD007)      %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clc
clear
close all

no_agents=4; %Number of agents
kv=1;

% Task 1 - uncomment this section for taks 1
ini_values = [10;30;300;50;350;390;40;300]; %[x1 y1 x2 y2 ...... xn yn]
x0= [ini_values(1) ini_values(3) ini_values(5) ini_values(7)];
y0= [ini_values(2) ini_values(4) ini_values(6) ini_values(8)];



alpha=pi/no_agents;

aa=[cos(alpha) sin(alpha); -sin(alpha) cos(alpha)];


x_center=mean(x0);
y_center=mean(y0);


a_temp=zeros(no_agents,no_agents);
temp=1;
for i=1:no_agents
    for j=1:no_agents
        if j==temp
            a_temp(i,j)=-1;
            if j==no_agents
                a_temp(i,1)=1;
            else
                a_temp(i,j+1)=1;
            end
        end
    end
    temp=temp+1;
end
A=kv*kron(a_temp,aa);
B = zeros(8,1); D = zeros(8,1);
C=eye(2*no_agents);
sys = ss(A,B,C,B);
[y, t, states_values]=initial(sys,ini_values);


figure("name", "Subham (MT19AMD007)", "numbertitle", "off") 
for i=1:length(t)/100 
    hold off
    plot(states_values(1:i,1),states_values(1:i,2),'b',states_values(1:i,3),states_values(1:i,4),....
        'r-.',states_values(1:i,5),states_values(1:i,6),'m--',states_values(1:i,7),states_values(1:i,8),...
        'k',x0,y0,'x',x_center,y_center,'*')
    axis([-50 400 -50 450])
    grid on
    box on
    xlabel('Horizontal position -X, in meters');
    ylabel('Vertical position -Y, in meters');
    title('Cyclic Persuit Consensus - Position Map');
    hold on
    %legends
    plot([-45,-25],[435,435],"b"); text(-20,435,'agent1');
    plot([-45,-25],[405,405],"r-."); text(-20,405,'agent2');
    plot([305,325],[435,435],"m--"); text(330,435,'agent3');
    plot([305,325],[405,405],"k"); text(330,405,'agent4');
    
    % center and axis through the center
    min_max_axis = axis;
    
    plot([min_max_axis(1), min_max_axis(2)],[y_center, y_center],'c:');
    plot([x_center, x_center],[min_max_axis(3), min_max_axis(4)],'c:');
    plot(x_center,y_center,'x', "MarkerSize",15);
    
    drawnow
end


figure("name", "Subham (MT19AMD007)", "numbertitle", "off")
hold on;
plot(states_values(:,1),states_values(:,2),"b",states_values(:,3),states_values(:,4),....
    "r-.",states_values(:,5),states_values(:,6),"m--",states_values(:,7),states_values(:,8),"k");
axis([-50 400 -50 450])
grid on
box on
xlabel('Horizontal position -X, in meters');
ylabel('Vertical position -Y, in meters');
title('Cyclic Persuit Consensus - Position Map');


% center and axis through the center
min_max_axis = axis;
plot([min_max_axis(1), min_max_axis(2)],[y_center, y_center],'c:');
plot([x_center, x_center],[min_max_axis(3), min_max_axis(4)],'c:');
plot(x_center,y_center,'x', "MarkerSize",15);


plot([-45,-25],[435,435],"b"); text(-20,435,'agent1');
plot([-45,-25],[405,405],"r-."); text(-20,405,'agent2');
plot([305,325],[435,435],"m--"); text(330,435,'agent3');
plot([305,325],[405,405],"k"); text(330,405,'agent4');