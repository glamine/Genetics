function NewChrom = myOX(OldChrom, XOVR)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2, XOVR = NaN; end

[rows,cols]=size(OldChrom);

   maxrows=rows;
   if rem(rows,2)~=0 % reste de la division 
	   maxrows=maxrows-1; % rendre pair inferieur
   end
   
   L = length(OldChrom(1,:));
   
   for row=1:2:maxrows
	
       bounds = randperm(L,2);
       if(bounds(1) > bounds(2))
           bi = bounds(2);
           ei = bounds(1);
       else
           bi = bounds(1);
           ei = bounds(2);
       end
       
       
     	% crossover of the two chromosomes
   	% results in 2 offsprings
	if rand<XOVR			% recombine with a given probability
		NewChrom(row,:) = cross_order_based([OldChrom(row,:);OldChrom(row+1,:)],bi,ei);
		NewChrom(row+1,:) = cross_order_based([OldChrom(row+1,:);OldChrom(row,:)],bi,ei);
	else
		NewChrom(row,:) = OldChrom(row,:);
		NewChrom(row+1,:) = OldChrom(row+1,:);
	end
   end

   if rem(rows,2)~=0
	   NewChrom(rows,:)=OldChrom(rows,:);
   end

end

