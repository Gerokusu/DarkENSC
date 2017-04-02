%Initialisation de l'encodage
:- encoding(utf8).

%Décrit l'état actuel de l'ordinateur.
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
    writel('Un message marqué "SUCCÈS" s\'affiche, en même temps que le tiroir du bureau s\'ouvre. Un dictionnaire bien solide est placé à l\'intérieur. Vous décidez de le prendre, ça peut toujours servir.'),
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
