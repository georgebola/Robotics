function [A01,A02,A03] = DH_parameters(th)

pi=sym('pi');
r=0.020;d1=0.6604;a2=0.4318;d2=0.14909;a3=-0.02032;d4=0.43307;

A01 = trotz(th(1))*transl(0,0,d1+r)*transl(0,0,0)*trotx(-pi/2);
A12 = trotz(th(2))*transl(0,0,d2+r)*transl(a2,0,0)*trotx(0); 
A23 = trotz(th(3))*transl(0,0,0)*transl(a3,0,0)*trotx(pi/2);
A23=[1 0 0 d4;0 1 0 0;0 0 1 0;0 0 0 1]*A23;

A02=simplify(vpa(A01*A12));
A03=simplify(vpa(A01*A12*A23));

end
