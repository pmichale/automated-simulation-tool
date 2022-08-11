% Alternativni funkce pro pripojeni k MS SQL databazi
% Vstupem jsou: 'adresa:port' serveru,'uzivatelske jmeno', 'heslo'
% napr.: localhost:1433, test, root, alpine
% Dependence: mssql-jdbc-8.2.2.jre8.jar
% Petr Michalek

function con = MSSQLconALT(adresa, user, pass)
% Matlab je naveden k driveru
celacesta = fullfile(pwd,'mssql-jdbc-8.2.2.jre8.jar');
javaaddpath(celacesta);
driver = com.microsoft.sqlserver.jdbc.SQLServerDriver;
predadr = 'jdbc:sqlserver://';
adresasql = strcat(predadr,adresa);
% Overeni kompatibility driveru s adresou
okAdresa = driver.acceptsURL(adresasql);
if okAdresa == 1
% Nastaveni prihlasovacich udaju pro server
udaje = java.util.Properties;
udaje.put('user', user);
udaje.put('password', pass);
% Pripojeni popr chyba
con = driver.connect(adresasql,udaje);
assignin('base', 'con', con);
else
   disp('Nespravna Adresa') 
end
end