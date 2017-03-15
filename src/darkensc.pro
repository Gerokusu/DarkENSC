%Initialisation de l'encodage
:- encoding(utf8).

%Initialisation des prédicats dynamiques
:- dynamic position/1, porte/3, objet/2.

%À rerentrer dans demarrer
:- retractall(position(_)).
:- retractall(objet(_)).

%Position actuelle du joueur
position(foyer).

%Définition des données
porte(foyer, n, hall_sud).
porte(hall_sud, s, foyer).
porte(hall_sud, e, s101103).
porte(hall_sud, o, couloir_biblio).
porte(couloir_biblio, e, hall_sud).
porte(couloir_biblio, s, biblio).
porte(couloir_biblio, o, couloir_amphi).
porte(biblio, n, couloir_biblio).
porte(couloir_amphi, e, couloir_biblio).
porte(couloir_amphi, o, amphi).
porte(couloir_amphi, n, hall_ouest).
porte(amphi, e, couloir_amphi).
porte(hall_ouest, s, couloir_amphi).
porte(hall_ouest, n, administration).
porte(administration, s, hall_ouest).

objet(carte_etudiante, biblio).
objet(pistolet, hall_sud).

%Définition des données de jeu
demarrer :-
    nl,
    write('Vous vous réveillez d\'un sommeil profond, accompagné d\'un mal au crâne notoire, et d\'une sensation de malaise. Vous vous sentez seul.'),
    nl,
    nl,
    write('Les commandes suivantes sont à votre disposition (terminer par un point) :'),
    nl,
    write('    n                            aller au nord'),
    nl,
    write('    e                            aller à l\'est'),
    nl,
    write('    s                            aller au sud'),
    nl,
    write('    o                            aller à l\'ouest'),
    nl,
    write('    ramasser(objet)              ramasser un objet'),
    nl,
    write('    inventaire                   afficher le contenu de votre inventaire'),
    nl,
    position(Salle),
    salle(Salle).

%Décrit l'événement déclenché à l'entrée d'une salle.
salle(foyer) :-
    nl,
    write('[FOYER DE L\'ÉCOLE] - Le foyer de l\'école est d\'habitude un endroit serein où les élèves ont l\'habitude de se reposer. Mais il est anormalement sale, poussiéreux, et présente quelques traces de sang. Le baby-foot est cassé, le bar est vide, les canapés sont déchirés et une seule porte, au nord, est en état de fonctionner. Elle mène au hall sud.'),
    nl.

salle(hall_sud) :-
    nl,
    write('[HALL SUD] - Du hall sud, on peut observer au nord le patio à travers les baies vitrées opaques. Un vent sombre et silencieux y rêgne, et la porte automatique ne semble pas vouloir bouger d\'un millimètre. À l\'est, la S101-S103 est bloquée par une poutre et un texte rouge vif, écrit dans la précipitation, stipulant de "NE PAS OUVRIR". À l\'ouest, le couloir de la bibliothèque s\'étend pendant plusieurs longues dizaines de mètres. Au sud, se trouve le foyer.'),
    nl.

salle(s101103) :-
    nl,
    %RAJOUTER SARACCO
    write('[S101-103] - Après avoir ignoré l\'avertissement et lutté pour lever la poutre qui bloquait l\'entrée de la salle S101-S103, une vision d\'horreur remplace la scène : un tableau rempli de formules statistiques, quelques amas de chairs pendant au plafond et des tables cassées. Aussitôt, une ombre se profile au loin, puis disparait. Elle ressurgit dans un vacarme assourdissant à la seconde d\'après, armée d\'un regard fixe et d\'un sourire de cauchemar. Il est déjà trop tard.'),
    nl,
    mourir_prevention.

salle(couloir_biblio) :-
    nl,
    write('couloir biblio --> droite gauche bas'),
    nl.

salle(biblio) :-
    nl,
    write('biblio'),
    nl.

salle(couloir_amphi) :-
    nl,
    write('couloir amphi'),
    nl.

salle(amphi):-
    nl,
    write('amphi'),
    nl.

salle(hall_ouest) :-
    nl,
    write('hall ouest'),
    nl.

salle(administration) :-
    nl,
    write('administration'),
    nl.

%Permet de se rendre à la salle par la porte située à Direction.
aller(Direction) :-
    position(Position),
    porte(Position, Direction, Destination),
    retract(position(Position)),
    assert(position(Destination)),
    salle(Destination),
    !.

aller(mort) :-
    nl,
    write('Le jeu va maintenant se quitter. tape sur entree'),
    nl,
    nl,
    get_char(_),
    halt.

aller(_) :-
    nl,
    write('Vous ne pouvez pas aller dans cette direction.'),
    nl.

%Permet de ramasser Objet pour le mettre dans l'inventaire. L'inventaire est considéré comme une "salle" imaginaire.
ramasser(Objet) :-
    position(Position),
    objet(Objet,Position),
    assert(objet(Objet, inventaire)),
    retract(objet(Objet, Position)),
    nl,
    write('Youpi ! L\'objet '), write(Objet),write(' a été ajouté au sac !'),
    nl,
    !.

ramasser(_):-
    nl,
    write('rien à ramasser débile'),
    nl,
    !.

% Affiche l'inventaire
inventaire :-
    nl,
    write('[INVENTAIRE]'),
    nl,
    nl,
    objet(_,inventaire),
    forall(objet(X,inventaire), (write('    - '),write(X),nl)),
    nl,
    !.

inventaire :-
    write('Vous avez les poches bien vides.'),
    nl,
    !.

%Permet de... mourir.
mourir :-
    nl,
    write('VOUS ÊTES MORT.'),
    nl,
    aller(mort).

%Permet de... mourir avec un message humiliant. On vous avait prévenu !
mourir_prevention :-
    nl,
    write('VOUS ÊTES MORT (ET VOUS ÉTIEZ PRÉVENUS).'),
    nl,
    aller(mort).

%Définition des raccourcis.
d :- demarrer.
n :- aller(n).
e :- aller(e).
s :- aller(s).
o :- aller(o).
