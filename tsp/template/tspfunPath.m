function ObjVal = tspfunPath(Gen,Dist)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Ncity = length(Gen(1,:));
    Nindiv = length(Gen(:,1));
	ObjVal = zeros(Nindiv,1);%
    
    for j = 1 : Nindiv
	
        ObjVal(j) = Dist(Gen(j,Ncity),Gen(j,1));
        for i = 2 : Ncity
            ObjVal(j) = ObjVal(j) + Dist(Gen(j,i-1),Gen(j,i));
        end
        
	end


end

