function run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, NGEN_NOIMPROVE,K)

global Gen_data;

% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, 
%               ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% MAXGEN: maximal number of generations
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP NGEN_NOIMPROVE K}


        nGreedy = 5;
        GGAP = 1 - ELITIST;
        mean_fits=zeros(1,MAXGEN+1);
        worst=zeros(1,MAXGEN+1);
        Dist=zeros(NVAR,NVAR);
        for i=1:size(x,1)
            for j=1:size(y,1)
                Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        
        tic;
        
        % initialize population
        Chrom=zeros(NIND,NVAR);
        for row=1:NIND - nGreedy
        	%Chrom(row,:)=path2adj(randperm(NVAR));%if path representation
            Chrom(row,:)=randperm(NVAR);
        end
        
        for ng = 1:nGreedy
            Chrom(NIND-ng+1,:) = GreedyChromkNN(Dist,NVAR);
        end
        
        
        gen=0;
        counter=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        %ObjV = tspfun(Chrom,Dist);
        ObjV = tspfunPath(Chrom,Dist);
        best=zeros(1,MAXGEN);
        % generational loop
        while (gen<MAXGEN && counter < NGEN_NOIMPROVE)
            
            sObjV=sort(ObjV);
          	best(gen+1)=min(ObjV);
        	minimum=best(gen+1);
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            
            if(gen > 0)
                if(best(gen) == best(gen+1))
                    counter = counter+1;
                else
                    counter = 0;
                end
            end
            
            
            
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum) % Obj est une fitness, the best one
                    break;
                end
            end

            %visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
            visualizeTSP(x,y,Chrom(t,:), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3,ELITIST); %visualize does not change

            if (sObjV(stopN)-sObjV(1) <= 1e-15)
                  break;
            end          
        	%assign fitness values to entire population
        	
            FitnV=ranking(ObjV); % give them a rank ? +-, fitness linear fct ranking
                                    % longer have lower fitness
            %assign fitness with FPS
            %FitnV = FPS(ObjV,2);%SCALE
            %FitnV = scaling(ObjV,2); % SCALE % longer have higher fitness
            
            %select individuals for breeding
            %SelCh=select('sus', Chrom, FitnV, GGAP);
            ParSelCh=select('sus', Chrom, FitnV, GGAP);
        	
            %recombine individuals (crossover)
            
            %SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
            OffSelCh = recombin(CROSSOVER,ParSelCh,PR_CROSS);
            
            %SelCh = mutateTSP('cut_inversion',SelCh,PR_MUT);
            OffSelCh = mutateTSP('cut_inversion',OffSelCh,PR_MUT);
            
            %evaluate offspring, call objective function
        	%ObjVSel = tspfunPath(SelCh,Dist);
            ObjVOff = tspfunPath(OffSelCh,Dist);
            ObjVPar = tspfunPath(ParSelCh,Dist);
            
            
            %reinsert offspring into population
        	%[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            [Chrom ObjV] = new_round_robin(ParSelCh,OffSelCh,ObjVPar,ObjVOff,NIND,K);
            
            %Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
            Chrom = MyHeuristic(NIND, NVAR, Chrom,LOCALLOOP,Dist);
        	%increment generation counter
        	gen=gen+1;
        end
        
        Gen_data.timer(Gen_data.i,Gen_data.j) = toc;
        Gen_data.gen(Gen_data.i,Gen_data.j) = gen;
        Gen_data.fitness(Gen_data.i,Gen_data.j) = sObjV(1);
        Gen_data.diversity(Gen_data.i,Gen_data.j) = sObjV(stopN)-sObjV(1);
        
        %Gen_data.fitnessBis(Gen_data.i,Gen_data.j) = min(ObjV);
        Gen_data.i = Gen_data.i + 1;
end
