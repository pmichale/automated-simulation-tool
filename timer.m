% Skript pro opakovane hledani volnych uloh
% Dependence: sim_out.m
% Petr Michalek

t = timer;
assignin('base','t',t);
set(t,'executionMode','fixedRate');
set(t,'TasksToExecute',Inf);
% nastaveni periody casovace
set(t,'Period',15);

% MySQL
set(t,'TimerFcn','run("sim_out")');

% MS SQL server
% set(t,'TimerFcn','run("sim_out_ms")');

% PostgreSQL
% set(t,'TimerFcn','run("sim_out_postgres")');

start(t)


% Pro zastaveni vsech timeru pozijte:
% timery = timerfindall
% if ~isempty(timery)
%     delete(timery(:));
% end