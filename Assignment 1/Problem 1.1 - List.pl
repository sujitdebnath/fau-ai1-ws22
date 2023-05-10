% Task 1 - Reverse a List
% If the list is empty, it will append the element in the resultant list
myAppendEnd([], Elem, [Elem]).
% For non-empty list, it will append the head in resultant list
% and then try to append element in the end
myAppendEnd([Head|Tail1], Elem, [Head|Tail2]) :-
    myAppendEnd(Tail1, Elem, Tail2).

% If list is empty, reverse list will also be empty
myReverse([], []).
% For non-empty list with head and tail, reverse the tail first
% and then append the head in the last
myReverse([Head|Tail], Result) :-
    myReverse(Tail, Temp_result),
    myAppendEnd(Temp_result, Head, Result).


% Task 2 - Remove Multiple Occurrences in a List
% If list is empty, resultant list will also be empty
delete(_, [], []).
% If the element found in the head of the list, skip the element
% and further delete the element from the tail
delete(Elem, [Elem|Tail], Result) :-
    delete(Elem, Tail, Result).
% If the element is not found in the head of the list,
% append the head in the resultant list
% and delete the element from the tail of the list
delete(Elem, [Head|Tail1], [Head|Tail2]) :-
    Elem\=Head,
    delete(Elem, Tail1, Tail2).

% If list is empty, resultant list will be also empty
removeDuplicates([], []).
% For non-empty list, append the head in the resultant list
% and delete all the head elements from the tail,
% then further remove other duplicate values
removeDuplicates([Head|Tail1], [Head|Tail2]) :-
    delete(Head, Tail1, Temp_list),
    removeDuplicates(Temp_list, Tail2).


% Task 3 - Zipping Two Lists
% If two list or any of them is empty, zipped list will be also empty
zip([], [], []).
zip([], [_|_], []).
zip([_|_], [], []).
% If both of the list is non-empty, zipped the two heads
% and append at the front of the resultant list,
% then further zipped tail of the two list
zip([Head1|Tail1], [Head2|Tail2], [[Head1, Head2]|Tail]):-
    zip(Tail1, Tail2, Tail).


% Task 4 - Permutations of a List
% If element found in the head of the list, tail will be the resultant list
takeout(Elem, [Elem|Tail], Tail).
% If element is not found in the head of the list, append the head in the resultant list
% and take out the element from the tail of the list
takeout(Elem, [Head|Tail1], [Head|Tail2]) :-
    Elem\=Head,
    takeout(Elem, Tail1, Tail2).

% If the list is empty, permutation list will be also empty
myPermutations([], []).
% For non-empty list, find the permutation of tail first
% then combine the head with it using the takeout predicates
myPermutations([Head|Tail], Result) :-
    myPermutations(Tail, Temp_list),
    takeout(Head, Result, Temp_list).
