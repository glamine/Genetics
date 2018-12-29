function Offspring = cross_order_based(Parents,bi,ei)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    L = length(Parents(1,:));
    Offspring = zeros(1,L);
    segmentSize = ei - bi + 1;
    
    Offspring(1,1:segmentSize) = Parents(1,bi:ei);
    
    
    CleanParent2 = setdiff(Parents(2,:),Parents(1,bi:ei));

%     for j = ei : bi
%         Parents(2,Parents()) = [];
%     end

    for i = 1 : L - segmentSize
        
        Offspring(i + segmentSize) = CleanParent2(i);
    end

    
end

