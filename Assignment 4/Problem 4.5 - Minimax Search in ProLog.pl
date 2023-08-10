% Game state: number N of remaining matches, current player P=1 or P=-1

% contains(L, A): checks whether A is a element of List L or not
contains([H|T], A) :- not(H=A), contains(T, A).
contains([A|_], A).

% possible moves in state(N, P) yielding successor state T
successor(state(N, P), T) :- N>0, N2 is N-1, P2 is -P, T=state(N2, P2).
successor(state(N, P), T) :- N>1, N2 is N-2, P2 is -P, T=state(N2, P2).
successor(state(N, P), T) :- N>2, N2 is N-3, P2 is -P, T=state(N2, P2).

% find list Ts of successor states of S using accumulator Acc
successors(S, Acc, Ts) :- successor(S, T), \+ contains(Acc, T), !, successors(S, [T|Acc], Ts).
successors(_, Acc, Acc).

% minvalue(Ss, MinSofar, V): returns minimum value V of list of states Ss
% where MinSofar is accumulator for minimum value seen so far
minvalue([], MinSofar, MinSofar).
minvalue([S|Ss], MinSofar, V) :- value(S, V1), V1<MinSofar, minvalue(Ss, V1, V).
minvalue([S|Ss], MinSofar, V) :- value(S, V1), V1>=MinSofar, minvalue(Ss, MinSofar, V).

% maxvalue(Ss, MaxSofar, V): returns maximum value V of list of states Ss
% where MaxSofar is accumulator for maximum value seen so far
maxvalue([], MaxSofar, MaxSofar).
maxvalue([S|Ss], MaxSofar, V) :- value(S, V1), V1>=MaxSofar, maxvalue(Ss, V1, V).
maxvalue([S|Ss], MaxSofar, V) :- value(S, V1), V1<MaxSofar, maxvalue(Ss, MaxSofar, V).

% value(S, V): returns winner V (1 or -1) given the initial state S
% step 1: (P=1)'s turn, here choose successor with maximum value
% step 2: (P=-1)'s turn, here choose successor with minimum value
value(S, V) :- state(_, P)=S, P = 1, successors(S, [], Ts), maxvalue(Ts, -1, V).
value(S, V) :- state(_, P)=S, P = -1, successors(S, [], Ts), minvalue(Ts, 1, V).

%--------------------------- Sample Query ---------------------------
% contains([1,2,3,4,5], 3)
% contains([1,2,3,4,5], 6)

% successor(state(4,1), T)
% successor(state(4,-1), T)

% successors(state(4, 1), [], T)
% successors(state(3, -1), [], T)

% value(state(4, 1), Player)
% value(state(5, 1), Player)