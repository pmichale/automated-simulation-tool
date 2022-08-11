% Tvorba primarni tabulky pro simulace - PRIMARY TABLE INIT
% Datove typy pro MySQL
% Petr Michalek

str1='CREATE TABLE SIM_PRIMARY (sim_id INT, n INT, p1low FLOAT, p1up FLOAT,';
str2='p2low FLOAT, p2up FLOAT, phi0low FLOAT, phi0up FLOAT, PRIMARY KEY (sim_id));';
prikaz = strcat(str1,str2);
sqledit(prikaz);
sqledit('ALTER TABLE SIM_PRIMARY ADD taken TINYINT DEFAULT 0;');
sqledit('ALTER TABLE SIM_PRIMARY ADD done TINYINT DEFAULT 0;');
sqledit('ALTER TABLE SIM_PRIMARY ADD results VARCHAR(30);');

%priprava prikazu pro vlozeni testovacich hodnot
SQL_SIM_PRIMARY_insert = 'INSERT INTO SIM_PRIMARY(sim_id,n,p1low,p1up,p2low,p2up,phi0low,phi0up) VALUES (';

%testovaci hodnoty
%radek1
sqledit(char(strcat(SQL_SIM_PRIMARY_insert,'1,5,0.2,4,150,250,3.5,6.5',');')));
%radek2
sqledit(char(strcat(SQL_SIM_PRIMARY_insert,'2,10,0.2,4,150,250,3.5,6.5',');')));
%radek3
sqledit(char(strcat(SQL_SIM_PRIMARY_insert,'3,15,0.2,4,150,250,3.5,6.5',');')));