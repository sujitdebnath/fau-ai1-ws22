% Task 1 - Construct the binary tree out of a list
% If the tree is nil, add the new node to root of the binary tree
add(Node, nil, tree(Node, nil, nil)).
% If the node is less than the root, add the new node to the left side of the binary tree
add(Node, tree(Root, Left, Right), tree(Root, Left_add, Right)) :-
    Node < Root,
    add(Node, Left, Left_add).
% If the node is greater than the root, add the new node to the right side of the binary tree
add(Node, tree(Root, Left, Right), tree(Root, Left, Right_add)) :-
    Node > Root,
    add(Node, Right, Right_add).

% If the list is empty, resultant tree will be the previous tree
constructTree([], Tree, Tree).
% Extract the node (head of the list) one by one from the list, add the node to the previous tree,
% then further construct the trees using others remaining nodes (tail of the list)
constructTree([Node|Nodes], Tree, Prev_tree) :-
    add(Node, Prev_tree, Temp_tree),
    constructTree(Nodes, Tree, Temp_tree).

% Construct the tree from the list, and set the previous tree to nil
construct(List, Tree) :- constructTree(List, Tree, nil).


% Task 2 - Count number of nodes and leafs of the binary tree
% If the tree is nil, node count will be zero
count_nodes(nil, 0).
% For non empty tree, total number of nodes will be the sum of
% root, number of nodes in left and right child of the tree
count_nodes(tree(_, Left, Right), Nodes_no) :-
    count_nodes(Left, Left_Nodes_no),
    count_nodes(Right, Right_Nodes_no),
    Nodes_no is Left_Nodes_no + Right_Nodes_no + 1.

% If the tree is nil, leaf count will be zero
count_leafs(nil, 0).
% If the tree has root but left and right child are nil, leaft count will be one
count_leafs(tree(_, nil, nil), 1).
% If left or right child of the tree are not nil, leaft count will be
% the sum of number of leafs in left and right child of the tree
count_leafs(tree(_, Left, Right), Leafs_no) :-
    (Left\=nil; Right\=nil),
    count_leafs(Left, Left_leafs_no),
    count_leafs(Right, Right_leafs_no),
    Leafs_no is Left_leafs_no + Right_leafs_no.


% Task 3 - Binary tree symmetric check
% Mirror reflection of an empty tree will be also an empty tree
isMirror(nil, nil).
% Two tree will be exact mirror reflection of each other,
% if their root is equal,
% left child of the 1st tree is mirror reflection of right child of the 2nd tree,
% and right child of the 1st tree is mirror reflection of left child of the 2nd tree
isMirror(tree(Root1, Left1, Right1), tree(Root2, Left2, Right2)) :-
    Root1==Root2,
    isMirror(Left1, Right2),
    isMirror(Right1, Left2).

% Empty tree is a symmetric tree
symmetric(nil).
% A non empty tree will be symmetric, if left subtree is a mirror reflection of the right subtree
symmetric(tree(_, Left, Right)) :-
    isMirror(Left, Right).


% Sample Queries

% add(5, nil, T)
% add(5, tree(8, nil, nil), T)
% add(9, tree(8, nil, nil), T)
% construct([3,2,4,1,5],T)

% count_nodes(tree(3,tree(2,tree(1,nil,nil),nil),tree(4,nil,tree(5,nil,nil))), Nodes_no)
% count_leafs(tree(3,tree(2,tree(1,nil,nil),nil),tree(4,nil,tree(5,nil,nil))), Leafs_no)

% symmetric(nil)
% symmetric(tree(5, nil, nil))
% symmetric(tree(3,tree(2,tree(3,nil,nil),tree(4,nil,nil)),tree(2,tree(4,nil,nil),tree(3,nil,nil))))
% symmetric(tree(3,tree(2,tree(3,nil,nil),tree(4,nil,nil)),tree(2,tree(3,nil,nil),tree(4,nil,nil))))