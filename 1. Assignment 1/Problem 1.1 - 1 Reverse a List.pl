myAppendEnd([], Elem, [Elem]).
myAppendEnd([Head|Tail1], Elem, [Head|Tail2]) :-
    myAppendEnd(Tail1, Elem, Tail2).

myReverse([], []).
myReverse([Head|Tail], Result) :-
    myReverse(Tail, Temp_result),
    myAppendEnd(Temp_result, Head, Result).

% myReverse([1,2,3,4,2,5], R).
% myReverse([1,2], R).
% myReverse([1], R).
% myReverse([], R).