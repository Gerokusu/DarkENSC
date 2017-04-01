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
objet(balle, hall_ouest).

recette(pistolet, balle, pistolet_charge).

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
    writel('    assembler(objet1, objet2)    tenter d\'assembler deux objets'),
    writel('    inventaire                   afficher le contenu de votre inventaire'),
    writel('    utiliser(objet)              utiliser un objet de l\'inventaire'),
    position(Salle),
    salle(Salle).

%Décrit l'événement déclenché à l'entrée d'une salle.
salle(foyer) :-
    writep('[FOYER DE L\'ÉCOLE]', 'Le foyer de l\'école est d\'habitude un endroit serein où les élèves ont l\'habitude de se reposer. Mais il est anormalement sale, poussiéreux, et présente quelques traces de sang. Le baby-foot est cassé, le bar est vide, les canapés sont déchirés et une seule porte, au nord, est en état de fonctionner. Elle mène au hall sud.'),
    !.

salle(hall_sud) :-
    writep('[HALL SUD]', 'Du hall sud, on peut observer au nord le patio à travers les baies vitrées opaques. Un vent sombre et silencieux y rêgne, et la porte automatique ne semble pas vouloir bouger d\'un millimètre. À l\'est, la S101-S103 est bloquée par une poutre et un texte rouge vif, écrit dans la précipitation, stipulant de "NE PAS OUVRIR". À l\'ouest, le couloir de la bibliothèque s\'étend pendant plusieurs longues dizaines de mètres. Au sud, se trouve le foyer.'),
    (
        objet('pistolet', 'inventaire');
        writel('Au sol se trouve un [pistolet] un peu sale, mais il semble fonctionner.')
    ),
    !.

salle(s101103) :-
    writep('[S101-S103]', 'Après avoir ignoré l\'avertissement et lutté pour lever la poutre qui bloquait l\'entrée de la salle S101-S103, une vision d\'horreur remplace la scène : un tableau rempli de formules statistiques, quelques amas de chairs pendant au plafond et des tables cassées. Aussitôt, une ombre se profile au loin, puis disparait. Elle ressurgit dans un vacarme assourdissant à la seconde d\'après, armée d\'un regard fixe et d\'un sourire de cauchemar. Il est déjà trop tard.'),
    mourir_prevention.

salle(couloir_biblio) :-
    writep('[COULOIR DE LA BIBLIOTHÈQUE]', 'Sombre et étroit, le couloir de la bibliothèque est un véritable piège qui pourrait se refermer à tout moment. Vers l\'est, le hall sud apparaît comme envahi par les ombres, et respire un danger proche. L\'autre bout du couloir, à l\'est, communique avec le couloir de l\'amphithéâtre. Au sud, la porte de la bibliothèque semble en bon état bien que récemment ouverte.'),
    !.

salle(biblio) :-
    verifier_etat(aCarteEtudiante),
    writep('[BIBLIOTHÈQUE]', 'Anormalement vide, la bibliothèque ne contient que quelques ouvrages brûlés, déchirés et illisibles. La vitre du bureau de la bibliothéquaire est cassée, mais aucun objet intéressant n\'est présent. La seule sortie est au nord, vers le couloir de la bibliothèque.'),
    !.

salle(biblio) :-
    writep('[BIBLIOTHÈQUE]', 'Anormalement vide, la bibliothèque ne contient que quelques ouvrages brûlés, déchirés et illisibles. La vitre du bureau de la bibliothéquaire est cassée, mais aucun objet intéressant n\'est présent à l\'exception d\'une carte étudiante. La seule sortie est au nord, vers le couloir de la bibliothèque.'),
    writel('Sur une étagère se trouve la [carte_etudiante] solitaire.'),
    !.

