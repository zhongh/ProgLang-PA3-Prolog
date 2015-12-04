% Author: Hao Zhong

:- [read_line].

s(s(NP,VP)) --> np(NP),vp(VP),end.

np(np(DET,NOM)) --> det(DET),nom(NOM).

vp(vp(V))	--> verb(V).

det(det(a))	    -->  [a].
det(det(the))	    -->  [the].
det(det(every))	    -->  [every].

nom(nom(N))	--> noun(N).
noun(noun(bike))    -->  [bike].
noun(noun(train))   -->  [train].
noun(noun(person))  -->  [person].

verb(verb(arrived)) -->  [arrived].
verb(verb(flew))    -->  [flew].
verb(verb(stayed))  -->  [stayed].
verb(verb(left))    -->  [left].

end		--> ['.'].

loop :- read_line(X),
	s(Y, X, []),
	write(Y), nl,
	loop.
