%% 1) COMPUTES A03

clc;clear all;

th1 = sym('th1');th2 = sym('th2');th3 = sym('th3');pi=sym('pi');
th1dot = sym('th1dot');th2dot = sym('th2dot');th3dot = sym('th3dot');
th1dotdot = sym('th1dotdot');th2dotdot = sym('th2dotdot');th3dotdot = sym('th3dotdot');
y=sym('y');z=sym('z');x=sym('x');r=sym('r');d2=sym('l');m=sym('m');
th=[th1 th2 th3];
thdot=[th1dot th2dot th3dot];
thdotdot=[th1dotdot th2dotdot th3dotdot];

r=0.020;d1=0.6604;a2=0.4318;
d2=0.14909;a3=-0.02032;d4=0.43307;


[A01,A02,A03]=DH_parameters(th) %% aferesh A apo dw
A=[A01];
A(:,:,2)=A02;
A(:,:,3)=A03;


%% 2) COMPUTES INERTIAL MATRIXES J4x4

J(:,:,1) = inertial(-(r.^2-x.^2).^(1/2),(r.^2-x.^2).^(1/2),-r,r,r,r+d1) ;
J2a = vpa(indegral1(-r-d2,-r,-a2-(r.^2-y.^2).^(1/2),-a2+(r.^2-y.^2).^(1/2),-r,r));
J2b = vpa(indegral1(-r,r,-a2-0.08,0,-(r.^2-z.^2).^(1/2),(r.^2-z.^2).^(1/2)) );
J(:,:,2)=J2a+J2b;
J(:,:,3) = indegral2(-d4,0,-(r.^2-y.^2).^(1/2),(r.^2-y.^2).^(1/2),-r,r) ;
J=vpa(J,5)

%% 3) COMPUTES IN SYMBOLIC FORM THE DYNAMICS 

U=derivatives(th,A); 

[D C G]=compute(J,U,th,thdot);

torque=D*thdotdot.'+G+C;
torque=vpa(torque,4)

%% 4) PLOT TORQUES

t=0:0.1:12; %dianusma xronou

A1=80*pi/180;A2=40*pi/180;A3=40*pi/180; %metatroph se rad
T1=6;T2=3;T3=2;

[tdesired thdesired thdotdesired thdotdotdesired] = er4(th,thdot,thdotdot,torque,t);

figure , plot(t, tdesired(1,:), '-b')
hold on, plot(t, tdesired(2,:), '-r')
hold on, plot(t, tdesired(3,:), '-c')
legend('t1', 't2', 't3')
title('t')

%% 4) DISPLAY MAX TORQUES

tsorted1=sort(tdesired(1,:),'descend');
tsorted2=sort(tdesired(2,:),'ascend');
tsorted3=sort(tdesired(3,:),'descend');
max_torque=[abs(tsorted1(1)) abs(tsorted2(1)) abs(tsorted3(1))]








    




%%
t=0:0.1:12; %dianusma xronou

q1=double([ -160*pi/180]);
q2=double([ -225*pi/180]);
q3=double([ -45*pi/180]);


[tode,q]= ode45(@(t,z) F(t,z,D,C,G,th,thdot,thdotdot,thdesired,thdotdesired,thdotdotdesired), t,[q1 0 q2 0 q3 0]);
plot(t,q)

%%
t=0:0.1:12; %dianusma xronou

q1=double([ -160*pi/180]);
q2=double([ -225*pi/180]);
q3=double([ -45*pi/180]);

q1dot=double(thdotdesired(1,1));
q2dot=double(thdotdesired(2,1));
q3dot=double(thdotdesired(3,1));

[t,sfalma1]=ode45('F1',t,[q1,0]);
[t,sfalma2]=ode45('F1',t,[q2,0]);
[t,sfalma3]=ode45('F1',t,[q3,0]);


y1=thdesired(1,:)'+sfalma1(:,1); %y = estimated
y2=thdesired(2,:)'+sfalma2(:,1);
y3=thdesired(3,:)'+sfalma3(:,1);
%dy1=thdotdesired(1,:)'-sfalma1(:,2);
%dy2=thdotdesired(2,:)'-sfalma2(:,2);
%dy3=thdotdesired(3,:)'-sfalma3(:,2);
qdot=[  sfalma1(:,2) sfalma2(:,2) sfalma3(:,2)]';
q=[  sfalma1(:,1) sfalma2(:,1) sfalma3(:,1)]';

