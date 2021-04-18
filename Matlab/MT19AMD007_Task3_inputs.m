

function [x0,y0,P,no_agents,kv,WP,rho,dir,alpha,aa] =  MT19AMD007_Task3_inputs()

ini_values = [220 50 60 430 30 190 150 280];  % [x1 y1 x2 y2 ...... xn yn]
x0= [ini_values(1) ini_values(3) ini_values(5) ini_values(7)];
y0= [ini_values(2) ini_values(4) ini_values(6) ini_values(8)];
P=[x0;y0];


no_agents = 4; 
kv = 1;

WP = [200;300];
 
rho = 0.5;

dir = 1; 
x=(pi/2)-(pi/no_agents);
a=1;
b=1-rho;
c= sqrt(a^2 + b^2 - (2*a*b*cos(2*pi/no_agents))); 
temp = asin(b*sin(2*pi/no_agents)/c); 
th=x-temp;
alpha = dir*((pi/no_agents) +(th)); 
%dynamics matrix
aa = [cos(alpha) sin(alpha);-sin(alpha) cos(alpha)];




