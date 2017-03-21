%Chargement des fichiers
:- consult('utils.pro').

%Initialisation de l'encodage
:- encoding(utf8).

%Initialisation des prédicats dynamiques
:- dynamic position/1, etat_actuel/2, porte/3, objet/2.

%À rerentrer dans demarrer
:- retractall(position(_)).
:- retractall(objet(_)).

%Position de départ du joueur et état initial
position(foyer).
etat_actuel(depart, 1).

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
porte(couloir_amphi, n, hall_ouest).
porte(amphi, e, couloir_amphi).
porte(hall_ouest, s, couloir_amphi).
porte(hall_ouest, n, administration).
porte(hall_ouest, o, sortie).
porte(administration, s, hall_ouest).
porte(sortie, r, hall_ouest).

objet(carte_etudiante, biblio).
objet(pistolet, hall_sud).

etat(depart, 1).
etat(aCarteEtudiante, 2).
etat(amphiOK, 3).
etat(aDictionnaire, 4).
etat(nadegeKO, 5).
etat(courantRetabli, 6).

%Définition des données de jeu
demarrer :-
    writep('[INTRODUCTION]', 'Vous vous réveillez d\'un sommeil profond, accompagné d\'un mal au crâne notoire, et d\'une sensation de malaise. Vous vous sentez seul, vous êtes seul.'),
    writel('Les commandes suivantes sont à votre disposition (terminer par un point) :'),
    writel('    n                            aller au nord'),
    writel('    e                            aller à l\'est'),
    writel('    s                            aller au sud'),
    writel('    o                            aller à l\'ouest'),
    writel('    ramasser(objet)              ramasser un objet'),
    writel('    inventaire                   afficher le contenu de votre inventaire'),
    writel('    utiliser(objet)              utiliser un objet de l\'inventaire'),
    position(Salle),
    salle(Salle).

%Décrit l'événement déclenché à l'entrée d'une salle.
salle(foyer) :-
    writep('[FOYER DE L\'ÉCOLE]', 'Le foyer de l\'école est d\'habitude un endroit serein où les élèves ont l\'habitude de se reposer. Mais il est anormalement sale, poussiéreux, et présente quelques traces de sang. Le baby-foot est cassé, le bar est vide, les canapés sont déchirés et une seule porte, au nord, est en état de fonctionner. Elle mène au hall sud.'),
    !.

salle(hall_sud) :-
    writep('pistolet a rajouter [HALL SUD]', 'Du hall sud, on peut observer au nord le patio à travers les baies vitrées opaques. Un vent sombre et silencieux y rêgne, et la porte automatique ne semble pas vouloir bouger d\'un millimètre. À l\'est, la S101-S103 est bloquée par une poutre et un texte rouge vif, écrit dans la précipitation, stipulant de "NE PAS OUVRIR". À l\'ouest, le couloir de la bibliothèque s\'étend pendant plusieurs longues dizaines de mètres. Au sud, se trouve le foyer.'),
    !.

salle(s101103) :-
    writep('[S101-S103]', 'Après avoir ignoré l\'avertissement et lutté pour lever la poutre qui bloquait l\'entrée de la salle S101-S103, une vision d\'horreur remplace la scène : un tableau rempli de formules statistiques, quelques amas de chairs pendant au plafond et des tables cassées. Aussitôt, une ombre se profile au loin, puis disparait. Elle ressurgit dans un vacarme assourdissant à la seconde d\'après, armée d\'un regard fixe et d\'un sourire de cauchemar. Il est déjà trop tard.'),
    mourir_prevention.

salle(couloir_biblio) :-
    writep('[COULOIR DE LA BIBLIOTHÈQUE]', ''),
    !.

salle(biblio) :-
    writep('[BIBLIOTHÈQUE]', ''),
    !.

salle(couloir_amphi) :-
    etat_actuel(_, N),
    N < 3,
    writep('[COULOIR DE L\'AMPHITHÉÂTRE]', 'lacces à lamphi est verrouille'),
    !.

salle(couloir_amphi) :-
    etat_actuel(_, N),
    N => 3,
    writep('[COULOIR DE L\'AMPHITHÉÂTRE]', ''),
    !.

salle(amphi):-
    writep('[AMPHITHÉÂTRE]', 'Ecrire blablah il rentre dans l amphi et voit l ordi avec pesquet dessus (GIF) + trouver sol enigme sinon attention ombre de Paf + dire décrire la rep entre enigme()'),
    writel('ENIGME : Pour moi l\'accouchement est avant la grossesse, l\'enfance avant la naissance, l\'adolescence avant l\'enfant, la mort avant la vie. Qui suis-je?'),
    !.   

