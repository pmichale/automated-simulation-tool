% Skript pro automatizaci spousteni simulace
% Datove typy pro MS SQL Server
% Dependence: sqledit.m, sqlfetch.m, creteFigure3Delipse.m
% Petr Michálek


%% Ziskani parametru simulace, ktere nejsou zabrane z databaze
evalin('base', 'clearvars -except con');
sqlfetch('SELECT * FROM SIM_PRIMARY WHERE taken = 0;'); 
% Zkontrolujeme zda jsou nejake radky volne
 if size(datastruct.sim_id) == [0 1]
     disp('Nejsou k dispozici zadne ulohy')
 else
% Pokud jsou - cislo radku ktery zabereme
sim_id = datastruct.sim_id(1);
% Zabrani ulohy v databazi
taken = 'UPDATE SIM_PRIMARY SET taken = 1 WHERE sim_id =';
takenprikaz = strcat(taken,{' '},num2str(sim_id),';');
sqledit(char(takenprikaz));

%% ziskani promennych
n = (datastruct.n(1));
assignin('base','n',n);
p1low = (datastruct.p1low(1));
assignin('base','p1low',p1low);
p1up = (datastruct.p1up(1));
assignin('base','p1up',p1up);
p2low = (datastruct.p2low(1));
assignin('base','p2low',p2low);
p2up = (datastruct.p2up(1));
assignin('base','p2up',p2up);
phi0low = (datastruct.phi0low(1));
assignin('base','phi0low',phi0low);
phi0up = (datastruct.phi0up(1));
assignin('base','phi0up',phi0up);

p1 = linspace(0.2,4,n);
p2 = linspace(150,250,n);
phi0 = linspace(3.5,6.5,n);

assignin('base','p1',p1);
assignin('base','p2',p2);
assignin('base','phi0',phi0);


%% sim
creteFigure3Delipse
%% vytvoreni tabulky pro vysledky simulace
createtable = 'CREATE TABLE';
SIM_X_cols = '(row_id INT,MSE FLOAT,p1 FLOAT,p2 FLOAT,phi0 FLOAT,sim_id INT, PRIMARY KEY(row_id));';
SIM_X = strcat('SIM_',num2str(sim_id));
sql_SIM_X =strcat(createtable,{' '},SIM_X,SIM_X_cols);
sqledit(char(sql_SIM_X));

%% pripraveni SQL prikazu pro zapsani vysledku
SQL_insertinto = 'INSERT INTO';
SQL_update = 'UPDATE';
SQL_set = 'SET';
SQL_where = 'WHERE row_id =';
SQL_row_id = '(row_id) VALUES(';
SQL_MSEOUT = 'MSE =';
SQL_P1OUT = 'p1 =';
SQL_P2OUT = 'p2 =';
SQL_PHI0OUT = 'phi0 =';
%
%% Vybrani pouze vysledku s MSE splnujici kriteria zadana v simulaci
% A jejich zapis do nove tabulky simulace

%pocitadlo
j=1;
for i = 1:(n^3)
    if isnan(MSE(i))
    else
        %zapis row_id
        sqledit(char(strcat(SQL_insertinto,{' '},SIM_X,SQL_row_id,num2str(j),');')));
        %vyber MSE splnujicich podminku MSE není NaN
        OUTMSE(j)=MSE(i);
        %zapis
        sqledit(char(strcat(SQL_update,{' '},SIM_X,{' '},SQL_set,{' '},SQL_MSEOUT,{' '},num2str(OUTMSE(j)),{' '},SQL_where,{' '},num2str(j),';')));
        %indexy MSE splnujici podminku
        MSEIND(j)=i;
        %pocitadlo
        j=j+1;        
    end
end
%pocet vysledku splnujicich podminku
sizeMSE = size(MSEIND);
%% vyber a zapis parametru p1 do tabulky simulace
for p = 1:sizeMSE(2)
    % indexy
    IND = MSEIND(p);
    %vyber parametru
    OUTP1(p) = x_p1(IND);
    %zapis parametru
    sqledit(char(strcat(SQL_update,{' '},SIM_X,{' '},SQL_set,{' '},SQL_P1OUT,{' '},num2str(OUTP1(p)),{' '},SQL_where,{' '},num2str(p),';')));
end
%%  vyber a zapis parametru p2 do tabulky simulace
for q = 1:sizeMSE(2)
    % indexy
    IND = MSEIND(q);
    %vyber parametru
    OUTP2(q) = y_p2(IND);
    %zapis parametru
    sqledit(char(strcat(SQL_update,{' '},SIM_X,{' '},SQL_set,{' '},SQL_P2OUT,{' '},num2str(OUTP2(q)),{' '},SQL_where,{' '},num2str(q),';')));
end
%% zapis parametru phi0 do tabulky simulace
for r = 1:sizeMSE(2)
    %indexy
    IND = MSEIND(r);
    %vyber paramteru
    OUTPHI0(r) = z_phi0(IND);
    %zapis parametru
    sqledit(char(strcat(SQL_update,{' '},SIM_X,{' '},SQL_set,{' '},SQL_PHI0OUT,{' '},num2str(OUTPHI0(r)),{' '},SQL_where,{' '},num2str(r),';')));
end
%%

SQL_sim_id = 'sim_id =';
% zapis sim_id
sqledit(char(strcat(SQL_update,{' '},SIM_X,{' '},SQL_set,{' '},SQL_sim_id,{' '},num2str(sim_id),{' '},SQL_where,{' '},num2str(1),';')));
% zapis done do primarni tabulky
done = 'UPDATE SIM_PRIMARY SET done = 1 WHERE sim_id =';
sqledit(insertAfter(done,'id =',num2str(sim_id)));
% zapis nazvu sekundarni tabulky do primarni tabulky
update_results = 'UPDATE SIM_PRIMARY SET results =';
update_results_where = 'WHERE sim_id =';
stringSIM_X = strcat("'",SIM_X,"'");
sqledit(char(strcat(update_results,{' '},stringSIM_X,{' '},update_results_where,{' '},num2str(sim_id),';')));

disp('Data zapsana')
end