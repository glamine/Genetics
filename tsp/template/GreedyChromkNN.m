function greedyChrom = GreedyChromkNN(Dist,NVAR)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

firstCity = randi(NVAR);

remainingCities = 1:NVAR;

currentCityPath = zeros(1,NVAR);

currentCityPath(1) = firstCity;

currentCity = firstCity;

remainingCities = removeCity(currentCity,remainingCities);

for i = 2:NVAR
    
    % find closest city
    closestCity = findClosest(currentCity,Dist,remainingCities);
    
    currentCity = closestCity;

    % add city
    currentCityPath(i) = closestCity;
    
    old_remainingCities = remainingCities;
    %remove currentCity from RemainingCities
    remainingCities = removeCity(currentCity,old_remainingCities);
end



greedyChrom = currentCityPath;


end

