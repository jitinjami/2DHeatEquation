clear all
close all
clc

nx = 50; %No. of grid points
ny = nx;
nt = 2000; %No of time steps
c = 1.6563e-4; %Silver
x = linspace(0,1,nx);
y = x;
dx = 1/nx;
dy = 1/ny;
dt = 0.1;
k = (c*dt)/(dx^2);
u = 298*ones(nx,ny); %Intitializing temperature at all nodes
%Temperature at boundary nodes
u(:,ny)=800;
u(1,:)=600;
u(:,1)=400;
u(nx,:)=900;
uold = u;
[xx,yy] = meshgrid(x,y);
tic;
for p = 1:nt
    for i = 2:nx-1
        for j = 2:ny-1
            u(i,j) = k*(uold(i-1,j) + uold(i,j-1) + uold(i+1,j) + uold(i,j+1)) + (1-4*k)*uold(i,j);
        end
    end
    err = max(abs(uold(:)-u(:)));
    uold = u;
end
time = toc;
figure(1)
[C,h] = contourf(xx,yy,u);
colorbar;
colormap(jet);
clabel(C,h);
title(sprintf('2D Unsteady state heat conduction (Explicit Method) \n Time : %0.4f \n Computation Time: %0.4f \n CFL Number: %0.4f',dt*nt,time,k));
xlabel('xx');
ylabel('yy');