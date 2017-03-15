set_stream(encoding, utf8).

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
porte(hall_sud,o,couloir_biblio).
porte(couloir_biblio,e,hall_sud).
porte(couloir_biblio,s,biblio).
porte(couloir_biblio,o,couloir_amphi).
porte(biblio,n,couloir_biblio).
porte(couloir_amphi,e,couloir_biblio).
porte(couloir_amphi,o,amphi).
porte(couloir_amphi,n,hall_ouest).
porte(amphi,e,couloir_amphi).
porte(hall_ouest,s,couloir_amphi).
porte(hall_ouest,n,administration).
porte(administration,s,hall_ouest).

objet(carte_etudiante, biblio).
objet(pistolet, hall_sud).

%Définition des données de jeu
demarrer :-
    nl,
    write('Vous vous r�veillez d\'un sommeil profond, accompagn� d\'un mal au cr�ne notoire, et d\'une sensation de malaise. Vous vous sentez seul.'),
    nl,
    nl,
    write('Les commandes suivantes sont � votre disposition (terminer par un point) :'),
    nl,
    write('    n                            aller au nord'),
    nl,
    write('    e                            aller l\'est'),
    nl,
    write('    s                            aller au sud'),
    nl,
    write('    o                            aller l\'ouest'),
    nl,
    write('    ramasser(objet)              ramasser un objet'),
    nl,
    write('    inventaire                   afficher le contenu de votre inventaire'),
    nl,
    position(Salle),
    salle(Salle).

%La salle décrit l'événement déclenché à l'entrée de la salle

salle(foyer) :-
    nl,
    write('[FOYER DE L\'�COLE] - Le foyer de l\'�cole est d\'habitude un endroit serein o� les �l�ves ont l\'habitude de se reposer. Mais il est anormalement sale, poussi�reux, et pr�sente quelques traces de sang. Le baby-foot est cass�, le bar est vide, les canap�s sont d�chir�s et une seule porte, au nord, est en �tat de fonctionner. Elle m�ne au hall sud.'),
    nl.

salle(hall_sud) :-
    nl,
    write('[HALL SUD] - Du hall sud, on peut observer au nord le patio � travers les baies vitr�es opaques. Un vent sombre et silencieux y r�gne, et la porte automatique ne semble pas vouloir bouger d\'un millim�tre. � l\'est, la S101-S103 est bloqu�e par une poutre et un texte rouge vif, �crit dans la pr�cipitation, stipulant de "NE PAS OUVRIR". � l\'ouest, le couloir menant au b�timent ouest s\'�tend pendant plusieurs longues dizaines de m�tres. Au sud, se trouve le foyer.'),
    nl.

salle(s101103) :-
    nl,
    %RAJOUTER SARACCO
    write('[S101-103] - Apr�s avoir ignor� l\'avertissement et lutt� pour lever la poutre qui bloquait l\'entr�e de la salle S101-S103, une vision d\'horreur remplace la sc�ne : un tableau rempli de formules statistiques, quelques amas de chairs pendant au plafond et des tables cass�es. Aussit�t, une ombre se profile au loin, puis disparait. Elle ressurgit dans un vacarme assourdissant � la seconde d\'apr�s, arm�e d\'un regard fixe et d\'un sourire de cauchemar. Il est d�j�trop tard.'),
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

salle(mort) :-
    nl,
    write('Le jeu va maintenant se quitter. tape sur entree'),
    nl,
    nl,
    get_char(_),
    halt.

aller(Direction) :-
    position(Position),
    porte(Position, Direction, Destination),
    deplacer(Position, Destination),
    !.

aller(_) :-
    nl,
    write('Vous ne pouvez pas aller dans cette direction.'),
    nl.

deplacer(Position, Destination) :-
    retract(position(Position)),
    assert(position(Destination)),
    !,
    salle(Destination).

ramasser(Objet) :-
    position(Position),
    objet(Objet,Position),
    assert(objet(Objet, inventaire)), %inventaire est considéré comme une "salle" imaginaire
    retract(objet(Objet, Position)),
    nl,
    write('Youpi ! L\'objet '), write(Objet),write(' a �t� ajout� au sac !'),
    nl.

ramasser(_):-
    nl,
    write('rien � ramasser d�bile'),
    nl.

% Affiche l'inventaire
inventaire :-
    write('INVENTAIRE :'),
    nl,
    forall(objet(X,inventaire), (write('- '),write(X),nl)).

inventaire :-
    write('INVENTAIRE : vide'),
    nl.

mourir :-
    nl,
    write('VOUS �TES MORT.'),
    nl,
    deplacer(_, mort).

mourir_prevention :-
    nl,
    write('VOUS �TES MORT (ET VOUS ʉTIEZ PRɉVENUS).'),
    nl,
    deplacer(_, mort).

d :- demarrer.
n :- aller(n).
e :- aller(e).
s :- aller(s).
o :- aller(o).
