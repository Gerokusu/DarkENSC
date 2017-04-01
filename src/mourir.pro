%Initialisation de l'encodage
:- encoding(utf8).

%Permet de... mourir.
mourir :-
    writel_bold('VOUS ÊTES MORT.', red),
    aller(mort).

%Permet de... mourir avec un message humiliant. On vous avait prévenu !
mourir_prevention :-
    writel_bold('VOUS ÊTES MORT (ET VOUS ÉTIEZ PRÉVENUS).', red),
    aller(mort).
