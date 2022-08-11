% Funkce pro provedeni SQL prikazu dle jeho typu
% Petr Michalek
%% Argumentem je SQL prikaz
% priklad uziti:
% zobrazime obsah tabulky "student"
% sqlukaz('SELECT * FROM student;')
% zobrazime obsah tabulky "student" ktery odpovida podmince
% sqlukaz('SELECT * FROM student WHERE student_id > 2;')
%%
function sqlexecute(sqlprikaz)
sel = 'select';
sho = 'show';
if contains(lower(sqlprikaz), sel) == 1 || contains(lower(sqlprikaz), sho) == 1
    sqlfetch(sqlprikaz);
else
    sqledit(sqlprikaz);
end