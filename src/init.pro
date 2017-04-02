%Initialisation de l'encodage
:- encoding(utf8).

%Chargement des fichiers
:- consult('utils.pro').
:- consult('etat.pro').
:- consult('temps.pro').
:- consult('salle.pro').
:- consult('inventaire.pro').
:- consult('ramasser.pro').
:- consult('assembler.pro').
:- consult('utiliser.pro').
:- consult('ordinateur.pro').
:- consult('claverie.pro').
:- consult('fin.pro').

%Initialisation des prédicats dynamiques
:- dynamic position/1, etat_actuel/2, porte/3, objet/2, temps/1, claverie/1.

%À rerentrer dans demarrer
:- retractall(position(_)).
:- retractall(objet(_)).

%Position de départ du joueur, état initial et temps restant initial
position(foyer).
etat_actuel(depart, 1).
temps(30).

%Définition des données
porte(foyer, n, hall_sud).
porte(hall_sud, s, foyer).
porte(hall_sud, e, s101103).
porte(hall_sud, o, couloir_biblio).
porte(couloir_biblio, e, hall_sud).
porte(couloir_biblio, s, biblio).
porte(couloir_biblio, o, couloir_amphi).
porte(biblio, n, couloir_biblio).
porte(couloir_amphi, e, couloir_biblio).
porte(couloir_amphi, n, hall_ouest).
porte(amphi, e, couloir_amphi).
porte(hall_ouest, s, couloir_amphi).
porte(hall_ouest, n, administration).
porte(hall_ouest, o, sortie).
porte(administration, s, hall_ouest).
porte(sortie, r, hall_ouest).

objet(carte_etudiante, biblio).
objet(pistolet, hall_sud).
objet(balle, hall_ouest).

recette(pistolet, balle, pistolet_charge).

etat(depart, 1).
etat(aCarteEtudiante, 2).
etat(amphiOK, 3).
etat(aDictionnaire, 4).
etat(nadegeKO, 5).
etat(courantRetabli, 6).
etat(detecte, 7).
etat(poursuite, 8).

%Définition des données de jeu
demarrer :-
    writep('[INTRODUCTION]', 'Vous vous réveillez d\'un sommeil profond, accompagné d\'un mal au crâne notoire, et d\'une sensation de malaise. Vous vous sentez seul... vous êtes seul.'),
    writel('Les commandes suivantes sont à votre disposition (terminer par un point) :'),
    writel('    n                            aller au nord'),
    writel('    e                            aller à l\'est'),
    writel('    s                            aller au sud'),
    writel('    o                            aller à l\'ouest'),
    writel('    ramasser(objet)              ramasser un objet'),
    writel('    assembler(objet1, objet2)    tenter d\'assembler deux objets de l\'inventaire'),
    writel('    utiliser(objet)              utiliser un objet de l\'inventaire ou de l\'environnement'),
    writel('    inventaire                   afficher le contenu de votre inventaire'),
    position(Salle),
    salle(Salle).

%SYSTEME DE DECLENCHEURS
%declencher(Declencheur) :-

%Définition des raccourcis.
d :- demarrer.
n :- aller(n).
e :- aller(e).
s :- aller(s).
o :- aller(o).
i :- inventaire.
