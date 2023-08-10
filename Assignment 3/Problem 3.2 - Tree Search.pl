%--------------------------- istree start ---------------------------
% tree(V,TS) represents a tree, where
% V = a string (label/value V of the root node)
% TS = a list of trees (the children/subtrees of the root node)
% istree(T) checks whether T is a tree
istree(tree(V, TS)) :-
    string(V),
    istreelist(TS).

% istreelist(TS) true if TS is a list of trees
istreelist([]).
istreelist([T|TS]) :-
    istree(T),
    istreelist(TS).
%--------------------------- istree end ---------------------------

%--------------------------- dfs start ---------------------------
% dfs(T) visits every node in depth-first order, if T is a tree
% dfs(T) called dfs_tree with T and initial depth 0
dfs(T) :-
    istree(T),
    dfs_tree(T, 0).

% dfs_tree(Tree, Depth) : prints current Depth and Root value, increase the depth by 1
% and search all the children of the current node with new depth
dfs_tree(tree(Root, Child_List), Depth) :-
    write(Depth), write(:), writeln(Root),
    New_Depth is Depth+1,
    dfs_subtree(Child_List, New_Depth).

% dfs_subtree(Child_List, Depth) : call dfs_tree on each child/subtree of the Child_List
dfs_subtree([], _).
dfs_subtree([Child|Other_Childs], Depth) :-
    dfs_tree(Child, Depth),
    dfs_subtree(Other_Childs, Depth).
%--------------------------- dfs end ---------------------------

%--------------------------- bfs start ---------------------------
% bfs(T) visits every node in beadth-first order, if T is a tree
% bfs(T) called bfs_tree with a list containing the pair T and initial depth 0
bfs(T) :-
    istree(T),
    bfs_tree([(T, 0)]).

% bfs_tree([(Tree, Depth),...]) : takes the first pair, and do the followings,
% - prints current Depth and Root value
% - increase the depth by 1
% - create a list of pairs with New_Depth and Child_List of the root node
% - append the list of pairs in the end of Other_Pairs
% - call bfs_tree with new list of pairs
bfs_tree([]).
bfs_tree([(tree(Root, Child_List), Depth)|Other_Pairs]) :-
    write(Depth), write(:), writeln(Root),
    New_Depth is Depth+1,
    create_pair(New_Depth, Child_List, Temp_Child_Pairs),
    append(Other_Pairs, Temp_Child_Pairs, New_Child_Pairs),
    bfs_tree(New_Child_Pairs).

% create_pair(Val, List, Result_list) : pair Val with each element of List and return Result_list
create_pair(_, [], []).
create_pair(Val, [Head|Tail], [(Head, Val)|Tail_Need]) :-
    create_pair(Val, Tail, Tail_Need).
%--------------------------- bfs end ---------------------------

%--------------------------- itd start ---------------------------
% itd(T) visits every node in iterative deepening order, if T is a tree
% itd(T) call itd_init with T and initial cutoff depth 0
itd(T) :-
    istree(T),
    itd_init(T, 0),
    !.

% itd_init(Tree, Cutoff_Depth) : calls dfs_tree_upto_cutoff_depth with
% Tree, initial depth 0, cut off depth, and status which need to be find out
% if status is 0, it calls increase_itd_cutoff_depth to increase the cut off depth by 1 
itd_init(Tree, Cutoff_Depth) :-
    dfs_tree_upto_cutoff_depth(Tree , 0, Cutoff_Depth, Status),
    increase_itd_cutoff_depth(Tree, Cutoff_Depth, Status).

% Depending on the status, increase_itd_cutoff_depth will increase the cut off depth
% and call itd_init with new cut off depth
increase_itd_cutoff_depth(_, _, Status) :- Status=1.
increase_itd_cutoff_depth(Tree, Cutoff_Depth, Status) :-
    Status=0,
    New_Cutoff_Depth is Cutoff_Depth+1,
    itd_init(Tree, New_Cutoff_Depth).

% dfs_tree_upto_cutoff_depth(Tree, Depth, Cutoff_Depth, Status) : it is basically a dfs,
% which will apply dfs upto the cutoff depth, and
% return status 1 if there is no more subtree to the explore, otherwise return 0 
dfs_tree_upto_cutoff_depth(_, Depth, Cutoff_Depth, Status) :-
    Depth > Cutoff_Depth,
    Status is 0.
dfs_tree_upto_cutoff_depth(tree(Root, Child_List), Depth, Cutoff_Depth, Status) :-
    write(Depth), write(:), writeln(Root),
    New_Depth is Depth+1,
    dfs_subtree_upto_cutoff(Child_List, New_Depth, Cutoff_Depth, Status).

% dfs_subtree_upto_cutoff(Child_list, Depth, Cutoff_Depth, Status) : it calls dfs_tree_upto_cutoff_depth
% on each element of Child_list, and returns 1 after exploring all the child/subtree
dfs_subtree_upto_cutoff([], _, _, Status) :- Status is 1.
dfs_subtree_upto_cutoff([Child|Other_Childs], Depth, Cutoff_Depth, Status) :-
    dfs_tree_upto_cutoff_depth(Child, Depth, Cutoff_Depth, Status_Child),
    dfs_subtree_upto_cutoff(Other_Childs, Depth, Cutoff_Depth, Status_Other_Childs),
    Status is Status_Child*Status_Other_Childs.
%--------------------------- itd end ---------------------------

%--------------------------- Sample Query ---------------------------
% istree(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]))
% istree(tree("A",[tree("B",[tree("D",[tree("F",[tree("K",[]),tree("L",[])])]),tree("E",[])]),tree("C",[tree("G",[]),tree("H",[tree("I",[]),tree("J",[])])])]))

% dfs(tree("A",[tree("B",[])]))
% dfs(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]))
% dfs(tree("A",[tree("B",[tree("D",[tree("F",[tree("K",[]),tree("L",[])])]),tree("E",[])]),tree("C",[tree("G",[]),tree("H",[tree("I",[]),tree("J",[])])])]))

% create_pair(0, ["A", "B", "C"], Result)
% append(["A", "B", "C"], ["D", "E"], Result)
% bfs(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]))
% bfs(tree("A",[tree("B",[tree("D",[tree("F",[tree("K",[]),tree("L",[])])]),tree("E",[])]),tree("C",[tree("G",[]),tree("H",[tree("I",[]),tree("J",[])])])]))

% dfs_tree_upto_cutoff_depth(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]), 0, 1, Status)
% itd(tree("A",[tree("B",[tree("D",[]),tree("E",[])]),tree("C",[])]))
% itd(tree("A",[tree("B",[tree("D",[tree("F",[tree("K",[]),tree("L",[])])]),tree("E",[])]),tree("C",[tree("G",[]),tree("H",[tree("I",[]),tree("J",[])])])]))