qdotdesired=double(thdotdesired);
qdotdotdesired=double(thdotdotdesired);
qdesired=double(thdesired);

n=1;
for t=0:0.1:12
Dfound=subs(D,{th1 th2,th3},{sfalma1(n,1) sfalma2(n,1) sfalma3(n,1)});
Cfound=subs(C,{th1 th2,th3,th1dot,th2dot,th3dot},{sfalma1(n,1) sfalma2(n,1) sfalma3(n,1)...
    sfalma1(n,2) sfalma2(n,2) sfalma2(n,2)}); %pinakas C
Gfound=subs(G,{th1, th2, th3},{sfalma1(n,1) sfalma2(n,1) sfalma3(n,1)}); %pinakas G


Dinv=inv(Dfound); %pinakas D^(-1)

torque1(:,n)=Dinv*(qdotdotdesired(:,n)+(qdotdesired(:,n)-qdot(:,n))+(qdesired(:,n)-q(:,n)))+Gfound+Cfound;

n=n+1;
end

subplot(3,1,1),plot(t,y1 ),title('th1');
hold on, plot(t,thdesired(1,:)');

subplot(3,1,2),plot(t,y2),title('th2');
hold on, plot(t,thdesired(2,:)');

subplot(3,1,3),plot(t,y3),title('th3');
hold on, plot(t,thdesired(3,:)');

%subplot(3,2,2),plot(t,dy1 ),title('thdot1');
%hold on, plot(t,thdotdesired(1,:)');

%subplot(3,2,4),plot(t,dy2),title('thdot2');
%hold on, plot(t,thdotdesired(2,:)');

%subplot(3,2,6),plot(t,dy3),title('thdot3');
%hold on, plot(t,thdotdesired(3,:)');
t=0:0.1:12; %dianusma xronou
plot(t,torque1);

%%
t=0:0.1:12; %dianusma xronou


plot(t,torque1)
%%
q1=double([ -160*pi/180]);
q2=double([ -225*pi/180]);
q3=double([ -45*pi/180]);

u=0;
T_s=0.1;
z0=[q1 0 q2  0  q3  0]';
t_in=0;
t_fin=12;
cnt=1;
z=z0;
diaf=z0;
n=1;



for t=t_in:T_s:t_fin-T_s
    cnt=cnt+1; %counter increment
    [tode,z]= ode45(@(t,z) F(t,z,D,C,G,th,thdot,thdotdot,thdesired,thdotdesired,thdotdotdesired), [t t+T_s],z);

    szx_ode=size(z);
    z=z(szx_ode(1),:)';
    diaf(:,cnt)=z;
end
t=t_in:T_s:t_fin;

plot(t,diaf)
%%
qdotdesired=double(thdotdesired);
qdotdotdesired=double(thdotdotdesired);
qdesired=double(thdesired);

y1=qdesired(1,:)+diaf(1,:); %y = estimated
y2=qdesired(2,:)+diaf(3,:);
y3=qdesired(3,:)+diaf(5,:);

tsda=0:0.1:12; %dianusma xronou


subplot(3,1,1),plot(tsda,qdesired(1,:))',title('th1');

subplot(3,1,2),plot(tsda,qdesired(2,:))',title('th2');

subplot(3,1,3),plot(tsda,qdesired(3,:))',title('th3');


subplot(3,1,1),plot(t,y1 ),title('th1');
hold on, plot(t,thdesired(1,:)');

subplot(3,1,2),plot(t,y2),title('th2');
hold on, plot(t,thdesired(2,:)');

subplot(3,1,3),plot(t,y3),title('th3');
hold on, plot(t,qdesired(3,:)');

%subplot(3,2,2),plot(t,dy1 ),title('thdot1');
%hold on, plot(t,thdotdesired(1,:)');

%subplot(3,2,4),plot(t,dy2),title('thdot2');
%hold on, plot(t,thdotdesired(2,:)');

%subplot(3,2,6),plot(t,dy3),title('thdot3');
%hold on, plot(t,thdotdesired(3,:)');
