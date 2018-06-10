
grille([' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ',
        ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' ]) :- !.

numero([1,2,3,4,5,6,7,8,9,' ']) :- !.

%Recupere l indice de la liste
indice(L,C, N):- N is (L-1) * 9 + C-1.
indiceInverse(N,L,C) :- C is 1 + N mod 9,L is 1 + (1 + N-C) // 9.

%Recupere l indice de Grille
indiceGrille(1,1,1):- !.
indiceGrille(1,4,2):- !.
indiceGrille(1,7,3):- !.
indiceGrille(4,1,4):- !.
indiceGrille(4,4,5):- !.
indiceGrille(4,7,6):- !.
indiceGrille(7,1,7):- !.
indiceGrille(7,4,8):- !.
indiceGrille(7,7,9):- !.

indiceGrille(L,C,N):- L < 4, C < 4, N is 1, !.
indiceGrille(L,C,N):- L < 4, C > 3, C < 7, N is 2, !.
indiceGrille(L,C,N):- L < 4, C > 6, N is 3, !.

indiceGrille(L,C,N):- L > 3, L < 7, C < 4, N is 4, !.
indiceGrille(L,C,N):- L > 3, L < 7, C > 3, C < 7, N is 5, !.
indiceGrille(L,C,N):- L > 3, L < 7, C > 6, N is 6, !.

indiceGrille(L,C,N):- L > 6, C < 4, N is 7, !.
indiceGrille(L,C,N):- L > 6, C > 3, C < 7, N is 8, !.
indiceGrille(L,C,N):- L > 6, C > 6, N is 9, !.


%Test si Element dans liste
dansListe([_|Q], V) :- dansListe(Q, V), !.
dansListe([V|_], V).

%concatener
concat([], L, L).
concat([T|Q], L, [T|R]) :- concat(Q, L, R).

%unifier element en liste
unifie(X, [X]).

%Recuperer Element
recupererElement(L, I, R) :- recupererElement2(L,I,R).
recupererElement2([_|Q], I, R) :- recupererElement2(Q, J, R), I is J+1.
recupererElement2([T|_], 0, T).

%Recuperer Ligne
recupererLigne(G, NumLigne, Res) :- indice(NumLigne, 1, Indice), recupererLigne(G, Indice, Res, 9, Tmp), !.
recupererLigne([TG|QG], Indice, Res, Compteur, Tmp) :- Compteur > 0, Compteur1 is Compteur-1, recupererElement([TG|QG], Indice, X), concat(Tmp, [X], Res1), Indice1 is Indice+1, recupererLigne([TG|QG], Indice1, Res, Compteur1, Res1).
recupererLigne([TG|QG], _, Res, 0, Tmp) :- concat([], Tmp, Res), !.

%Recuperer Colonne
recupererCol(G, NumCol, Res) :- recupererCol(G, NumCol, Res, 9, Tmp), !.
recupererCol([TG|QG], NumCol, Res, Compteur, Tmp) :- Compteur > 0, Compteur1 is Compteur-1, indice(10-Compteur, NumCol, Indice), recupererElement([TG|QG], Indice, X), concat(Tmp, [X], Res1), recupererCol([TG|QG], NumCol, Res, Compteur1, Res1).
recupererCol([TG|QG], _, Res, 0, Tmp) :- concat([], Tmp, Res), !.

%Recuperer Grille 3x3
recupererGrille(NumGrille, Res,G) :- indiceGrille(L,C,NumGrille), La is L+1, Lb is L+2, recupererLigne(G, L, L1), recupererLigne(G, La, L2), recupererLigne(G, Lb, L3), recupererGrille(L1,L2,L3,C,Res), !.
recupererGrille(L1,L2,L3,C,Res) :- recupererGrille2(L1, C, Res1), recupererGrille2(L2, C, Res2), recupererGrille2(L3, C, Res3), concat(Res1, Res2, Res4), concat(Res4, Res3, Res).
recupererGrille2(L, C, Res) :- C1 is C-1, C2 is C+1, recupererElement(L, C1, R1), recupererElement(L, C, R2), recupererElement(L, C2, R3), unifie(R1, R11), unifie(R2, R22), unifie(R3, R33), concat(R11, R22, R4), concat(R4, R33, Res).

%Supprime Element
supprimeElement(A, ' ', A):- !.
supprimeElement(A, X, R) :- supprimeElement(A, X, L, R), !.
supprimeElement([X|Q], X, L, R) :- concat(L, Q, R), !.
supprimeElement([T|Q], X, L, R) :- concat(L, [T], C), supprimeElement(Q, X, C, R).


%Valider une Ligne
valideLigne(I,G) :- valideLigne(I, 8,G), !.
valideLigne(I, N,G) :- recupererLigne(G, I, Ligne), numero(NumPossible), recupererElement(Ligne, N, E),
          dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2), N1 is N-1, valideLigne(I, N1, Ligne, B2).
valideLigne(I, N, Ligne, NumPossible) :- recupererElement(Ligne, N, E), dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2),
          N1 is N-1, valideLigne(I, N1, Ligne, B2).
