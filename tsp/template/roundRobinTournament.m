function SelCh = roundRobinTournament(Chrom , ObjV, GGAP, KValue)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Compute number of new individuals (to select)

[Nind, ans] = size(ObjV);
NSel = max(floor(Nind*GGAP+.5), 2);

% Select individuals for breeding

WinCount = zeros(Nind,1);

    for i = 1:Nind
        %RowIndex = randi(Nind) ;
%         K = floor(KValue) ;
%         pK = KValue - K;
%         if rand<pK
%             K = K+1;
%         end

        for j = 1:(KValue - 1) %ou k
            RowIndex2 = randi(Nind) ;
            if ObjV(i) > ObjV(RowIndex2 ) ;
                %RowIndex = RowIndex2 ;
                WinCount(i) = WinCount(i) + 1;
            end
        end
        %SelCh = [ SelCh ; Chrom(RowIndex , : ) ] ;

    end

    [val, ind] = sort(WinCount,'descend');
%     val(1:3)
%     ind(1:3)
%     r(ind(1:3))

    SelCh = Chrom(ind(1:NSel),:);

end

