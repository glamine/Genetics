function ObjVal = tspfunPath(Gen,Dist)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Ncity = length(Gen(1,:));
	ObjVal=Dist(Gen(:,Ncity),Gen(:,1));
    
	for i = 2:size(Gen,2)

    	ObjVal = ObjVal + Dist(Gen(:,i-1),Gen(:,i));
	end


end

