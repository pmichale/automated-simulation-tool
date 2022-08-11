% Funkce pro pripojeni k mySQL databazi
% Vstupem jsou: 'adresa:port/databaze' serveru,'uzivatelske jmeno', 'heslo'
% napr.: 'localhost:5432/postgres', 'user', 'pass'
% Dependence: postgresql-42.2.14.jar

function con = postgresqlcon(adresa, user, pass)
% Matlab je naveden k driveru
celacesta = fullfile(pwd,'postgresql-42.2.14.jar');
javaaddpath(celacesta);
driver = org.postgresql.Driver;
predadr = 'jdbc:postgresql://';
SSLoff = '?autoReconnect=true&useSSL=false';
adresasql = strcat(predadr,adresa,SSLoff);
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