salle(couloir_amphi) :-
    verifier_etat(amphiOK),
    writep('[COULOIR DE L\'AMPHITHÉÂTRE]', 'Les feuilles qui ornaient le mur paraissent avoir changé. Beaucoup plus de symboles sont présents, écrits dans un rouge vif. Au nord, le hall ouest semble baigner dans un manteau noir. Le chemin est mène vers le couloir de la bibliothèque, qui semble beaucoup plus long qu\'auparavant. Le porte ouest est maintenant ouverte, et donne sur l\'amphithéâtre.'),
    writel('Les boîtiers de validation ont leur diode verte. La porte est débloquée.'),
    !.

salle(couloir_amphi) :-
    writep('[COULOIR DE L\'AMPHITHÉÂTRE]', 'Le mur anciennement rempli d\'affiches sur les clubs de l\'école ne contient maintenant que des feuilles de papier griffonnées dans une langue incompréhensible. Quelques symboles occultes sont reconnaissables. Au nord, le hall ouest semble baigner dans un manteau noir. Le chemin est mène vers le couloir de la bibliothèque, qui semble beaucoup plus long qu\'auparavant. La porte ouest est quant à elle fermée, et donne sur l\'amphithéâtre.'),
    writel('Le courant semble fonctionner dans les petits boîtiers de validation, dont la diode est rouge. Peut-être qu\'une carte étudiante pourrait ouvrir la porte ?'),
    !.

salle(amphi):-
    writep('[AMPHITHÉÂTRE]', 'Un atmosphère rassurant semblable à celui du foyer reigne dans l\'amphithéâtre, qui semble avoir été épargné. Une lumière tamisée brille au fond : il s\'agit d\'un ordinateur ! Il est cependant figé sur un seul écran, qui s\'apparente à un terminal. Il est possible de sortir par la porte nord.'),
    ordinateur,
    !.

salle(hall_ouest) :-
    writep('[HALL OUEST]', 'Une étrange sensation envahit les sens dans cette salle. Un sentiment de liberté en voyant la porte automatique de la sortie, tranché par le triste retour à la réalité : le courant n\'est toujours pas rétabli. Au nord, la porte de l\'administration semble entre-ouverte. Au sud, le couloir de l\'amphithéâtre semble vous appeler.'),
    (
        objet('balles', 'inventaire');
        writel('Un petit éclat provient d\'une étagère, à côté de la porte de sortie. Après inspection, il semble s\'agir d\'une [balle] de pistolet !')
    ),
    !.

salle(administration) :-
    writep('[BUREAUX DE L\'ADMINISTRATION]', 'nadege bloque'),
    !.

salle(bureau_plotton):-
    writep('[BUREAU DE PLOTTON]', ''),
    !.

salle(sortie):-
    verifier_etat(courantRetabli),
    writep('[SORTIE]', 'gagné !'),
    !.

salle(sortie):-
    writel('vous ne pouvez pas sortir, courant marche pas'),
    aller(r),
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

%SYSTEME DE DECLENCHEURS
%declencher(Declencheur) :-

%Permet de ramasser Objet pour le mettre dans l'inventaire. L'inventaire est considéré comme une "salle" imaginaire.
ramasser(pistolet) :-
    not(objet(pistolet, inventaire)),
    writel('Ce pistolet pourrait s\'avérer bien pratique... s\'il était chargé.'),
    fail,
    !.

ramasser(balle) :-
    not(objet(balle, inventaire)),
    writel('Placée dans une arme à feu, cette balle pourrait blesser à peu près n\'importe quoi.'),
    fail,
    !.

ramasser(carte_etudiante) :-
    not(objet(carte_etudiante, inventaire)),
    writel('Une carte étudiante sans photo et au nom effacé avec le temps.'),
    writel('Vous entendez un bruit sourd au loin.'),
    changer_etat(aCarteEtudiante),
    fail,
    !.

ramasser(Objet) :-
    position(Position),
    objet(Objet, Position),
    assert(objet(Objet, inventaire)),
    retract(objet(Objet, Position)),
    nl,
    write('L\'objet ['),
    write_bold(Objet, 'blue'),
    write('] a été ajouté au sac !'),
    nl,
    !.

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

