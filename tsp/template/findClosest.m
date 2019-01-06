function cityIndex = findClosest(currentCity,Dist,remainingCities)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
shortestDist = Dist(currentCity,remainingCities(1));
shortestIndex = remainingCities(1);

    for i = remainingCities

        if(shortestDist > Dist(currentCity,i))
            shortestDist = Dist(currentCity,i);
            shortestIndex = i;
        end

    end

    cityIndex = shortestIndex;

end

