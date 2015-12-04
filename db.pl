% Author: Hao Zhong

:- [read_line].

/* Grammar */

% Upon receiving a statement of fact, input will be parsed into either positive_fact or negative fact.

positive_fact(positive_fact(NOUN,NAME,V)) -->
    definite_article(_),noun(NOUN),name(NAME),verb(V),end.
negative_fact(negative_fact(NOUN,NAME,V)) -->
    definite_article(_),noun(NOUN),name(NAME),auxiliary_verb(_),adverb(_),present_tense(verb(V)),end.

% Queries will be parsed to the fact items needed for evaluating the query.

query_a(positive_fact(NOUN,_,V))  -->
    auxiliary_verb(_),indefinite_article(_),noun(NOUN),present_tense(verb(V)),question.
query_every(negative_fact(NOUN,_,V),positive_fact(NOUN,_,V))  -->
    auxiliary_verb(_),every_article(_),noun(NOUN),present_tense(verb(V)),question.

% Some grammatical items:

definite_article(definite_article(the)) --> [the].
indefinite_article(indefinite_article(a)) --> [a].
every_article(every_article(a)) --> [every].

noun(bike)    -->  [bike].
noun(train)   -->  [train].
noun(person)  -->  [person].

name(N) --> [N].

auxiliary_verb(auxiliary_verb(did)) --> [did].

adverb(adverb(not)) --> [not].

verb(arrived) -->  [arrived].
verb(flew)    -->  [flew].
verb(stayed)  -->  [stayed].
verb(left)    -->  [left].

present_tense(verb(left)) --> [leave].
present_tense(verb(flew)) --> [fly].
present_tense(verb(arrived)) --> [arrive].
present_tense(verb(stayed)) --> [stay].

end		--> ['.'].

question --> ['?'].

/* Control */

% "a" query = existence of a positive fact

check_query_a(Y):- Y,!,write('yes'),nl.
check_query_a(_):- write('no'),nl.

% "every" query = denied with existence of a negative fact

check_query_every(NEG,_):- NEG,!,write('no'),nl.
check_query_every(_,_):- write('yes'),nl.

% Option to let "every" query return "yes" only when there exists
% positive instance(s):
% check_query_every(_,POS):- POS,!,write('yes'),nl.
% check_query_every(_,_):- write('no'),nl.

% Helper function "process(X)"
process(X):- positive_fact(Y,X,[]),!,assert(Y).
process(X):- negative_fact(Y,X,[]),!,assert(Y).
process(X):- query_a(Y,X,[]),check_query_a(Y).
process(X):- query_every(NEG,POS,X,[]),check_query_every(NEG,POS).%,write(NEG),write(POS).


loop :- read_line(X),
	process(X),
	loop.