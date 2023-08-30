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


itd(T) :-
    istree(T),
    itd_init(T,0),
    !.

itd_init(Tree, Cutoff_Depth) :-
    dfs_tree_upto_cutoff_depth(Tree , 0, Cutoff_Depth, Status),
    increase_itd_cutoff_depth(Tree, Cutoff_Depth, Status).

increase_itd_cutoff_depth(_, _, Status) :- Status=1.
increase_itd_cutoff_depth(Tree, Cutoff_Depth, Status) :-
    Status=0,
    New_Cutoff_Depth is Cutoff_Depth+1,
    itd_init(Tree, New_Cutoff_Depth).

dfs_tree_upto_cutoff_depth(_, Depth, Cutoff_Depth, Status) :-
    Depth > Cutoff_Depth,
    Status is 0.
dfs_tree_upto_cutoff_depth(tree(Root, Child_List), Depth, Cutoff_Depth, Status) :-
    write(Depth), write(:), writeln(Root),
    New_Depth is Depth+1,
    dfs_subtree_upto_cutoff(Child_List, New_Depth, Cutoff_Depth, Status).

dfs_subtree_upto_cutoff([], _, _, Status) :- Status is 1.
dfs_subtree_upto_cutoff([Child|Other_Childs], Depth, Cutoff_Depth, Status) :-
    dfs_tree_upto_cutoff_depth(Child, Depth, Cutoff_Depth, Status_Child),
    dfs_subtree_upto_cutoff(Other_Childs, Depth, Cutoff_Depth, Status_Other_Childs),
    Status is Status_Child*Status_Other_Childs.


% Sample Query
% dfs(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]))
% dfs(tree("A",[tree("B",[tree("D",[tree("F",[tree("K",[]),tree("L",[])])]),tree("E",[])]),tree("C",[tree("G",[]),tree("H",[tree("I",[]),tree("J",[])])])]))

% create_pair(0, ["A", "B", "C"], Result)
% append(["A", "B", "C"], ["D", "E"], Result)
% bfs(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]))
% bfs(tree("A",[tree("B",[tree("D",[tree("F",[tree("K",[]),tree("L",[])])]),tree("E",[])]),tree("C",[tree("G",[]),tree("H",[tree("I",[]),tree("J",[])])])]))

% dfs_tree_upto_cutoff_depth(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]), 0, 1, Status)
% itd(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]))
% itd(tree("A",[tree("B",[tree("D",[tree("F",[tree("K",[]),tree("L",[])])]),tree("E",[])]),tree("C",[tree("G",[]),tree("H",[tree("I",[]),tree("J",[])])])]))

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