function [Chrom, ObjVCh] = new_round_robin(Chrom, SelCh, ObjVCh, ObjVSel,NIND,K);
%this functin was created with the the reins function as inspiration.
%Chrom: parent chromosomes
%ObjVCh: fitness values of parents
%SelCh: offsprings
%ObjVSel: fitness values of offspring
%Round Robin is a pairwise tournament, meaning that indivisuals always
%compete 2 at a time

%Number of individuals in each tournament
%K=5;

%regroup all parents and offsprings in the same place
AllChrom=[Chrom ; SelCh];
AllObjV=[ObjVCh ; ObjVSel];

%number of parents and offsprings
Nind=length(ObjVCh)+length(ObjVSel);
WinCount = zeros(Nind,1);
    
    for i = 1:Nind
        for j = 1:(K-1)
            RowIndex=randi(Nind);
            %if fitness i is higher than a random fitness number increase
            %win count
            if AllObjV(i) < AllObjV(RowIndex)
                WinCount(i) = WinCount(i) + 1;
            end
        end
                
     %sort the offsprings and parents by biggest wincount
     
     %SortChrom = sortrows([WinCount, AllChrom],1,'descend');  
     [val, ind] = sort(WinCount,'descend');
     
     %sort the fitness values of offsprings and parents by biggest wincount
     
     %SortObjV= sortrows([WinCount, AllObjV],1,'descend');
     %[val, ind] = sort(WinCount,'descend');
     
     %select the NIND first values to become the new population while 
     %deleting the wincount
     %Chrom=SortChrom(1:NIND,2:end);
     %ObjVCh=SortObjV(1:NIND,2:end);
     
     Chrom = AllChrom(ind(1:NIND),:);
     ObjVCh = AllObjV(ind(1:NIND),:);
     
end