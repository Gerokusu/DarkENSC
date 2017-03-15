%Initialisation des prédicats dynamiques
:- dynamic position/1.
:- retractall(position(_)).

position(foyer).

%Définition des données de jeu
porte(foyer, h, hall_sud).
porte(hall_sud, b, foyer).
porte(hall_sud, d, s101103).

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
    salle(Salle).

salle(foyer) :-
    nl,
    write('Le foyer de l\'école est d\'habitude un endroit serein où les élèves ont l\'habitude de se reposer. Mais il est anormalement sale, poussiéreux, et présente quelques traces de sang. Le baby-foot est cassé, le bar est vide, les canapés sont légèrement déchirés et une seule porte, en haut, est en état de fonctionner. Elle mène au hall sud.'),
    nl.

salle(hall_sud) :-
    nl,
    write('Du hall sud, on peut observer le patio à travers les baies vitrées opaques. Un vent sombre et silencieux y règne, et la porte automatique ne semble pas vouloir bouger d\'un centimètre. À droite, la S101-S103 est bloquée par une poutre et un texte rouge vif, écrit dans la précipitation, stipulant de "NE PAS OUVRIR". À gauche, le couloir menant au bâtiment ouest s\'étend pendant plusieurs longues dizaines de mètres. En bas, se trouve le foyer.'),
    nl.

salle(s101103) :-
    nl,
    write('Après avoir ignoré l\'avertissement et lutté pour lever la poutre qui bloquait l\'entrée de la salle S101-S103, une vision d\'horreur remplace la scène : un tableau rempli de formules statistiques, quelques amas de chairs pendant au plafond et des tables cassées. Aussitôt, une ombre se profile au loin, puis disparait. Elle ressurgit dans un vacarme assourdissant à la seconde d\'après, armée d\'un regard fixe et d\'un sourire de cauchemar. Il est déjà trop tard.'),
    nl,
    mourir_prevention.

salle(mort) :-
    nl,
    write('Le jeu va maintenant se quitter.'),
    nl,
    nl,
    halt.

aller(Direction) :-
    position(Position),
    porte(Position, Direction, Destination),
    deplacer(Position, Destination),
    !.

aller(_) :-
    nl,
    write('Il n\'y a aucune porte dans cette direction.'),
    nl.

deplacer(Position, Destination) :-
    retract(position(Position)),
    assert(position(Destination)),
    !,
    salle(Destination).

mourir :-
    nl,
    write('VOUS ÊTES MORT.'),
    nl,
    deplacer(_, mort).

mourir_prevention :-
    nl,
    write('VOUS ÊTES MORT (ET VOUS ÉTIEZ PRÉVENUS).'),
    nl,
    deplacer(_, mort).

h :- aller(h).
d :- aller(d).
b :- aller(b).
g :- aller(g).
