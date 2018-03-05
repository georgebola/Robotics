clc;
clear all;
th1 = sym('th1');
th2 = sym('th2');
th3 = sym('th3');

L(1) = Link([0 0       0      -pi/2]);
L(2) = Link([0 14.909  43.18   0]);
L(3) = Link([0 0       -2.032   pi/2]);

Puma560 = SerialLink(L);
Puma560.name = 'Puma 560';
%Puma560.plot([0 0 0]);

Puma560.fkine([th1 th2 th3]);

N=40;
m=1;
for i=1:N+1
    
    for j=1:1:N+1
      
        for k=1:1:N+1
        Position = Puma560.fkine([1.7778*pi*(i-1)/N  -1.5*pi*(j-1)/N+pi/4    +1.5*pi*(k-1)/N-pi/4]) %den pirazw +pi/2  %sunexizei pisw apthn arxh
       P(m,:)=double(Position.t);
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
trisurf(k,Px,Py,Pz,'Facecolor','cyan','FaceAlpha',0.5);


