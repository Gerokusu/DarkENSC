%Initialisation de l'encodage
:- encoding(utf8).

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

ramasser(dictionnaire) :-
    not(objet(dictionnaire, inventaire)),
    writel('Un dictionnaire bien costaud qui pourrait assomer à peu près n\'importe quoi.'),
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
