close all
clear all
clc

nx=10;
ny=nx;
dt=1;
nt=2000;
c=1.6563e-4;
x=linspace(0,1,nx);
y=linspace(0,1,ny);
z=fliplr(y);
dx=(x(2)-x(1));
dy=dx;
k=(c*dt)/(dx^2);
u=ones([nx,ny]);
c=0;
u(1,2:nx)=600;
u(1:ny-1,1)=400;
u(2:ny,nx)=800;
u(ny,1:nx-1)=900;
t1=u;r1=u;
k1=k/2;k2=k1;
a=zeros(nx*ny, nx*ny);
b=zeros(nx*ny, 1);
for i = 2:nx-1
    for j = 2:ny-1
        a(j+ny*(i-1),j+ny*(i-1))=1+2*k1+2*k2;
        a(j+ny*(i-1),j+ny*(i-1)-1)=-k1;
        a(j+ny*(i-1),j+ny*(i-1)+1)=-k1;
        a(j+ny*(i-1),j+ny*(i-2))=-k2;
        a(j+ny*(i-1),j+ny*(i))=-k2;
        b(j+ny*(i-1)) =u(i,j);
    end
end
%L/R boundary
for j=2:ny
    a(j*ny, j*ny)=1;
    b(j*ny)=800;
    a(nx*(j-2)+1,nx*(j-2)+1)=1;
    b(nx*(j-2)+1)=400;
end
%T/B boundary
for r=2:ny
    a(r,r)=1;
    a((ny*ny)-r+1,(ny*ny)-r+1)=1;
    b(r)=600;
    b((ny*ny)-r+1)=900;
end