grille([
  1,2,3, ' ',5,6,7,8,2,
  2,3,3,' ',5,6,7,8,8,
  3,2,' ',5,5,8,5,8,6,
  4,' ',3,4,5,6,6,8,8,
  ' ',2,2,5,7,6,6,8,7,
  6,2,' ',5,5,7,7,8,6,
  7,2,2,4,' ',6,8,8,6,
  8,2,3,4,5,5,' ',9,9,
  9,2,3,4,5,6,6,7,' '
  ]).

numero([1,2,3,4,5,6,7,8,9]) :- !.

%Recupere l indice de la liste
indice(L,C, N):- N is (L-1) * 9 + C-1.

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
recupererGrille(NumGrille, Res) :- grille(G), indiceGrille(L,C,NumGrille), recupererLigne(G, L, L1), recupererLigne(G, L+1, L2), recupererLigne(G, L+2, L3), recupererGrille(L1,L2,L3,C,Res).
recupererGrille(L1,L2,L3,C,Res) :- recupererGrille2(L1, C, Res1), recupererGrille2(L2, C, Res2), recupererGrille2(L3, C, Res3), concat(Res1, Res2, Res4), concat(Res4, Res3, Res).
recupererGrille2(L, C, Res) :- C1 is C-1, C2 is C+1, recupererElement(L, C1, R1), recupererElement(L, C, R2), recupererElement(L, C2, R3), unifie(R1, R11), unifie(R2, R22), unifie(R3, R33), concat(R11, R22, R4), concat(R4, R33, Res).

%Supprime Element
supprimeElement(A, X, R) :- supprimeElement(A, X, L, R), !.
supprimeElement([X|Q], X, L, R) :- concat(L, Q, R), !.
supprimeElement([T|Q], X, L, R) :- concat(L, [T], C), supprimeElement(Q, X, C, R).


%Valider une Ligne
valideLigne(I) :- valideLigne(I, 8), !.
valideLigne(I, N) :- grille(G), recupererLigne(G, I, Ligne), numero(NumPossible), recupererElement(Ligne, N, E),
          dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2), N1 is N-1, valideLigne(I, N1, Ligne, B2).
valideLigne(I, N, Ligne, NumPossible) :- recupererElement(Ligne, N, E), dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2),
          N1 is N-1, valideLigne(I, N1, Ligne, B2).
valideLigne(I, 0, Ligne, B):- !.

%Valider une Colone
valideCol(I) :- valideCol(I, 8), !.
valideCol(I, N) :- grille(G), recupererCol(G, I, Col), numero(NumPossible), recupererElement(Col, N, E),
          dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2), N1 is N-1, valideCol(I, N1, Col, B2).
valideCol(I, N, Col, NumPossible) :- recupererElement(Col, N, E), dansListe(NumPossible, E), supprimeElement(NumPossible, E, B2),
          N1 is N-1, valideCol(I, N1, Col, B2).
valideCol(I, 0, Col, B):- !.

%Valider Grille 3x3 TODO


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
remplacerElement(E, S, L, C, V) :- indice(L, C, N), remplacerElement(E, S, N, V).
remplacerElement([_|Q], [V|Q], 0, V).
remplacerElement([T1|Q1], R, N, V):- concat([T1], Q, R), remplacerElement(Q1, Q, M, V), N is M+1.
