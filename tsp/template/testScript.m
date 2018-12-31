% TEST

% Offspring = cross_order_based(Parents,bi,ei)
% Chrom = [1 2 3 4 5;
%          2 3 1 5 4];
%      
     Chrom = [1 2 3; 4 5 6; 7 8 9; 10 11 12; 13 14 15; 16 17 18; 19 20 21;
         22 23 24; 25 26 27; 28 29 30  ] 
     FitnV = [1;2;3;4;5;6;7;8;9;10];
     q = 3;
     bi = 3;
     ei = 4;
     GGAP = 0.5;

%Offspring = cross_order_based(Chrom,bi,ei);
%SelectedChrom = roundRobinTournament(Chrom , FitnV, GGAP, q);

[Chrom ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);

