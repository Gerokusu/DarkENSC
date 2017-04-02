%Initialisation de l'encodage
:- encoding(utf8).

%Baisse le compteur de temps
temps_baisse() :-
    temps(X),
    Y is X - 1,
    retract(temps(X)),
    assert(temps(Y)),
    not(temps_zero),
    nl,
    write('Il reste '),
    write(Y),
    write(' minutes.'),
    nl,
    !.

temps_zero() :-
    temps(X),
    X =< 0,
    writel('Cependant, le temps est écoulé. Les murs semblent se refermer et écrasent sans pitié la pauvre âme égarée en ces lieux.'),
    mourir.
