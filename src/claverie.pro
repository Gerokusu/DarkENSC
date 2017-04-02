%Initialisation de l'encodage
:- encoding(utf8).

claverie_tp(n) :-
    claverie(X),
    retract(claverie(X)),
    assert(claverie(s)),
    writel("Claverie est à la porte sud !"),
    !.

claverie_tp(e) :-
    claverie(X),
    retract(claverie(X)),
    assert(claverie(o)),
    writel("Claverie est à la porte ouest !"),
    !.

claverie_tp(s) :-
    claverie(X),
    retract(claverie(X)),
    assert(claverie(n)),
    writel("Claverie est à la porte nord !"),
    !.

claverie_tp(o) :-
    claverie(X),
    retract(claverie(X)),
    assert(claverie(e)),
    writel("Claverie est à la porte est !"),
    !.

claverie_verifier(Direction) :-
    claverie(X),
    (
        not(X == Direction);
        write('Vous foncez dans les bras de Claverie, qui vous broie aussitôt.'),
        mourir
    ),
    !.
