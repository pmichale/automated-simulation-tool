clc, clear
close all


%% create the data for simulation
n=30;
model = 'pend_viscous_p1p2_M2019b';
load_system(model)
p1=1; %1
p2=200; %200
phi0=4; %5
Simulink.BlockDiagram.buildRapidAcceleratorTarget(model);
in(1:n^3) = Simulink.SimulationInput(model);
p1 = linspace(0.2,4,n);
p2 = linspace(150,250,n);
phi0 = linspace(3.5,6.5,n);
id=0;
for i = n:-1:1
    for j = n:-1:1
        for k = n:-1:1
            id=id+1;
            in(id)=in(id).setModelParameter('Solver','ode23tb');
            in(id)=in(id).setVariable('p1',p1(i));
            in(id)=in(id).setVariable('p2',p2(j));
            in(id)=in(id).setVariable('phi0',phi0(k));
        end
    end
end

%% simulation
tic
out = parsim(in,    'ShowSimulationManager', 'off',... %1:14
                    'ShowProgress', 'on',... %on +3%
                    'UseFastRestart', 'off',...%off +78%
                    'RunInBackground', 'on',... %off +101%
                    'TransferBaseWorkspaceVariables','off'); %on +25%
wait(out) %206s
toc
%% output
for i=1:n^3
    [IDX, SIMout] = fetchNext(out);
    SIMOUT{i}=SIMout;
end

%% create reference signal
% m=round((n^3)/2);
% timeVector=SIMOUT{m}.tout;
% yVector=SIMOUT{m}.yout;
load timeVector
load yVector
%% MSE

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

p=scatter3(x_p1,y_p2,z_phi0,'.','CData',MSE)
xlabel('p1')
ylabel('p2')
zlabel('phi0')

