% TEST

% Offspring = cross_order_based(Parents,bi,ei)
% Chrom = [1 2 3 4 5;
%          2 3 1 5 4];
%      
     Chrom = [1 2 3; 4 5 6; 7 8 9; 10 11 12; 13 14 15; 16 17 18; 19 20 21;
         22 23 24; 25 26 27; 28 29 30  ] ;
     FitnV = [1;2;3;4;5;6;7;8;9;10];
     ObjV = [10;9;8;7;6;5;4;3;2;1];
     ObjV1 = [10;1;9;2;8;3;7;4;6;5];
     q = 3;
     bi = 3;
     ei = 4;
     GGAP = 0.5;

%Offspring = cross_order_based(Chrom,bi,ei);
%SelectedChrom = roundRobinTournament(Chrom , FitnV, GGAP, q);

[NewChrom NewObjV1] = reins(Chrom(1:6,:),Chrom(7:10,:),1,1,ObjV1(1:6),ObjV1(7:10));

