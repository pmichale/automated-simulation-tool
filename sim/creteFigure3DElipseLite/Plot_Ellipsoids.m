function h=Plot_Ellipsoids(ax,Ellipsoids)

%Input
%Ellipsoids: (N*9) array. each column represent: 
            %(:,1): radius of ellipsoids at direction 1
            %(:,2): radius of ellipsoids at direction 2
            %(:,3): radius of ellipsoids at direction 3
            %(:,4): x-cooridante of centroid
            %(:,5): y-coordinate of centroid
            %(:,6): z-coordinate of centroid
            %(:,7): Inclination angle 1
            %(:,8): Inclination angle 2
            %(:,9): Inclination angle 3
%Output
%A figure with ellipsoids is plotted

% figure;

[m , ~]=size(Ellipsoids);

N=20;

for i=1:1:m
    
r1=Ellipsoids(i,1);    r2=Ellipsoids(i,2);    r3=Ellipsoids(i,3); 
Cx=Ellipsoids(i,4);    Cy=Ellipsoids(i,5);    Cz=Ellipsoids(i,6); 
theta=Ellipsoids(i,7); gamma=Ellipsoids(i,8); phi=Ellipsoids(i,9); 

[xe, ye, ze] = ellipsoid(0, 0, 0, r1, r2, r3,N);

Dr=[cos(gamma)*cos(phi)-cos(theta)*sin(gamma)*sin(phi)  sin(gamma)*cos(phi)+cos(theta)*cos(gamma)*sin(phi) sin(theta)*sin(phi)  ...
 ; -cos(gamma)*sin(phi)-cos(theta)*sin(gamma)*cos(phi) -sin(gamma)*sin(phi)+cos(theta)*cos(gamma)*cos(phi) sin(theta)*cos(phi)  ...
 ;                  sin(theta)*sin(gamma)                         -sin(theta)*cos(gamma)                         cos(theta)     ];

for j=1:1:(N+1)
for k=1:1:(N+1)
    
V=Dr'*[xe(j,k) ; ye(j,k) ; ze(j,k)];

xe(j,k)=V(1);
ye(j,k)=V(2);
ze(j,k)=V(3);
    
end
end

xe=xe+Cx;
ye=ye+Cy;
ze=ze+Cz;

h=surface(ax,xe, ye, ze);

set(h,'EdgeColor','none','AmbientStrength',.5);

hold on

end

% daspect([1 1 1]);
% camlight left;
% lighting gouraud;
% hold off
% view(60,30)

end