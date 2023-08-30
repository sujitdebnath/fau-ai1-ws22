istree(tree(V, TS)) :-
    string(V),
    istreelist(TS).

istreelist([]).
istreelist([T|TS]) :-
    istree(T),
    istreelist(TS).


bfs(T) :-
    istree(T),
    bfs_tree([(T, 0)]).

bfs_tree([]).
bfs_tree([(tree(Root, Child_List), Depth)|Other_Pairs]) :-
    write(Depth), write(:), writeln(Root),
    New_Depth is Depth+1,
    create_pair(New_Depth, Child_List, Temp_Child_Pairs),
    append(Other_Pairs, Temp_Child_Pairs, New_Child_Pairs),
    bfs_tree(New_Child_Pairs).

create_pair(_, [], []).
create_pair(Val, [Head|Tail], [(Head, Val)|Tail_Need]) :-
    create_pair(Val, Tail, Tail_Need).


% Sample Query
% create_pair(0, ["A", "B", "C"], Result)
% append(["A", "B", "C"], ["D", "E"], Result)

/*tree("A",
     [tree("B",
           [tree("D",
                 [tree("F",
                       [tree("K",[]),
                        tree("L",[])])]),
            tree("E",[])]),
      tree("C",
           [tree("G",[]),
            tree("H",
                 [tree("I",[]),
                  tree("J",[])])])])*/
% tree("A",[tree("B",[tree("D",[tree("F",[tree("K",[]),tree("L",[])])]),tree("E",[])]),tree("C",[tree("G",[]),tree("H",[tree("I",[]),tree("J",[])])])])

/*tree("A",
     [tree("B",
           [tree("D",[]),
            tree("E",[])]),
      tree("C",[])])*/
% tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])])