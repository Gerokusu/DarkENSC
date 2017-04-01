%Fonctions utilitaires

%Écrit une nouvelle ligne.
writel(Text) :-
    nl,
    write(Text),
    nl,
    !.

%Écrit un nouveau paragraphe.
writep(Title, Content) :-
    nl,
    write_bold(Title, white),
    writel(Content),
    !.

%Écrit une nouvelle liste.
writelp([T|Q]) :-
    nl,
    write('    - '),
    write(T),
    writelp(Q),
    !.

%Écrit une nouvelle liste (fin de la récursivité).
writelp(_) :-
    nl,
    nl,
    !.

%Écrit un nouveau texte en gras.
write_bold(Text, Color) :-
    ansi_format([bold, fg(Color)], Text, []),
    !.

%Écrit une nouvelle ligne en gras.
writel_bold(Text, Color) :-
    nl,
    write_bold(Text, Color),
    nl,
    !.
