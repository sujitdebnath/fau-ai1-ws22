% tree(V,TS) represents a tree.
% V must be a string - the label/value/data V of the root node
% TS must be a list of trees - the children/subtrees of the root node
% In particular, a leaf node is a tree with the empty list of children
istree(tree(V, TS)) :- string(V), istreelist(TS).
% istreelist(TS) holds if TS is a list of trees.
% Note that the children are a list not a set, i.e., they are ordered.
istreelist([]).
istreelist([T|TS]) :- istree(T), istreelist(TS).

% The following predicates define search algorithms that take a tree T
% and visit every node each time writing out the line D:L where
% * D is the depth (starting at 0 for the root)
% * L is the label
% dfs(T) visits every node in depth-first order
dfs(T) :-
    istree(T),
    dfs_tree(T, 0).

dfs_tree([], _).
dfs_tree(tree(Root, []), Depth) :-
    write(Depth), write(:), writeln(Root).
dfs_tree([Child|Other_Childs], Depth) :-
    dfs_tree(Child, Depth),
    dfs_tree(Other_Childs, Depth).
dfs_tree(tree(Root, [Child|Other_Childs]), Depth) :-
    write(Depth), write(:), writeln(Root),
    New_Depth is Depth+1,
    dfs_tree(Child, New_Depth),
    dfs_tree(Other_Childs, New_Depth).

% bfs(T) visits every node in beadth-first order
bfs(T) :-
    bfs_tree(T, 0).

bfs_tree([], _).
bfs_tree(tree(Root, []), Depth) :-
    write(Depth), write(:), writeln(Root).
bfs_tree([tree(Root, _)|Other_Childs], Depth) :-
    write(Depth), write(:), writeln(Root),
    bfs_tree(Other_Childs, Depth).
bfs_tree(tree(Root, [Child|Other_Childs]), Depth) :-
    write(Depth), write(:), writeln(Root),
    New_Depth is Depth+1,
    bfs_tree([Child|Other_Childs], New_Depth),
    bfs_tree(Child, New_Depth).

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