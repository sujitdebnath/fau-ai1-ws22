zip([], [], []).
zip([], [_|_], []).
zip([_|_], [], []).
zip([Head1|Tail1], [Head2|Tail2], [[Head1, Head2]|Tail]):-
    zip(Tail1, Tail2, Tail).

% zip([1,2,3], [4,5,6], L).
% zip([1,2], [3,4,5], L).
% zip([1,2,3], [4,5], L).