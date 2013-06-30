 clear all;
 
% Coefficients of the bezier function

b11=xish(2,5);
% b22=xish(2,5);
b1=xish(2,5);
b2=xish(0,2);
b3=xish(0,5);

% read control points from file
M1 = dlmread('cv.txt','"');
num=18;

    for i=1:3,
        for j=1:6,  
            p1(i,j,1)=M1(num,2);
            p1(i,j,2)=M1(num,4);
            p1(i,j,3)=M1(num,6);        
            num=num-1;
        end
    end
      
      p1(2,1,1)=p1(2,1,1);
      p1(2,1,3)=p1(2,1,3);
      p1(2,2,3)=p1(2,2,3);
      p1(2,2,2)=p1(2,2,2)-2;
      p1(2,2,1)=p1(2,2,1);
      p1(3,2,1)=p1(3,2,1);
      p1(2,3,3)=p1(2,3,3);
%     
      p1(3,1,3)=p1(3,1,3)-2;
      p1(3,1,1)=p1(3,1,1)+2;
      p1(3,2,1)=p1(3,2,1);
      p1(3,2,3)=p1(3,2,3)-1;
      p1(3,3,3)=p1(3,3,3);
    
M2 = dlmread('cv1.txt','"');
num=3;

    for i=1:3,
            p2(i,1)=M2(num,2);
            p2(i,2)=M2(num,4);
            p2(i,3)=M2(num,6);        
            num=num-1;
    end     
    
    p2(2,3)= p2(2,3)+10;
    
    
M3 = dlmread('cv2.txt','"');
num=6;

    for i=1:6,
            p3(i,1)=M3(num,2);
            p3(i,2)=M3(num,4);
            p3(i,3)=M3(num,6);        
            num=num-1;
    end    
    
   
    for i=1:3,
        for j=1:6,
            p1x(i,j)=p1(i,j,1)*b11(i,j);
            p1y(i,j)=p1(i,j,2)*b11(i,j);
            p1z(i,j)=p1(i,j,3)*b11(i,j);
        end
    end
    for i=1:3,
            p2x(i)=p2(i,1)*b2(i);
            p2y(i)=p2(i,2)*b2(i);
            p2z(i)=p2(i,3)*b2(i);
    end
    for i=1:6,
            p3x(i)=p3(i,1)*b3(i);
            p3y(i)=p3(i,2)*b3(i);
            p3z(i)=p3(i,3)*b3(i);
    end
   


% 
% the degree of implicit surface
dgr=9;
% all permutation of the xyz
ind=ruuu4(dgr);
[hh,aa]=size(ind);
hh = hh;

bb1=1;
for i=1:dgr,
    bb1=conv2(bb1,b1);
end
[h1,v1]=size(bb1);
fggg1=zeros(hh,h1,v1);


bb2=1;
for i=1:dgr,
    bb2=conv2(bb2,b2);
end
[h2,v2]=size(bb2);
fggg2=zeros(hh,h2,v2);


bb3=1;
for i=1:dgr,
    bb3=conv2(bb3,b3);
end
[h3,v3]=size(bb3);
fggg3=zeros(hh,h3,v3);

tic

for i=1:hh,
    tmp1=1;
    tmp2=1;
    tmp3=1;
    for j=1:ind(i,1),
        tmp1=conv2(tmp1,p1x);
        tmp2=conv2(tmp2,p2x);
        tmp3=conv2(tmp3,p3x);
    end
    for j=1:ind(i,2),
        tmp1=conv2(tmp1,p1y);
        tmp2=conv2(tmp2,p2y);
        tmp3=conv2(tmp3,p3y);
    end
    for j=1:ind(i,3),
        tmp1=conv2(tmp1,p1z);
        tmp2=conv2(tmp2,p2z);
        tmp3=conv2(tmp3,p3z);
    end
    for j=1:ind(i,4),
        tmp1=conv2(tmp1,b1);
        tmp2=conv2(tmp2,b2);
        tmp3=conv2(tmp3,b3);
    end
    fggg1(i,:,:)=tmp1(:,:);
    fggg2(i,:,:)=tmp2(:,:);
    fggg3(i,:,:)=tmp3(:,:);
end
% 
toc
sn=0;

% load the constrains definition array
% the size of numa1 is h1 X v1
load('NUMA1.mat');

% add the selected equation 
% the constrains for the surface cv.txt
for i=1:h1,
    for j=1:v1,
        if numa1(i,j)==1
            sn=sn+1;
            for k=1:hh,
                fcg1(sn,k)=fggg1(k,i,j)/bb1(i,j);
            end
            bg1(sn)=1;
        end
    end
end


% and the begin / end part of the curve % cv1.txt
for i=1:1,
    for j=v2-2:v2-1,
            sn=sn+1;
            for k=1:hh,
                fcg1(sn,k)=fggg2(k,i,j)/bb2(i,j);
            end
            bg1(sn)=1;
    end
end
for i=1:1,
    for j=2:3,
            sn=sn+1;
            for k=1:hh,
                fcg1(sn,k)=fggg2(k,i,j)/bb2(i,j);
            end
            bg1(sn)=1;
    end
end

% and the whole curve for cv2.txt
for i=1:1,
    for j=1:v3,
        sn=sn+1;
        for k=1:hh,
            fcg1(sn,k)=fggg3(k,i,j)/bb3(i,j);
        end
        bg1(sn)=1;
    end
end



    % solve
   fcz=[fcg1;];     
   bf=[bg1';];
   
    zs=fcz\bf;

%    LX2;
% 
