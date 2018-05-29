%TODO: Génération de grille
grille(L) :- append(
			[
				[1, 2, 3, 4, 5, 6, 7, 8, 9],
				[2, 2, 3, 4, 5, 6, 7, 8, 9],
				[3, 2, 3, 4, 5, 6, 7, 8, 9],
				[4, 2, 3, 4, 5, 6, 7, 8, 9],
				[5, 2, 3, 4, 5, 6, 7, 8, 9],
				[6, 2, 3, 4, 5, 6, 7, 8, 9],
				[7, 2, 3, 4, 5, 6, 7, 8, 9],
				[8, 2, 3, 4, 5, 6, 7, 8, 9],
				[9, 2, 3, 4, 5, 6, 7, 8, 9]
			]
			, [], L).

		
%Nième ligne de la grille [L|Q]
ligne([L|_], 0, L).
ligne([_|Q], N, L) :- N2 is N-1, ligne(Q, N2, L).

%Nième élément de la ligne [T|Q] dans R
elementLigne([T|_], 0, T).
elementLigne([_|Q], N, R) :- N2 is N-1, elementLigne(Q, N2, R).

%élément de coordonnées (X, Y) dans G
element(G, X, Y, R) :- ligne(G, Y, L), elementLigne(L, X, R).


sousGrille2(G, X, Y, R) :- element(G, X1, Y1, A),
			  element(G, X1, Y, B),
			  element(G, X1, Y2, C),
			  element(G, X, Y1, D),
			  element(G, X, Y, E),
			  element(G, X, Y2, F),
			  element(G, X2, Y1, G),
			  element(G, X2, Y, H),
			  element(G, X2, Y2, I),
			  append([A, B, C, D, E, F, G, H, I], [], R),
			  X1 is X-1,
			  X2 is X+1,
			  Y1 is Y-1,
			  Y2 is Y-2.

sousGrille(G, X, Y, R) :- sousGrille2(G, A, B, R), A is 3*X+1, B is 3*Y+1.
