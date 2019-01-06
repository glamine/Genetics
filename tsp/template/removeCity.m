function RemainingCities = removeCity(currentCity,RemainingCities)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here


    offset = 0;
    for i = 1:length(RemainingCities)
        if(currentCity == RemainingCities(i-offset))
            RemainingCities(i-offset) = [];
            offset = offset + 1;
        end
    end


end