%Utiliser un objet de l'inventaire
utiliser(pistolet) :-
    objet(pistolet, inventaire),
    objet(balles, inventaire),
    position(administration),
    not(verifier_etat(nadegeKO)),
    writel('Une balle part du canon du pistolet pour se loger dans l\'épaule de Nadège. Elle semble n\'en avoir strictement rien à faire.'),
    !.

utiliser(pistolet) :-
    objet(pistolet, inventaire),
    objet(balles, inventaire),
    position(administration),
    writel('Aucune cible n\'est présente dans cette salle.'),
    !.

utiliser(pistolet) :-
    objet(pistolet, inventaire),
    position(administration),
    writel('Le pistolet n\'est pas chargé. Dommage.'),
    !.

utiliser(carte_etudiante) :-
    objet(carte_etudiante,inventaire),
    position(couloir_amphi),
    assert(porte(couloir_amphi, o, amphi)),
    writel('En plaquant la carte étudiante sur l\'un des boîtiers, un petit \'bip\' s\'en échappe, et sa diode change de couleur pour le vert. L\'accès à l\'amphithéâtre est possible !'),
    changer_etat(amphiOK),
    !.

utiliser(dictionnaire) :-
    objet(dictionnaire,inventaire),
    position(administration),
    assert(porte(administration,o,bureau_plotton)),
    writel('Vous pouvez maintenant accéder au bureau de Plotton !'),
    changer_etat(nadegeKO),
    !.

utiliser(_) :-
    verifier_etat(courantRetabli),
    writel('Le temps est précieux, aucun objet ne peut-être utilisé !'),
    !.

utiliser(_) :-
    writel('Vous ne pouvez pas utiliser cet objet.'),
    !.

ordinateur :-
    verifier_etat(aDictionnaire),
    writel('Le terminal a été remplacé par une fenêtre en plein écran, sur laquelle est affiché \'FÉLICITATIONS !\'.'),
    !.

ordinateur :-
    writel('Un texte étrange est affiché sur l\'ordinateur : \"Pour moi, l\'accouchement est avant la grossesse, l\'enfance avant la naissance, l\'adolescence avant l\'enfance, et la mort avant la vie. Qui suis-je ?\". Une commande semble avoir été testée : la commande \'enigme(jesaispas)\'. Elle s\'est cependant soldée par un échec.'),
    !.


%Permet de vérifier si le joueur trouve l'énigme
enigme(dictionnaire) :-
    position(amphi),
    not(objet(dictionnaire, inventaire)),
    assert(objet(dictionnaire, amphi)),
    writel('placard souvre et dico'),
    ramasser(dictionnaire),
    changer_etat(aDictionnaire),
    !.

enigme(pesquet) :-
    position(amphi),
    not(objet(dictionnaire, inventaire)),
    write('Une image GIF animée s\'affiche soudainement, montrant un professeur d\'informatique bien connu en train de danser la lambada. Imprévisible, mais quel bon danseur.'),
    !.

enigme(_) :-
    position(amphi),
    not(objet(dictionnaire,inventaire)),
    writel('Un bruit sourd notifiant une erreur résonne soudain dans l\'amphithéâtre, qui semble se faire envahir par les ombres. Un ricanement grinçant retentit alors qu\'un profond tremblement se fait sentir. La lumière de l\'ordinateur éclaire un visage terrifiant, équipé de lunettes cassées, qui, progressivement, finit par occuper tout le champ de vision. Il est déjà trop tard.'),
    mourir,
    !.

enigme(_) :-
    writel('Qu\'est ce que vous essayez de faire?').

%Permet de changer d'état.
changer_etat(Prochain) :-
    etat_actuel(E, N1),
    etat(E, N1),
    etat(Prochain, N2),
    N2 > N1,
    retract(etat_actuel(E, N1)),
    assert(etat_actuel(Prochain, N2)).

%Vérifie si l'état actuel est supérieur ou égal à l'état requis donné.
verifier_etat(Etat) :-
    etat_actuel(_, N),
    etat(Etat, M),
    N >= M.

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
