function c=xish(a,b)
c = zeros(a+1,b+1);
for i=0:a,
    for j=0:b,
        c(i+1,j+1)=nchoosek(a,i)*nchoosek(b,j);
    end
end
