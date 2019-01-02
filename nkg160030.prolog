/*
 * Naman Gangwani
 * nkg160030
 * CS 4337.001
 * April 13, 2018
 */

% 1) Odd Multiple of 3
oddMultOf3(N) :-
	integer(N) ->
	X is N mod 3, Y is N mod 2, X = 0, Y = 1;
	display("ERROR: The given parameter is not an integer").

% 2) List Product
list_prod(List, Number) :-
	List = [] ->  Number = 0;
	List = [H | T],
	(T = [] ->  Number = H;
	list_prod(T, Product2), Number is H * Product2).

% 3) Palindrome
palindrome(List) :-
	reverse(List, List).

% 4) Second Minimum
secondMin(List, Min2) :-
	sort(List, Sorted),
	length(Sorted, L), L < 2 ->
	     display("ERROR: List has fewer than two unique elements"), false;
	isNumberList(List, X), not(number(X)) ->
	     display("ERROR: \""), display(X),
	     display("\" is not a number."), false;
	getSecondMin(List, Min2).

isNumberList([H | T], X) :-
	T = [] -> X = H, true;
	not(number(H)) -> X = H, true;
	isNumberList(T, X), true.

getSecondMin(List, Min2) :-
	sort(List, X),
	X = [H1, H2 | T],
	(not(H1 = H2) -> Min2 = H2;
	secondMin(T, Min3) -> Min2 = Min3).

% 5) Segregate
segregate(List, Even, Odd) :-
	even(List, [], Even),
	odd(List, [], Odd).

even(List, L, Final) :-
	List = [] -> !, Final = L;
	List = [H | T],
       (0 is H mod 2 ->
       (append(L, [H], X),
	even(T, X, Final));
        even(T, L, Final)).

odd(List, L, Final) :-
	List = [] -> !, Final = L;
	List = [H | T],
       (1 is H mod 2 ->
        append(L, [H], X),
	odd(T, X, Final);
        odd(T, L, Final)).

% 6) Bookends
bookends(List1, List2, List3) :-
	not(List1 = []), List3 = [] -> false;
	not(List2 = []), List3 = [] -> false;
	List1 = [], List2 = [], List3 = [] -> true;
	List3 = [H3 | T3],
       (List1 = [] -> true;
        List1 = [H1 | T1], H1 = H3, bookends(T1, [], T3)),
       (List2 = [] -> true;
        reverse(List2, [H4 | T4]), reverse(List3, [H5 | T5]),
	H4 = H5, reverse(T4, L2), reverse(T5, L3),
	bookends([], L2, L3)).

% 7) Subslice
subslice(List1, List2) :-
	append(_, X, List2), append(List1, _, X), !.

% 8) Shift
shift(List, Integer, Shifted) :-
	Integer = 0 -> !, Shifted = List;
        Integer < 0 ->
       (reverse(List, R),
	shiftHelper(R, L),
	X is Integer + 1,
	reverse(L, O),
	shift(O, X, Shifted));
       (shiftHelper(List, L),
	X is Integer - 1,
	shift(L, X, Shifted)).

shiftHelper(List, L2) :-
       (List = [H | T], append(T, [H], L2)).

%) 9) Luhn Algorithm
luhn(N) :-
	splitAndReverse(N, List),
	doubleOddIndices(List, [], 0, L2),
	list_sum(L2, X),
	0 is X mod 10 -> true; false.

splitAndReverse(N, List) :-
	N = 0 -> List = [];
	List = [H | T],
       (N1 is floor(N/10),
	H is N mod 10,
	splitAndReverse(N1, T)).

doubleOddIndices(L1, L2, N, Final) :-
	L1 = [] -> Final = L2;
	L1 = [H | T],
       (1 is N mod 2 ->
         N1 is H * 2,
	(N1 > 9 -> N2 is N1 - 9; N2 is N1),
	 append(L2, [N2], X),
	 Y is N + 1,
	 doubleOddIndices(T, X, Y, Final);
         append(L2, [H], X),
	 Y is N + 1,
	 doubleOddIndices(T, X, Y, Final)).

list_sum(List, Number) :-
	List = [] ->  Number = 0;
	List = [H | T],
       (T = [] ->  Number = H;
	list_sum(T, Sum2), Number is H + Sum2).

% 10) Genealogy
mother(X, Y) :-
	female(X), parent(X, Y).

father(X, Y) :-
	male(X), parent(X, Y).

child(X, Y) :-
	parent(Y, X).

sibling(X, Y) :-
	setof((X, Y),
	      P^(parent(P, X), parent(P, Y), \+X = Y),
	      Siblings),
	member((X, Y), Siblings),
               \+ (Y @> X, member((Y, X), Siblings)).

grandparent(X, Y) :-
	parent(P, Y), child(C, X), P = C.

grandmother(X, Y) :-
	female(X), grandparent(X, Y).

grandfather(X, Y) :-
	male(X), grandparent(X, Y).

grandchild(X, Y) :-
	grandparent(Y, X).

grandson(X, Y) :-
	male(X), grandchild(X, Y).

granddaughter(X, Y) :-
	female(X), grandchild(X, Y).

uncle(X, Y) :-
	male(X), sibling(X, S), parent(S, Y).

aunt(X, Y) :-
	female(X), sibling(X, S), parent(S, Y).
cousin(X, Y) :-
	setof((X, Y),
	      (P1, P2)^(parent(P1, X),
			parent(P2, Y),
			sibling(P1, P2),
			\+X = Y),
	      Cousins),
	member((X, Y), Cousins),
               \+ (Y @< X, member((Y, X), Cousins)).

ancestor(X, Y) :-
	parent(X, Y);
	parent(X, S), ancestor(S, Y).

decendant(X, Y) :-
	ancestor(Y, X).

% Knowledge Base
male(adam).
male(bob).
male(brett).
male(charles).
male(chris).
male(clay).
female(ava).
female(barbara).
female(betty).
female(colette).
female(carrie).
female(jenny).
parent(adam,bob).
parent(adam,barbara).
parent(ava,bob).
parent(ava,barbara).
parent(bob,clay).
parent(barbara,colette).































