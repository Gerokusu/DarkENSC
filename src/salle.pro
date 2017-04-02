%Initialisation de l'encodage
:- encoding(utf8).

%Décrit l'événement déclenché à l'entrée d'une salle.
salle(foyer) :-
    temps(X),
    writep('[FOYER DE L\'ÉCOLE]', 'Le foyer de l\'école est d\'habitude un endroit serein où les élèves ont l\'habitude de se reposer. Mais il est anormalement sale, poussiéreux, et présente quelques traces de sang. Le baby-foot est cassé, le bar est vide, les canapés sont déchirés et une seule porte, au nord, est en état de fonctionner. Elle mène au hall sud.'),
    nl,
    write('Sur le mur est inscrit avec ce qui semble être du sang : '),
    write(X),
    write(' MINUTES. Il ne s\'agit probablement pas du journal, mais plutôt du temps qu\'il reste avant que quelquechose de terrible ne se produise.'),
    nl,
    !.

salle(hall_sud) :-
    verifier_etat(poursuite),
    writep('[HALL SUD]', 'Du hall sud, on peut observer au nord le patio à travers les baies vitrées opaques. Un vent sombre et silencieux y rêgne, et la porte automatique fonctionne. À l\'est, la S101-S103 est bloquée par une poutre et un texte rouge vif, écrit dans la précipitation, stipulant de "NE PAS OUVRIR". À l\'ouest, le couloir de la bibliothèque s\'étend pendant plusieurs longues dizaines de mètres.'),
    !.

salle(hall_sud) :-
    writep('[HALL SUD]', 'Du hall sud, on peut observer au nord le patio à travers les baies vitrées opaques. Un vent sombre et silencieux y rêgne, et la porte automatique ne semble pas vouloir bouger d\'un millimètre. À l\'est, la S101-S103 est bloquée par une poutre et un texte rouge vif, écrit dans la précipitation, stipulant de "NE PAS OUVRIR". À l\'ouest, le couloir de la bibliothèque s\'étend pendant plusieurs longues dizaines de mètres.'),
    (
        objet('pistolet', 'inventaire');
        writel('Au sol se trouve un [pistolet] un peu sale, mais il semble fonctionner.')
    ),
    (
        not(porte(hall_sud, s, foyer));
        retract(porte(hall_sud, s, foyer)),
        writel('La porte du foyer se ferme dans un vacarme assourdissant et disparait, laissant place à la continuité du mur sur lequel elle était présente. Il n\'est plus possible d\'y retourner.')
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
    verifier_etat(aDictionnaire),
    writep('[AMPHITHÉÂTRE]', 'Un atmosphère rassurant semblable à celui du foyer reigne dans l\'amphithéâtre, qui semble avoir été épargné. Une lumière tamisée brille au fond : il s\'agit d\'un ordinateur ! Il est cependant figé sur un seul écran, qui s\'apparente à un terminal. Il est possible de sortir par la porte nord.'),
    ordinateur,
    !.

salle(amphi):-
    writep('[AMPHITHÉÂTRE]', 'Un atmosphère rassurant semblable à celui du foyer reigne dans l\'amphithéâtre, qui semble avoir été épargné. Une lumière tamisée brille au fond : il s\'agit d\'un ordinateur ! Il est cependant figé sur un seul écran, qui s\'apparente à un terminal. Il est possible de sortir par la porte nord.'),
    ordinateur,
    !.

salle(hall_ouest) :-
    verifier_etat(poursuite),
    writep('[HALL OUEST]', 'C\'est à l\'ouest que se trouve la porte de sortie ! Au nord, la porte de l\'administration semble entre-ouverte. Au sud, le couloir de l\'amphithéâtre semble vous appeler. Et à l\'est, le patio est accessible.'),
    !.

salle(hall_ouest) :-
    writep('[HALL OUEST]', 'Une étrange sensation envahit les sens dans cette salle. Un sentiment de liberté en voyant la porte automatique de la sortie, tranché par le triste retour à la réalité : le courant n\'est toujours pas rétabli. Au nord, la porte de l\'administration semble entre-ouverte. Au sud, le couloir de l\'amphithéâtre semble vous appeler.'),
    (
        objet('balles', 'inventaire');
        writel('Un petit éclat provient d\'une étagère, à côté de la porte de sortie. Après inspection, il semble s\'agir d\'une [balle] de pistolet !')
    ),
    (
        not(verifier_etat_strict(courantRetabli));
        writel('Le courant a permis d\'ouvrir la porte du patio à l\'est et la porte de sortie à l\'ouest, mais Claverie bloque l\'accès de cette dernière et commence à vous poursuivre !'),
        changer_etat(detecte),
        assert(claverie(o))
    ),
    !.

salle(administration) :-
    verifier_etat(nadegeKO),
    writep('[BUREAUX DE L\'ADMINISTRATION]', 'Le corps assommé de Nadège a disparu, seul reste un bout de sa main accroché au mur... Il est possible d\'accéder au bureau de Plotton par l\'ouest, ou revenir au hall ouest par le sud.'),
    !.

salle(administration) :-
    writep('[BUREAUX DE L\'ADMINISTRATION]', 'Au milieu des bureaux se dresse un silhouette noire et élancée, habillée comme une secrétaire, dont les deux yeux rouges fixent quiconque ose les regarder. Cependant, elle semble attachée au mur et ne peut bouger. Celà dit, mieux vaut ne pas s\'en approcher. Elle bloque l\'accès ouest vers le bureau de Plotton. Au sud, la porte mène vers le hall ouest.'),
    !.

salle(bureau_plotton):-
    writep('[BUREAU DE PLOTTON]', 'Dans une jungle de câbles et appareils électroniques, il est possible de distinguer le [disjoncteur] de l\'école. Grâce à lui, il sera possible d\'ouvrir la porte de sortie ! Il est possible de revenir aux bureaux de l\'administration par la porte est.'),
    !.

salle(patio) :-
    writep('[PATIO]', 'Occupé par des vents sombres, le patio autrefois paisible sent la mort et le danger. Il serait bon ne pas s\'y attarder.'),
    !.

salle(sortie):-
    verifier_etat(courantRetabli),
    writep('[SORTIE]', 'Grâce au courant rétabli, la porte s\'ouvre enfin ! La liberté s\'étend en face, mais des silhouettes inquiétantes font leur apparition au fur et à mesure que l\'ENSC disparaît...'),
    victoire,
    !.

salle(sortie):-
    writel('Malgré tous les efforts, la porte refuse de s\'ouvrir. Le courant doit être rétabli pour pouvoir l\'actionner.'),
    aller(r),
    !.

salle(_):-
    writel('Cette salle n\'existe pas.'),
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
    (
        not(verifier_etat(poursuite));
        claverie_verifier(Direction)
    ),
    retract(position(Position)),
    assert(position(Destination)),
    salle(Destination),
    (
        (
            not(verifier_etat(poursuite));
            claverie_tp(Direction)
        ),
        (
            not(verifier_etat_strict(detecte));
            claverie_tp(e),
            changer_etat(poursuite)
        )
    ),
    temps_baisse(),
    !.

aller(fin) :-
    writel('Le jeu va maintenant se quitter. Veuillez appuyer sur Entrée.'),
    nl,
    get_char(_),
    halt.

aller(_) :-
    writel('Vous ne pouvez pas aller dans cette direction.').
