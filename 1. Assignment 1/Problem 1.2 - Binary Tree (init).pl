add(Node, nil, tree(Node, nil, nil)).
add(Node, tree(Root, Left, Right), tree(Root, Left_add, Right)) :- Node < Root, add(Node, Left, Left_add).
add(Node, tree(Root, Left, Right), tree(Root, Left, Right_add)) :- Node > Root, add(Node, Right, Right_add).

constructTree([], Tree, Tree).
constructTree([Node|Nodes], Tree, Prev_tree) :-
    add(Node, Prev_tree, Temp_tree),
    constructTree(Nodes, Tree, Temp_tree).

construct(List, Tree) :- constructTree(List, Tree, nil).


count_nodes(nil, 0).
count_nodes(tree(_, Left, Right), Nodes_no) :-
    count_nodes(Left, Left_Nodes_no),
    count_nodes(Right, Right_Nodes_no),
    Nodes_no is Left_Nodes_no + Right_Nodes_no + 1.

count_leafs(nil, 0).
count_leafs(tree(_, nil, nil), 1).
count_leafs(tree(_, Left, Right), Leafs_no) :-
    (Left\=nil; Right\=nil),
    count_leafs(Left, Left_leafs_no),
    count_leafs(Right, Right_leafs_no),
    Leafs_no is Left_leafs_no + Right_leafs_no.


isMirror(nil, nil).
isMirror(tree(Root1, Left1, Right1), tree(Root2, Left2, Right2)) :-
    Root1==Root2,
    isMirror(Left1, Right2),
    isMirror(Right1, Left2).

symmetric(nil).
symmetric(tree(_, Left, Right)) :- isMirror(Left, Right).


% add(5, nil, T).
% add(5, tree(8, nil, nil), T).
% add(9, tree(8, nil, nil), T).
% construct([3,2,4,1,5],T).
% count_nodes(tree(3,tree(2,tree(1,nil,nil),nil),tree(4,nil,tree(5,nil,nil))), Nodes_no).
% count_leafs(tree(3,tree(2,tree(1,nil,nil),nil),tree(4,nil,tree(5,nil,nil))), Leafs_no).

% Symmetric Tree Ref: https://www.baeldung.com/cs/binary-tree-is-symmetric#:~:text=2.,reflection%20of%20the%20right%20subtree.
% symmetric(nil).
% symmetric(tree(5, nil, nil)).
/*tree(3,
     tree(2,
          tree(3,nil,nil),
          tree(4,nil,nil)),
     tree(2,
          tree(4,nil,nil),
          tree(3,nil,nil)))*/
% symmetric(tree(3,tree(2,tree(3,nil,nil),tree(4,nil,nil)),tree(2,tree(4,nil,nil),tree(3,nil,nil)))). [True]
/*tree(3,
     tree(2,
          tree(3,nil,nil),
          tree(4,nil,nil)),
     tree(2,
          tree(3,nil,nil),
          tree(4,nil,nil)))*/
% symmetric(tree(3,tree(2,tree(3,nil,nil),tree(4,nil,nil)),tree(2,tree(3,nil,nil),tree(4,nil,nil)))). [False]