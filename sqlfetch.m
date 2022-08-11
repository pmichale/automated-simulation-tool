% Funkce pro zobrazeni dat v SQL databazi
% 
% Petr Michalek
%% Argumentem je SQL prikaz
% priklad uziti:
% zobrazime obsah tabulky "student"
% sqlukaz('SELECT * FROM student;')
% zobrazime obsah tabulky "student" ktery odpovida podmince
% sqlukaz('SELECT * FROM student WHERE student_id > 2;')
%%
function data = sqlfetch(sqlprikaz)
% Bereme pripojeni z sqlpripoj
con = evalin('base','con');
%% ziskani datasetu ze serveru
prikaz = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
data = prikaz.executeQuery(sqlprikaz);

% vyber metadat z datasetu
meta = data.getMetaData();

% ziskani poctu sloupcu
pocetsloupcu = meta.getColumnCount();
%% ziskani poctu radku
% reset pocitadla
pocetradku = 0;
% dokud lze posunovat pointer pocitadlo radku bezi
while data.next()
    pocetradku = pocetradku+1;
end
data.beforeFirst();
%%    tvorba struktury
for i = 1:pocetsloupcu
    typsloupce = lower(char(meta.getColumnTypeName(i)));
    nazevsloupce = char(meta.getColumnName(i));
    % podminka dle typu sloupce
    switch char(typsloupce)
        case {'int', 'int4','tinyint', 'bigint', 'decimal', ...
                'float', 'float8', 'float16', ...
                'real', 'serial','double'}
            struktura.(nazevsloupce) = ones(pocetradku, 1);
        otherwise
            struktura.(nazevsloupce) = cell(pocetradku, 1);
    end
end
radek = 0;
%% prirazovani hodnot z datasetu strukture
% Inspirovano: Brian Schlining (2014), URL: https://bit.ly/2Zd6oZi, [10.3.2020]
while data.next()
    % pocitadlo radku
    radek = radek + 1;
    % cyklus pro vsechny radky
    for i = 1:pocetsloupcu
        %zjistime typ sloupce
        typsloupce = lower(char(meta.getColumnTypeName(i)));
        nazevsloupce = char(meta.getColumnName(i));
        switch typsloupce
            % cisla
            case {'int', 'int4', 'bigint','tinyint', 'decimal', ...
                'float', 'float8', 'float16', ...
                'real', 'serial','double'}
            if isempty(data.getObject(i))
                vystup = NaN;
            else
                vystup = double (data.getObject(i));
            end
            struktura.(nazevsloupce)(radek) = vystup;
            % datum
            case {'date'}
                if isempty(data.getDate(i))
                    vystup = NaN;
                else
                    vystup = char(data.getDate(i).getTime());
                end
                struktura.(nazevsloupce){radek} = vystup;
            timestamp
            case {'datetime'}
                if isempty(data.getTimestamp(i))
                    vystup = NaN;
                else
                    vystup = char(data.getTimestamp(i));
                end
                struktura.(nazevsloupce){radek} = vystup;
            % geometry    
            case {'geometry'}
                struktura.(nazevsloupce){radek} = data.getObject(i);
            % zbyva string
            otherwise
                if isempty(data.getString(i))
                    vystup = '';
                else
                    vystup = char(data.getString(i));
                end
                struktura.(nazevsloupce){radek} = vystup;
        end
    end
end
datastruct = struktura;
data = struct2table(struktura);
assignin('base', 'datastruct', datastruct);
assignin('base', 'datatab', data);
end