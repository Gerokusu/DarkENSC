%Initialisation de l'encodage
:- encoding(utf8).

% Affiche l'inventaire
inventaire :-
    objet(_, inventaire),
    writel_bold('[INVENTAIRE]', white),
    findall(X, objet(X, inventaire), L),
    writelp(L),
    !.

inventaire :-
    writel('Vous avez les poches bien vides.'),
    nl,
    !.
