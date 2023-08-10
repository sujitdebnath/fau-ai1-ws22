istree(tree(V, TS)) :-
    string(V),
    istreelist(TS).

istreelist([]).
istreelist([T|TS]) :-
    istree(T),
    istreelist(TS).


dfs(T) :-
    istree(T),
    dfs_tree(T,0).

dfs_tree(tree(Root, Child_List), Depth) :-
    write(Depth), write(:), writeln(Root),
    New_Depth is Depth+1,
    dfs_subtree(Child_List, New_Depth).

dfs_subtree([], _).
dfs_subtree([Child|Other_Childs], Depth) :-
    dfs_tree(Child, Depth),
    dfs_subtree(Other_Childs, Depth).


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
           [tree("D",[])]),
      tree("C",[])])*/
% tree("A",[tree("B",[tree("D",[])]),tree("C",[])])