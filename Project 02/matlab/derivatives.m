function U = derivatives(th,A)

for i=1:3
    for j=1:i
        U(:,:,i,j)=simplify(diff(A(:,:,i),th(j)));  
        if i~=j
            U(:,:,j,i)=U(:,:,i,j); %summetrikos

        end
    end
end


end



