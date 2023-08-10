% Problem 2.3.1 - Tower of Hanoi

% For only 1 disk, move it from source peg to destination peg, (here we don't need the auxiliary peg)
move(1, Source, Destination, _) :-
    write("Move top disk from "), write(Source), write(" to "), writeln(Destination).

% For number of N disk (N>1), we need to do following steps,
% Step 1: move (N-1) top disk from source peg to auxiliary peg (here use destination peg as spare peg)
% Step 2: move the most bottom disk from source peg to destination peg
% Step 3: move (N-1) disk from auxiliary peg to destination peg (here use source peg as spare peg)
move(Disk, Source, Destination, Auxiliary) :-
    Disk>1, Top_Disk is Disk-1,
    move(Top_Disk, Source, Auxiliary, Destination),
    write("Move top disk from "), write(Source), write(" to "), writeln(Destination),
    move(Top_Disk, Auxiliary, Destination, Source).
