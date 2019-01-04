function run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, SCALE)

numberOfInstances = 2;

PARENT_SELECTION =["sus","rws","tournament"];
MUTATION = ["reciprocal_exchange", "inversion", "cut_inversion"];
global tuning;
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
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP SCALE}


for par = 1:3 
        
    for mut = 1:3
        
        for i = 1:numberOfInstances
        
        GGAP = 1 - ELITIST;
        mean_fits=zeros(1,MAXGEN+1);
        worst=zeros(1,MAXGEN+1);
        Dist=zeros(NVAR,NVAR);
        for i=1:size(x,1)
            for j=1:size(y,1)
                Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        
        % initialize population
        Chrom=zeros(NIND,NVAR);
        for row=1:NIND
        	%Chrom(row,:)=path2adj(randperm(NVAR));%if path representation
            Chrom(row,:)=randperm(NVAR);
        end
        gen=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        %ObjV = tspfun(Chrom,Dist);
        ObjV = tspfunPath(Chrom,Dist);
        best=zeros(1,MAXGEN);
        % generational loop
        tic;
        while gen<MAXGEN
            sObjV=sort(ObjV);
          	best(gen+1)=min(ObjV);
        	minimum=best(gen+1);
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum) % Obj est une fitness, the best one
                    break;
                end
            end

            %visualizeTSP(x,y,adj2path(Chrom(t,:)), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);
            visualizeTSP(x,y,Chrom(t,:), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3); %visualize does not change

            if (sObjV(stopN)-sObjV(1) <= 1e-15)
                  break;
            end          
        	%assign fitness values to entire population
        	
            %FitnV=ranking(ObjV); % give them a rank ? +-, fitness linear fct ranking
                                    % longer have lower fitness
            %assign fitness with FPS
            FitnV = FPS(ObjV,SCALE);
            %FitnV = scaling(ObjV,SCALE); % longer have higher fitness
            
            %select individuals for breeding
        	SelCh=select(PARENT_SELECTION(par), Chrom, FitnV, GGAP);
        	%recombine individuals (crossover)
            
            SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
            
            SelCh = mutateTSP(MUTATION(mut),SelCh,PR_MUT);
            %evaluate offspring, call objective function
        	ObjVSel = tspfunPath(SelCh,Dist);
            %reinsert offspring into population
        	[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            %Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
            Chrom = MyHeuristic(NIND, NVAR, Chrom,LOCALLOOP,Dist);
        	%increment generation counter
        	gen=gen+1;            
        end
        
        tuning.fitness(tuning.i) = sObjV(1);
        tuning.mean(tuning.i)=mean(ObjV);
        tuning.max(tuning.i)=max(ObjV);
        tuning.div(tuning.i)=(length(unique(ObjV))/length(ObjV));
        tuning.gen(tuning.i)=gen;
        tuning.timer(tuning.i)=toc;
        tuning.i = tuning.i + 1;
        
        end
        
        
        tuning.summary(tuning.j,1)=mean(tuning.fitness);
        tuning.summary(tuning.j,2)=mean(tuning.mean);
        tuning.summary(tuning.j,3)=mean(tuning.max);
        tuning.summary(tuning.j,4)=mean(tuning.div);
        tuning.summary(tuning.j,5)=mean(tuning.gen);
        tuning.summary(tuning.j,6)=mean(tuning.timer);
        tuning.summary(tuning.j,7)=mut;
        tuning.summary(tuning.j,8)=par;
        tuning.summary(tuning.j,9)=1;
        
        tuning.j=tuning.j+1;
    end    
end

