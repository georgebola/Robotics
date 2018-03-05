clc;
clear all;

th1 = sym('th1');
th2 = sym('th2');
th3 = sym('th3');
th4 = sym('th4');
th5 = sym('th5');
th6 = sym('th6');

a2=43.18;
d2=14.909;
a3=-2.032;
d4=43.307;
d6=5.625;

th1 = sym('th1');
th2 = sym('th2');
th3 = sym('th3');

A01 = trotz(th1)*transl(0,0,0)*transl(0,0,0)*trotx(-pi/2);
A12 = trotz(th2)*transl(0,0,d2)*transl(a2,0,0)*trotx(0);
A23 = trotz(th3)*transl(a3,0,0)*trotx(pi/2);
 
A03=A01*A12*A23;
 
A34 = trotz(th4)*transl(0,0,d4)*trotx(-pi/2);
A45 = trotz(th5)*trotx(pi/2);
A56 = trotz(th6)*transl(0,0,d6)*trotx(0);
A46=A34*A45*A56;

A06=A03*A46;

N=15;
m=1;
for i= 1:N+1
    l=1;
    for j= 1:1:N+1
        for k=1:4:N+1

Position=subs(A03, {th1, th2, th3},{1.7778*pi*(i-1)/N  -1.5*pi*(j-1)/N+pi/4    +1.5*pi*(k-1)/N-pi/4});


       P(m,:)=double(Position(:,4));
       m=m+1;
        end
            
    end
     
    
end

Px=P(:,1);
Py=P(:,2);
Pz=P(:,3);
figure

%plot3(Px,Py,Pz,'.','MarkerSize',10)
grid on
title('Puma 560 Workspace')

xlabel('x(in cm)') % x-axis label
ylabel('y(in cm) ') % y-axis label
zlabel('z(in cm) ') % y-axis label
axis square

k = boundary(Px,Py,Pz);
hold on
trisurf(k,Px,Py,Pz,'Facecolor','cyan','FaceAlpha',0.5)
