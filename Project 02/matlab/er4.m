function [tdesired,thdesired,thdotdesired,thdotdotdesired] = er4(th,thdot,thdotdot,torque,t)

th1 = sym('th1');th2 = sym('th2');th3 = sym('th3');pi=sym('pi');
th1dot = sym('th1dot');th2dot = sym('th2dot');th3dot = sym('th3dot');
th1dotdot = sym('th1dotdot');th2dotdot = sym('th2dotdot');th3dotdot = sym('th3dotdot');
A1=80*pi/180;A2=40*pi/180;A3=40*pi/180;
T1=6;T2=3;T3=2;

thdesired=subs(th',{th1, th2, th3},{A1*sin(2*pi*t/T1) A2*sin(2*pi*t/T2) A2+A3*sin(2*pi*t/T3)});
thdotdesired=subs(thdot',{th1dot, th2dot, th3dot},{ (4*pi^2*cos((pi*t)/3))/27, ...
    (4*pi^2*cos((2*pi*t)/3))/27, (2*pi^2*cos(pi*t))/9});
thdotdotdesired=subs(thdotdot',{th1dotdot, th2dotdot, th3dotdot},...
{ -(4*pi^3*sin((pi*t)/3))/81, -(8*pi^3*sin((2*pi*t)/3))/81, -(2*pi^3*sin(pi*t))/9});

tdesired=vpa(subs(torque,{th1 th2,th3,th1dot,th2dot,th3dot,th1dotdot,th2dotdot,th3dotdot}...
,{thdesired(1,:) thdesired(2,:) thdesired(3,:) thdotdesired(1,:) thdotdesired(2,:)...
 thdotdesired(3,:) thdotdotdesired(1,:) thdotdotdesired(2,:) thdotdotdesired(3,:)}),3);



end


