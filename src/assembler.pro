%Initialisation de l'encodage
:- encoding(utf8).

%Assembler deux objets de l'inventaire
assembler(Composant1, Composant2) :-
    position(Position),
    (
        recette(Composant1, Composant2, Objet);
        recette(Composant2, Composant1, Objet)
    ),
    objet(Composant1, inventaire),
    objet(Composant2, inventaire),
    assert(objet(Objet, Position)),
    retract(objet(Composant1, inventaire)),
    retract(objet(Composant2, inventaire)),
    nl,
    write('Vous avez assemblé l\'objet ['),
    write_bold(Composant1, 'blue'),
    write('] avec l\'objet ['),
    write_bold(Composant2, 'blue'),
    write('] pour fabriquer l\'objet ['),
    write_bold(Objet, 'blue'),
    write('] !'),
    nl,
    ramasser(Objet),
    !.

assembler(Composant1, Composant2) :-
    (
        not(recette(Composant1, Composant2, Objet)),
        not(recette(Composant2, Composant1, Objet))
    ),
    writel('Cette recette n\'existe pas.'),
    !.

assembler(Composant1, Composant2) :-
    (
        not(objet(Composant1, inventaire));
        not(objet(Composant2, inventaire))
    ),
    writel('Vous n\'avez pas les composants nécessaires.'),
    !.
