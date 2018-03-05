function [D h c]=compute(J,U,th,thdot)
D=sym(zeros(3));
for i=1:3
    for k=1:3
        for j=max(i,k):3
            D(i,k)=D(i,k)+trace(U(:,:,j,k)*J(:,:,j)*transpose(U(:,:,j,i)));  
        end
        if i~=j
            D(k,i)=D(i,k); %summetrikos
        end
    end
end

h=sym([0 0 0]);
for i=1:3
    for k=1:3
        for m=1:3
            h1=sym(0);
            j=sort([i k m]);
            for j=j(1):3
                dU=diff(U(:,:,j,k),th(m)); 
                h1=h1+trace(dU*J(:,:,j)*transpose(U(:,:,j,i))); 
            end
            h(i)=h(i)+h1*thdot(k)*thdot(m);
            
            
        end
    end
end
h=h.';


g=sym([ 0 0 -9.81 0]); %dianusma varhthtas
m=sym([J(4,4,1) J(4,4,2) J(4,4,3)]); %dianusma mazas
rp=sym([J(:,4,1)/m(1) J(:,4,2)/m(2) J(:,4,3)/m(3)]);
c=sym([0; 0; 0]);

for i=1:3
    for j=i:3
	c(i)= c(i)-m(j)*g*U(:,:,i,j)*rp(:,j);
    end
end


end