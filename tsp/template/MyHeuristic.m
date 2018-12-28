function newpop = MyHeuristic(popsize, ncities, pop, improve,dists)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    if (improve)
       for i=1:popsize

         result = improve_path(ncities, pop(i,:),dists);

         pop(i,:) = result;

       end
    end

    newpop = pop;


end