salle(hall_ouest) :-
    writep('[HALL OUEST]', ''),
    !.   

salle(administration) :-
    writep('[BUREAUX DE L\'ADMINISTRATION]', 'nadege bloque'),
    !.

salle(bureau_plotton):-
    writep('[BUREAU DE PLOTTON]', ''),
    !.

salle(sortie):-
    not(etat_actuel(courantRetabli)),
    writel('vous ne pouvez pas sortir, courant marche pas'),
    aller(r),
    !.

salle(sortie):-
    etat_actuel(courantRetabli),
    writep('[SORTIE]', 'gagné !'),
    !.

salle(_):-
    writel('erreur predicat salle'),
    !.

%Permet de se rendre à la salle par la porte située à Direction.
aller(r) :-
    position(Position),
    porte(Position, r, Destination),
    retract(position(Position)),
    assert(position(Destination)),
    !.

aller(Direction) :-
    position(Position),
    porte(Position, Direction, Destination),
    retract(position(Position)),
    assert(position(Destination)),
    salle(Destination),
    !.

aller(mort) :-
    writel('Le jeu va maintenant se quitter. Veuillez appuyer sur Entrée.'),
    nl,
    get_char(_),
    halt.

aller(_) :-
    writel('Vous ne pouvez pas aller dans cette direction.').

%Permet de ramasser Objet pour le mettre dans l'inventaire. L'inventaire est considéré comme une "salle" imaginaire.
ramasser(Objet) :-
    position(Position),
    objet(Objet,Position),
    assert(objet(Objet, inventaire)),
    retract(objet(Objet, Position)),
    nl,
    write('Youpi ! L\'objet '),
    write(Objet),
    write(' a été ajouté au sac !'),
    nl,
    !.

    %créer un événement au ramassage (ici c'est pour changer l'état : aCarteEtudiante et aDictionnaire)
    %tester les utiliser()

ramasser(_):-
    writel('Aucun objet ne peut être ramassé ici.'),
    !.

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

%Utiliser un objet de l'inventaire
utiliser(pistolet):-
    objet(pistolet,inventaire),
    position(s101103);position(administration),
    writel('ça sert à rien, trouve autre chose'),
    !.

utiliser(carte_etudiante):-
    objet(carte_etudiante,inventaire),
    position(couloir_amphi),
    assert(porte(couloir_amphi, o, amphi)),
    writel('L\'accès à l\'amphi est ok'),
    !.

utiliser(dictionnaire):-
    objet(dictionnaire,inventaire),
    position(administration),
    assert(porte(administration,o,bureau_plotton)),
    writel('Vous pouvez maintenant accéder au bureau de Plotton !'),
    changer_etat(nadegeKO),
    !.

utiliser(_):-
    etat_actuel(courantRetabli, N),
    writel('pas le temps, cours !'),
    !.

utiliser(_):-
    writel('tu ne peux pas faire ça'),
    !.

%Permet de vérifier si le joueur trouve l'énigme
enigme(dictionnaire):-
    position(amphi),    
    not(objet(dictionnaire,inventaire)),
    assert(objet(dictionnaire, amphi)),
    writel('placard souvre et dico'),
    ramasser(dictionnaire),
    !.

enigme(_):-
    position(amphi),
    not(objet(dictionnaire,inventaire)),
    writel('paf la menace'),
    mourir_prevention,
    !.
    
enigme(_):-
    writel('Qu\'est ce que vous essayez de faire?').

%Permet de changer d'état.
changer_etat(Prochain) :-
    etat_actuel(E, N1),
    etat(E, N1),
    etat(Prochain, N2),
    N2 > N1,
    retract(etat_actuel(E, N1)),
    assert(etat_actuel(Prochain, N2)).

%Permet de... mourir.
mourir :-
    writel_bold('VOUS ÊTES MORT.', red),
    aller(mort).

%Permet de... mourir avec un message humiliant. On vous avait prévenu !
mourir_prevention :-
    writel_bold('VOUS ÊTES MORT (ET VOUS ÉTIEZ PRÉVENUS).', red),
    aller(mort).

%Définition des raccourcis.
d :- demarrer.
n :- aller(n).
e :- aller(e).
s :- aller(s).
o :- aller(o).