valideLigne(I, -1, Ligne, B):- !.

valideLigne2(I, G):- N is 8, recupererLigne(G, I, Ligne), numero(NumPossible), recupererElement(Ligne, N, E),
          dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2), N1 is N-1, valideLigne(I, N1, Ligne, B2), !.

%Valider une Colone
valideCol(I,G) :- valideCol(I, 8,G), !.
valideCol(I, N,G) :- recupererCol(G, I, Col), numero(NumPossible), recupererElement(Col, N, E),
          dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2), N1 is N-1, valideCol(I, N1, Col, B2).
valideCol(I, N, Col, NumPossible) :- recupererElement(Col, N, E), dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2),
          N1 is N-1, valideCol(I, N1, Col, B2).
valideCol(I, -1, Col, B):- !.

%Valider Grille 3x3
valideGrille(A2,G) :- recupererGrille(A2, R,G), valideLigne2(1, R).

%Valider Sudoku
valideToutesLignes(N,G) :- valideLigne(N,G), N1 is N-1, valideToutesLignes(N1,G).
valideToutesLignes(0,G).

valideToutesCols(N,G) :- valideCol(N,G), N1 is N-1, valideToutesCols(N1,G).
valideToutesCols(0, G).

valideToutesGrilles(0, G).
valideToutesGrilles(N, G) :- valideGrille(N, G), N1 is N-1, valideToutesGrilles(N1, G).


valideSudoku(0, G) :- valideToutesLignes(9, G), valideToutesCols(9, G), valideToutesGrilles(9, G).

%afficher Grille
afficherLigne([], _).
afficherLigne([T|Q], N):- N > 0, M is N-1, write(' '), write(T), write(' '), afficherLigne(Q, M).
afficherLigne(L, 0) :- write('|'), afficherLigne(L, 3).
afficherGrille(G) :- 	recupererLigne(G, 1, L1), afficherLigne(L1, 3), write('\n'),
			recupererLigne(G, 2, L2), afficherLigne(L2, 3), write('\n'),
			recupererLigne(G, 3, L3), afficherLigne(L3, 3), write('\n'),
			write('---------+---------+---------\n'),
			recupererLigne(G, 4, L4), afficherLigne(L4, 3), write('\n'),
			recupererLigne(G, 5, L5), afficherLigne(L5, 3), write('\n'),
			recupererLigne(G, 6, L6), afficherLigne(L6, 3), write('\n'),
			write('---------+---------+---------\n'),
			recupererLigne(G, 7, L7), afficherLigne(L7, 3), write('\n'),
			recupererLigne(G, 8, L8), afficherLigne(L8, 3), write('\n'),
      			recupererLigne(G, 9, L9), afficherLigne(L9, 3).

%remplacerElement
remplacerElement(E, S, L, C, V) :- indice(L, C, N), remplacerElement(E, S, N, V),!.
remplacerElement([_|Q], [V|Q], 0, V).
remplacerElement([T1|Q1], R, N, V):- concat([T1], Q, R), remplacerElement(Q1, Q, M, V), N is M+1.

%valide nouvelle element
valideAjout(G,N) :- indiceInverse(N,L,C), valideLigne(L,G), valideCol(C,G), indiceGrille(L,C,IndiceG), valideGrille(IndiceG,G),!.

%Generer Grille
generer(G, R, Compteur) :- random(0,10,V), random(0,10, L), random(0,10, C),  indice(L,C,N), remplacerElement(G, G1, L, C, V), unifie(N, N1),
      concat([], N1, ListeNonModifiable), Compteur1 is Compteur-1, random(0,81,N2), genererN(G1, R, ListeNonModifiable, Compteur1, N2).

