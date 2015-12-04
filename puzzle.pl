% Author: Hao Zhong

puzzle([A,B,C,D,E,F,G,H,I]) :-
	lists:perm([A,B,C,D,E,F,G,H,I],[1,2,3,4,5,6,7,8,9]),
	ABD is A+B+D,
	ACF is A+C+F,
	DEF is D+E+F,
	DGI is D+G+I,
	FHI is F+H+I,
	ABD = 17,
	ABD = ACF,
	ACF = DEF,
	DEF = DGI,
	DGI = FHI.