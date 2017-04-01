%Initialisation de l'encodage
:- encoding(utf8).

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
