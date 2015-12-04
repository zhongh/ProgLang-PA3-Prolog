
% This allows you to load the program read_line.pl
% This will allow you to use the read_line predicate in your source file.
:- [read_line].

% This is the top-level term for this toy grammar.
% Note that the the period is also captured when using read_line so
% we account for this by capturing the period in the grammar using the 
% end term.
% This rule also introduces the capture of input through our X variable.
word(X) --> noun(X),end.
% This is an example of adding extra info to the captured input.
% In this case, we are adding the extra info that this word is a noun by
% using the n predicate.
noun(n(toy)) --> [toy].
noun(n(car)) --> [car].
end --> ['.'].

% Below are two ways of parsing input using your grammar.

% The first way exposes what Prolog does behind the scenes when you 
% use the Definite Clause Grammar (DCG) syntax.
% Full understanding of how DCG syntax is converted into Prolog requires
% understanding of accumulators and difference lists, but full understanding
% is not required to solve this homework. 
% parse(Tree,Sentence) :- word(Tree,Sentence,[]).

% This second rule relies on a built in predicate 'phrase' to work with 
% the DCG syntax. The phrase predicate hides the details of how DCG is 
% converted into Prolog.
parse(Tree,Sentence) :- phrase(word(Tree),Sentence).

% This predicate reads the user input, parses it to see if it is accepted 
% by the grammar, and outputs the resulting parse tree if the grammar is
% accepted.
check_input :- read_line(Sent),parse(Tree,Sent),write(Tree).
