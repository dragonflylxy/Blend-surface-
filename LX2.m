
        
ffx=40;
ffy=10;
ffz=20;
dph=200;
dz=dph/ffz;
tests=1;
savrfls=0;
hold on;
view(-0, 90);


if ~tests
M2 = dlmread('plo.txt','"');
num=16;
    for i=1:4,
        for j=1:4,  
            pprrx(i,j)=M2(num,2);
            pprry(i,j)=M2(num,4);
            pprrz(i,j)=M2(num,6);
            num=num-1;
        end
    end
end

for i=0:ffy,
     sgy=-0.2*(1-i/ffy)+1.8*i/ffy;
     dy1=1-sgy;
     dy2=sgy;
     dy=[dy1;dy2;];
     by = 1;
     for yu=1:2,
         by=conv2(by,dy);
     end
     for j=0:ffx,
        sgx=-0.08*(1-j/ffx)+1.12*j/ffx;
        dx1=1-sgx;
        dx2=sgx;
        dx=[dx1,dx2;];
        bx=1;
        for xu=1:5,
            bx=conv2(bx,dx);
        end
        dyx=conv2(by,bx);            
        tmpy=0;
        tmpz=0;
        tmpx=0;
        for dc=1:3,
            for ce=1:6,
                tmpx=tmpx+dyx(dc,ce)*p1(dc,ce,1);
                tmpy=tmpy+dyx(dc,ce)*p1(dc,ce,2);
                tmpz=tmpz+dyx(dc,ce)*p1(dc,ce,3);
            end
        end
        
        tpy=tmpy;
        tpx=tmpx;
        f=0;
        tx=0;
        vv(i+1,j+1,1)=tmpx;
        vv(i+1,j+1,2)=tmpy;
        vv(i+1,j+1,3)=tmpz;

%%      
if tests
        for k=1:ffz,
            f=0;
            tpz=tmpz-(dz*k-dph/2);
            for ii=1:hh,
                f=f+zs(ii)*tpx^ind(ii,1)*tpy^ind(ii,2)*tpz^ind(ii,3);
            end
            v(i+1,j+1,k)=f;
            X(i+1,j+1,k)=tpx;
            Y(i+1,j+1,k)=tpy;
            Z(i+1,j+1,k)=tpz;
        end
end
%%
if ~tests
        f1=zeros(1,dgr+1);f1(dgr+1)=-1;
        for ii=1:hh,
            ik=dgr+1-ind(ii,3);
            f1(ik)=f1(ik)+zs(ii)*tpy^ind(ii,2)*tpx^ind(ii,1);
        end
        ZZ=roots(f1);
        zt=zeros(1,dgr);
        for jj=1:dgr,
            if (ZZ(jj)>tmpz-130)&(ZZ(jj)<tmpz+70)&(isreal(ZZ(jj)))
                zt(jj)=ZZ(jj);
            end
        end
        vv2(i+1,j+1)=max(zt);
end
%%
    end
end
% 
     hold on;
     
%      mesh(vv(:,:,1),vv(:,:,2),vv(:,:,3)); 
     
if tests
    p = patch(isosurface(X,Y,Z,v,1));
    set(p,'FaceColor','red','EdgeColor','none');
    camlight 
    lighting gouraud
end

%  mesh(p1(:,:,1),p1(:,:,2),p1(:,:,3));
%  mesh(p2(:,:,1),p2(:,:,2),p2(:,:,3));
%  plot3(p3(:,1),p3(:,2),p3(:,3),'-o');
plot3(p2(:,1),p2(:,2),p2(:,3),'-o');
plot3(p1(:,:,1),p1(:,:,2),p1(:,:,3),'-o');
%   mesh(pprrx(1:4,1:4),pprry(1:4,1:4),pprrz(1:4,1:4));

if ~tests
       mesh(vv(:,:,1),vv(:,:,2),vv2(:,:));   
end
   



if savrfls
% % 
 fid = fopen('\for4.txt','w');
 % fprintf(fid,' NoEcho\n');
fprintf(fid,'! SrfPtGrid\n');
fprintf(fid,'d\n');
fprintf(fid,'3\n');
fprintf(fid,'%d\n',i+1);
fprintf(fid,'d\n');
fprintf(fid,'3\n');
fprintf(fid,'%d\n',j+1);

for ax=1:i+1,
    for ay=1:j+1;
       fprintf(fid,'%f,%f,%f \n',vv(ax,ay,1),vv(ax,ay,2),vv2(ax,ay));    
    end
end

fclose(fid);
end

%   clear;
%  beep;