genererN(G,R,ListeNonModifiable,0, N) :- concat([], G, R).
genererN(G,R,ListeNonModifiable,Compteur, N) :- dansListe(ListeNonModifiable, N), random(0,81,N1), genererN(G,R,ListeNonModifiable,Compteur,N1).
genererN(G,R,ListeNonModifiable,Compteur, N) :- \+dansListe(ListeNonModifiable, N), unifie(N,N1), concat(ListeNonModifiable, N1, ListeNonModifiable1),
      random(0,10,V), genererV(G,R,ListeNonModifiable1,Compteur, N, V).

genererV(G,R,ListeNonModifiable,Compteur, N, V) :- remplacerElement(G, G1, N, V), \+valideAjout(G1,N), random(0,10,V1),
        genererV(G,R,ListeNonModifiable,Compteur, N, V1).
genererV(G,R,ListeNonModifiable,Compteur, N, V) :- remplacerElement(G, G1, N, V), valideAjout(G1,N), Compteur1 is Compteur-1, random(0,81,N1),
        genererN(G1,R,ListeNonModifiable,Compteur1, N1).


%Liste des indices Non modifiables
unifieBS(' ').
trouverListeNonModifiable([T|Q], ListeNonModifiable) :- trouverListeNonModifiable([T|Q], ListeNonModifiable, []), !.
trouverListeNonModifiable([T|Q], ListeNonModifiable, L) :- unifieBS(T), trouverListeNonModifiable(Q, ListeNonModifiable, L),!.
trouverListeNonModifiable([T|Q], ListeNonModifiable, L) :- \+unifieBS(T), unifie(T, T1),concat(L, T1, ListeNonModifiable1),
      trouverListeNonModifiable(Q, ListeNonModifiable, ListeNonModifiable1),!.
trouverListeNonModifiable([], ListeNonModifiable, L):- concat([], L, ListeNonModifiable),!.

%Resoudre Grille TODO NON OPERATIONEL
resoudre(G,R) :- trouverListeNonModifiable(G, ListeNonModifiable), resoudre(G,R,ListeNonModifiable, 0).
resoudre(G,R,ListeNonModifiable, N) :- dansListe(ListeNonModifiable, N), N1 is N+1, resoudre(G,R,ListeNonModifiable,N1).
resoudre(G,R,ListeNonModifiable,N) :- \+dansListe(ListeNonModifiable,N), V is 1, resoudre(G,R,_,N,V).
resoudre(G,R,ListeNonModifiable, N, V) :- remplacerElement(G,G1, N, V), valideAjout(G1,N), N1 is N+1, resoudre(G1,R,ListeNonModifiable, N1).
resoudre(G,R,ListeNonModifiable, N,V) :- remplacerElement(G,G1, N, V), \+valideAjout(G1,N), V1 is V+1, resoudre(G,R,ListeNonModifiable, N,V1).
resoudre(G,R,_, 3) :- concat([], G, R).


%menu
%temporaire, à supprimer une fois programmés:
solve(_,_).

remplacementUtilisateur(G, R, L, C, V, LNM):- indice(L,C,N), \+(dansListe(LNM, N)), 
						valideAjout(G, N), remplacerElement(G, R, L, C, V).

jouer(G, LNM):- nl, afficherGrille(G),
			nl,
			write('Placement d\'une case\n\tNuméro de colonne: '), read(C),
			write('\tNuméro de ligne: '), read(L),
			write('\tValeur: '), read(V),
			remplacementUtilisateur(G, R, L, C, V, LNM),
			jouer(R, LNM).

menuDifficulte(2) :- grille(G), generer(G, R, 20), trouverListeNonModifiable(G, L), jouer(R, L).
menuDifficulte(1) :- grille(G), generer(G, R, 30), trouverListeNonModifiable(G, L), jouer(R, L).
menuDifficulte(_) :- menu(1).
menu(1) :- write('Difficulté? (1 ou 2)\n_> '), read(D), menuDifficulte(D).

demanderGrille(G) :- demanderGrille(G, 81).
demanderGrille([T|Q], N) :- read(T), demanderGrille(Q, M), M is N-1.
menu(2) :- demanderGrille(G), solve(G, R), nl, afficherGrille(R).

menu(_):-menu.
 menu :- write('Jeu du sudoku\n\t1 - Jouer\n\t2 - Résoudre une grille\n_> '), read(V), menu(V).
