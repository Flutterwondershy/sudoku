grille([
  1,2,3,4,5,6,7,8,2,
  1,3,3,4,5,6,7,8,8,
  1,2,4,5,5,8,5,8,6,
  1,2,3,4,5,6,6,8,8,
  1,2,2,5,7,6,6,8,7,
  1,2,3,5,5,7,7,8,6,
  1,2,2,4,5,6,8,8,6,
  1,2,3,4,5,5,7,9,9,
  1,2,3,4,5,6,6,7,8
  ]).

numero([1,2,3,4,5,6,7,8,9]).

%Recupere l indice de la liste
indice(L,C, N):- N is (L-1) * 9 + C.



%Test si Element dans liste
dansListe([V|_], V).
dansListe([_|Q], V) :- dansListe(Q, V).

%concatener
concat([], L, L).
concat([T|Q], L, [T|R]) :- concat(Q, L, R).

%ajouter Element
ajoutElement(L, X, [X|L]).

recupererElement([T|_], 0, T).
recupererElement([_|Q], I, R) :- recupererElement(Q, J, R), I is J+1.

recupererElementGrille(G, L, C, R) :- indice(L, C, I), recupererElement(G, I, R).

%Supprime Tete jusqu a Taille
raccourcirTete(L, L, 0).
raccourcirTete(R, [_|Q], Taille) :- raccourcirTete(R, Q, Taille2), Taille is Taille2 +1.

%Recuperer Ligne
recupererLigne([], _, _, 0).
recupererLigne(R, 0, [T|Q], Taille) :- recupererLigne(L2, 0, Q, TailleM1), concat([T], L2, R), Taille is TailleM1+1.
recupererLigne(L, I, G, Taille) :- raccourcirTete(G2, G, Taille), recupererLigne(L, J, G2, Taille), I is J+1.
recupererLigne(L, I, G) :- recupererLigne(L, I, G, 9).

%Recuperer Colonne TODO
recupererColonne([], _, _, 0, _).
recupererColonne([E|R], I, G, Taille, J) :- recupererElementGrille(G, I, J, E), recupererColonne(R, I, G, Taille2, J2), J is J2+1, Taille is Taille2+1.
recupererColonne(C, I, G, Taille) :- recupererColonne(C, I, G, Taille, 0).
recupererColonne(C, I, G) :- recupererColonne(C, I, G, 9, 0).

%valideLigne([T|Q], C):-

%Supprime Element
supprimeElement([T|Q], X, L, R) :- ajoutElement(L, T, C), supprimeElement(Q, X, C, R).
supprimeElement([X|Q], X, L, R) :- concat(L, Q, R), !.

valideLigne(I) :- recupererLigne(R, I, A), numero(B), element()
