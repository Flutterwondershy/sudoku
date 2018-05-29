grille([
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,9,
  1,2,3,4,5,6,7,8,9
  ]).
  numero([1,2,3,4,5,6,7,8,9]).
element(L,C, N):- N is (L-1) * 9 + C.

dansListe([V|Q], V).
dansListe([T|Q], V) :- dansListe(Q, V).

concat([], L, L).
concat([T|Q], L, [T|R]) :- concat(Q, L, R).

ajoutElement(L, X, [L|X]).

supprimeElement([X|Q], X, L) :- concat(Q, L, A).
supprimeElement([T|Q], X, L) :- concat(T, L, A), supprimeElement(Q, X, L).

%valideLigne([T|Q], C):-
