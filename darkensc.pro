%Initialisation des prédicats dynamiques
:- dynamic position/1.
:- retractall(position(_)).

position(foyer).

%Définition des données de jeu
porte(foyer, h, hall_sud).

%Actions du joueur
demarrer :-
    nl,
    write('Vous vous réveillez d\'un sommeil profond, accompagné d\'un mal au crâne notoire, et d\'une sensation de malaise. Vous vous sentez seul.'),
    nl,
    nl,
    write('Les commandes suivantes sont à votre disposition :'),
    nl,
    write('    h    :               aller en haut'),
    nl,
    write('    d    :               aller à droite'),
    nl,
    write('    b    :               aller en bas'),
    nl,
    write('    g    :               aller à gauche'),
    nl,
    position(Salle),
    decrire(Salle).

decrire(foyer) :-
    nl,
    write('Le foyer de l\'école est d\'habitude un endroit serein où les élèves ont l\'habitude de se reposer. Mais il est anormalement sale, poussiéreux, et présente quelques traces de sang. Le baby-foot est cassé, le bar est vide, les canapés sont légèrement déchirés et une seule porte, en haut, est en état de fonctionner. Elle mène au hall sud.'),
    nl.

decrire(hall_sud) :-
    nl,
    write('Du hall sud, on peut observer le patio à travers les baies vitrées opaques. Un vent sombre et silencieux y règne, et la porte automatique ne veut pas bouger d\'un centimètre. À droite, la S101-S103 est bloquée par une poutre et un texte rouge vif, écrit dans la précipitation, stipulant de "NE PAS OUVRIR". À gauche, le couloir menant au bâtiment ouest s\'étend pendant plusieurs longues dizaines de mètres. Derrière se trouve le foyer.'),
    nl.

aller(Direction) :-
    position(Position),
    porte(Position, Direction, Destination),
    retract(position(Position)),
    assert(position(Destination)),
    !,
    decrire(Destination).

aller(_) :-
    nl,
    write('Il n\'y a aucune porte dans cette direction.'),
    nl.

h :- aller(h).
d :- aller(d).
b :- aller(b).
g :- aller(g).
