% TEST

% Offspring = cross_order_based(Parents,bi,ei)
% Chrom = [1 2 3 4 5;
%          2 3 1 5 4];
%      
     Chrom = [1 2 3 4 5;
         3 4 1 2 5];
     bi = 3;
     ei = 4;

Offspring = cross_order_based(Chrom,bi,ei);