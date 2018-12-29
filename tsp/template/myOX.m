function NewChrom = myOX(OldChrom, XOVR)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2, XOVR = NaN; end

[rows,cols]=size(OldChrom);

   maxrows=rows;
   if rem(rows,2)~=0 % reste de la division 
	   maxrows=maxrows-1; % rendre pair inferieur
   end
   
   for row=1:2:maxrows
	
     	% crossover of the two chromosomes
   	% results in 2 offsprings
	if rand<XOVR			% recombine with a given probability
		NewChrom(row,:) =cross_alternate_edges([OldChrom(row,:);OldChrom(row+1,:)]);
		NewChrom(row+1,:)=cross_alternate_edges([OldChrom(row+1,:);OldChrom(row,:)]);
	else
		NewChrom(row,:)=OldChrom(row,:);
		NewChrom(row+1,:)=OldChrom(row+1,:);
	end
   end

   if rem(rows,2)~=0
	   NewChrom(rows,:)=OldChrom(rows,:);
   end

end

