function zdot=F(t,z,D,C,G,th,thdot,thdotdot,qdesired,qdotdesired,qdotdotdesired)
th1 = sym('th1');th2 = sym('th2');th3 = sym('th3');pi=sym('pi');
th1dot = sym('th1dot');th2dot = sym('th2dot');th3dot = sym('th3dot');

zdot=zeros(6,1); % since output must be a column vector

zdot(1)=z(2);
zdot(3)=z(4);
zdot(5)=z(6);


Kp=100;Kd=25;
zdot(2)=-Kp*z(1)-Kd*zdot(1); 

zdot(4)=-Kp*z(3)-Kd*zdot(3); 

zdot(6)=-Kp*z(5)-Kd*zdot(5); 


%Dfound=subs(D,{th1 th2,th3},{z(1) z(3) z(5) });
%Cfound=subs(C,{th1 th2,th3,th1dot,th2dot,th3dot},{z(1) z(3) z(5) z(2) z(4) z(6)}); %pinakas C
%Gfound=subs(G,{th1, th2, th3},{z(1) z(3) z(5) }); %pinakas G
%Dinv=inv(Dfound); %pinakas D^(-1)

%torque1=Dinv*(qdotdotdesired(:,n)+(qdotdesired(:,n)-qdot(:,n))+(qdesired(:,n)-q(:,n)))+Gfound+Cfound;




end