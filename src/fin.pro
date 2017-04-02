%Initialisation de l'encodage
:- encoding(utf8).

victoire :-
    writel_bold('VOUS ÊTES PARVENU À VOUS ENFUIRE DE CET ENFER. MAIS LE MONDE EXTÉRIEUR EST-IL POUR AUTANT PLUS SÛR ?', white),
    aller(fin).

%Permet de... mourir.
mourir :-
    writel_bold('VOUS ÊTES MORT.', red),
    aller(fin).

%Permet de... mourir avec un message humiliant. On vous avait prévenu !
mourir_prevention :-
    writel_bold('VOUS ÊTES MORT (ET VOUS ÉTIEZ PRÉVENUS).', red),
    aller(fin).
