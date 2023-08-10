delete(_, [], []).
delete(Elem, [Elem|Tail], Result) :-
    delete(Elem, Tail, Result).
delete(Elem, [Head|Tail1], [Head|Tail2]) :-
    Elem\=Head,
    delete(Elem, Tail1, Tail2).

removeDuplicates([], []).
removeDuplicates([Head|Tail1], [Head|Tail2]) :-
    delete(Head, Tail1, Temp_list),
    removeDuplicates(Temp_list, Tail2).

% delete(4, [1,2,4,4,3,4,5,4,6], Result).
% removeDuplicates([1,1,1,1,2,2,3,4,1,2,7], A).