function [c0,d0]=ruuu(ddr)
dr=ddr;
ind=[1,0,0,0;
     0,1,0,0;
     0,0,1,0;
     0,0,0,1;];

b0=zeros(1,dr);
b0=b0+1;
a(1,:)=b0;
aa=1;
while b0(1)~=4,
    b0(dr)=b0(dr)+1;
    aa=aa+1;
    for i=0:dr-2,
        di=dr-i;
        if b0(di)==5
           b0(di-1)=b0(di-1)+1;
           for ii=di:dr,
               b0(ii)=b0(di-1);
           end
        end
    end
    a(aa,:)=b0;
end

chu=zeros(1,4);
for i1=1:aa,
    cc=chu;
    for i2=1:dr,
        tp=ind(a(i1,i2),:);
        cc=cc+tp;
    end
    c0(i1,:)=cc;
    cc=cc+1;
    d0(cc(1),cc(2),cc(3),cc(4))=i1;
end

        
