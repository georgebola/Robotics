clc;
clear all;

th1 = sym('th1');
th2 = sym('th2');
th3 = sym('th3');
th4 = sym('th4');
th5 = sym('th5');
th6 = sym('th6');
pi=sym('pi');

a2=43.18;
d2=14.909;
a3=-2.032;
d4=43.307;
d6=5.625;

A01 = trotz(th1)*transl(0,0,0)*transl(0,0,0)*trotx(-pi/2);
A12swsto = trotz(th2)*transl(0,0,d2)*transl(a2,0,0)*trotx(0)
A12 = trotz(th2)*transl(a2,0,0)*transl(0,0,d2)*trotx(0)

A23 = trotz(th3)*transl(a3,0,0)*transl(0,0,0)*trotx(pi/2);

A03=A01*A12*A23;

A34 = trotz(th4)*transl(0,0,0)*transl(0,0,d4)*trotx(-pi/2);
A45 = trotz(th5)*transl(0,0,0)*transl(0,0,0)*trotx(pi/2);
A56 = trotz(th6)*transl(0,0,0)*transl(0,0,d6)*trotx(0);

A46=A34*A45*A56;

A06=A03*A46;
