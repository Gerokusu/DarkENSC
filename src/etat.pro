%Initialisation de l'encodage
:- encoding(utf8).

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

verifier_etat_strict(Etat) :-
    etat_actuel(_, N),
    etat(Etat, M),
    N == M.
