%Initialisation de l'encodage
:- encoding(utf8).

utiliser(disjoncteur) :-
    position(bureau_plotton),
    verifier_etat(nadegeKO),
    changer_etat(courantRetabli),
    assert(porte(hall_ouest, e, patio)),
    assert(porte(patio, o, hall_ouest)),
    assert(porte(hall_sud, n, patio)),
    assert(porte(patio, s, hall_sud)),
    writel('Le disjoncteur a permi de rétablir le courant.'),
    writel('Vous entendez un cri strident au loin.'),
    !.

%Utiliser un objet de l'inventaire
utiliser(pistolet_charge) :-
    objet(pistolet_charge, inventaire),
    position(administration),
    not(verifier_etat(nadegeKO)),
    writel('Une balle part du canon du pistolet pour se loger dans l\'épaule du la silhouette. Cependant, elle semble n\'en avoir strictement rien à faire.'),
    !.

utiliser(carte_etudiante) :-
    objet(carte_etudiante,inventaire),
    position(couloir_amphi),
    assert(porte(couloir_amphi, o, amphi)),
    writel('En plaquant la carte étudiante sur l\'un des boîtiers, un petit \'bip\' s\'en échappe, et sa diode change de couleur pour le vert. L\'accès à l\'amphithéâtre est possible !'),
    changer_etat(amphiOK),
    !.

utiliser(dictionnaire) :-
    objet(dictionnaire, inventaire),
    position(administration),
    assert(porte(administration, o, bureau_plotton)),
    assert(porte(bureau_plotton, e, administration)),
    writel('N\'ayant rien d\'autre à faire, vous lancez le dictionnaire à la face de la silhouette, qui s\'écroule, assomée, par terre. Elle se revèle n\'être autre que Nadège Rodriguez, la secrétaire ! Vous pouvez maintenant accéder au bureau de Plotton, à l\'ouest.'),
    changer_etat(nadegeKO),
    !.

utiliser(_) :-
    verifier_etat(courantRetabli),
    writel('Le temps est précieux, aucun objet ne peut-être utilisé !'),
    !.

utiliser(_) :-
    writel('Vous ne pouvez pas utiliser cet objet.'),
    !.
