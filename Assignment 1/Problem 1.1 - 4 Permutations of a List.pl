takeout(Elem, [Elem|Tail], Tail).
takeout(Elem, [Head|Tail1], [Head|Tail2]) :-
    Elem\=Head,
    takeout(Elem, Tail1, Tail2).

myPermutations([], []).
myPermutations([Head|Tail], Result) :-
    myPermutations(Tail, Temp_list),
    takeout(Head, Result, Temp_list).

% takeout(1, [2,3,1,2,1], R).
% takeout(1, R, [2,3]).
% myPermutations([1,2,3], P).