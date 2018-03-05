function [J] = inertial(z1,z2,x1,x2,y1,y2)
y=sym('y');z=sym('z');x=sym('x');r=sym('r');d2=sym('l');m=sym('m');
th=sym('th');R=sym('R');
r=0.020; %aktina
d1=0.6604;d2=0.14909; %d se metra
p=10^4;

xyz=[x y z 1];
for i=1:4
    for j=i:4
        fun=(p*xyz(i)*xyz(j));
        mesa=int(fun,z,z1,z2);
        meseo=int(mesa,x,x1,x2);
        ekso=int(meseo,y,y1,y2);
        J(i,j)=ekso ;
        if i~=j
            J(j,i)=J(i,j); %summetrikos
        end
    end
end

end




