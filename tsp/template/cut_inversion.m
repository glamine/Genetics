% low level function for TSP mutation
% cut_inversion: two random cities in a tour are swapped
% Representation is an integer specifying which encoding is used
%	1 : adjacency representation
%	2 : path representation
%

function NewChrom = cut_inversion(OldChrom,Representation);

NewChrom=OldChrom;

if Representation==1 
	NewChrom=adj2path(NewChrom);
end

% select two positions in the tour

rndi=zeros(1,2);
randpos=zeros(1,1);

while rndi(1)==rndi(2)
	rndi=rand_int(1,2,[1 (size(NewChrom,2))]);
end
rndi = sort(rndi);

%randpos = rand_int(1,1,[1 length(NewChrom)-(rndi(2)-rndi(1))-1]);

%initialize to a length equal to the length of the chromosome minus the
%reversed segment
BufferChrom1=zeros(1,length(NewChrom)-(rndi(2)-rndi(1))-1);
BufferChrom2=zeros(1,rndi(2)-rndi(1)+1);

%New matrix BufferChrom1 which is the NewChrom minus the segment
BufferChrom1=[NewChrom(1:rndi(1)-1),NewChrom(rndi(2)+1:length(NewChrom))];

%New matrix BufferChrom2 which is the reversed segement
BufferChrom2=NewChrom(rndi(2):-1:rndi(1));

%choose a random position in BufferChrom1 to reinsert the reversed segment
 randpos=rand_int(1,1,[0 length(BufferChrom1)]);

    if randpos==0
        NewChrom=[BufferChrom2,BufferChrom1];


    elseif randpos==length(BufferChrom1)
        NewChrom=[BufferChrom1,BufferChrom2];


    else
        %Divide BufferChrom1 into two SubChromosomes
        BufferChrom1sub1=BufferChrom1(1:randpos);
        BufferChrom1sub2=BufferChrom1(randpos+1:length(BufferChrom1));

        %concatenate all three matrices to form the new chromosome
        NewChrom=[BufferChrom1sub1,BufferChrom2,BufferChrom1sub2];

    end


    if Representation==1
        NewChrom=path2adj(NewChrom);
    end

end

% End of function

