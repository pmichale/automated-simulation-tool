clc
clear all

load SIMOUT_n25_2020_01_07_v0

load timeVector
load yVector
%% MSE
n=25;
p1 = linspace(0.2,4,n);
p2 = linspace(150,250,n);
phi0 = linspace(3.5,6.5,n);
cla
for i=1:n^3
    yNew=interp1(SIMOUT{i}.tout,SIMOUT{i}.yout,timeVector,'linear');
    e=abs(yVector-yNew);
    MSE(i)=mean(e.^2);
end
MSE(MSE>0.04)=NaN;
id=1;
hold on
grid on
for i = n:-1:1
    for j = n:-1:1
        for k = n:-1:1
            x_p1(id)=p1(i);
            y_p2(id)=p2(j);
            z_phi0(id)=phi0(k);
%             if ~isnan(MSE(id))
%                 text(x_p1(id),y_p2(id),z_phi0(id),['\leftarrow',num2str(round(MSE(id),2))])
%             end
            id=id+1;
        end
    end
end
% [MSEcolor(id) MSEcolor(id) MSEcolor(id)]
% plot
%%

f=figure('Position',[1 1 800 600],'Color','w');
ax=axes(f);
cla
hold off
MSE_color=[MSE/0.4;MSE/0.4;MSE/0.4]';
p=scatter3(ax,x_p1,y_p2,z_phi0,'.','CData',MSE_color)
p.CData=p.CData/max(p.CData);
hold on
xlabel('p1')
ylabel('p2')
zlabel('phi0')
%%
% elipsoid
a=1.5;
b=24;
c=0.5;
% Ellipsoids=[a b c 1.7 200 4.9 0 0 0];
Ellipsoids=[a b c 1.7 200 4.9 -0.018 0 0];
h=Plot_Ellipsoids(ax,Ellipsoids)
h.FaceAlpha=0.3
view(-94,9)
% view(180,90)


xc=1; yc=1; zc=1;    % coordinated of the center
L=10;                 % cube size (length of an edge)
alpha=0.1;           % transparency (max=1=opaque)

X = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
Y = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
Z = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];
A=(max(h.XData(:))-min(h.XData(:)));
X=X*A;
X=X+min(h.XData(:));
B=(max(h.YData(:))-min(h.YData(:)))
Y=Y*B;
Y=Y+min(h.YData(:));
C=(max(h.ZData(:))-min(h.ZData(:)));
Z=Z*C;
Z=Z+min(h.ZData(:));

Cb='blue';                  % unicolor

% X = L*(X-0.5) + xc;
% Y = L*(Y-0.5) + yc;
% Z = L*(Z-0.5) + zc; 

fill3(X,Y,Z,Cb,'FaceAlpha',alpha);    % draw cube

Objem_1=(4/3)*a*b*c*pi
Objem_2=A*B*C
Pomer=Objem_2/Objem_1

%% export_fig settings
addpath('export_fig')
name1 = 'Elipsoid_1';

pth_cur = [pwd '\'];
export_fig(f,[pth_cur name1],'-pdf','-q101')

