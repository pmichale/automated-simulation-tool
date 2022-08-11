% Skript pro pripojeni k mySQL databazi
% Vstupem jsou: 'adresa:port' serveru,'uzivatelske jmeno', 'heslo'
% napr.: localhost:3306/test, root, alpine
% Dependence: mysql-connector-java-5.1.48.jar
% Petr Michalek

function con = mysql57con(adresa, user, pass)
import java.sql.Connection;  
% Matlab je naveden k driveru
celacesta = fullfile(pwd,'mysql-connector-java-5.1.48.jar');
javaaddpath(celacesta);
driver = com.mysql.jdbc.Driver;
predadr = 'jdbc:mysql://';
SSLoff = '?autoReconnect=true&useSSL=false';
adresasql = strcat(predadr,adresa,SSLoff);
% Overeni kompatibility driveru s adresou
okAdresa = driver.acceptsURL(adresasql);
if okAdresa == 1
% Nastaveni prihlasovacich udaju pro server
udaje = java.util.Properties;
udaje.put('user', user); udaje.put('password', pass);
% Pripojeni popr chyba
con = driver.connect(adresasql,udaje);
assignin('base', 'con', con);
else
   disp('Nespravna Adresa') 
end
end