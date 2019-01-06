function run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, SCALE, NGEN_NOIMPROVE)


global tuning;



PARENT_SELECTION ={'sus','rws','tournament'};
MUTATION = {'reciprocal_exchange', 'inversion', 'cut_inversion'};

%PARENT_SELECTION =['sus','rws','tournament'];
%MUTATION = ['reciprocal_exchange', 'inversion', 'cut_inversion'];

%PARENT_SELECTION =["sus","rws","tournament"];
%MUTATION = ["reciprocal_exchange", "inversion" "cut_inversion"];



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
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP SCALE NGEN_NOIMPROVE}




for par = 1:3 
        
    for mut = 1:3
        
        %counter 1
        tuning.i = 1;
        
        %fitness column
        tuning.fitness = zeros(tuning.numberOfInstances ,1);

        %mean column
        tuning.mean = zeros(tuning.numberOfInstances,1);

        %max column
        tuning.max = zeros(tuning.numberOfInstances ,1);

        %diversity column
        tuning.div  = zeros(tuning.numberOfInstances ,1);

        %generations column
        tuning.gen = zeros(tuning.numberOfInstances ,1);

        %timer column
        tuning.timer  = zeros(tuning.numberOfInstances ,1);
        
        for i = 1:tuning.numberOfInstances 
        
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
        for row=1:NIND - 1
        	%Chrom(row,:)=path2adj(randperm(NVAR));%if path representation
            Chrom(row,:)=randperm(NVAR);
        end
        
        Chrom(NIND,:) = GreedyChromkNN(Dist,NVAR);
        
        
        gen=0;
        counter=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND);
        % evaluate initial population
        %ObjV = tspfun(Chrom,Dist);
        ObjV = tspfunPath(Chrom,Dist);
        best=zeros(1,MAXGEN);
        % generational loop

        tic;
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
            
            %select individuals for breeding, SelCh are the parents
        	%SelCh=select(PARENT_SELECTION(par), Chrom, FitnV, GGAP);
            ParCh = select(PARENT_SELECTION{par}, Chrom, FitnV, GGAP);
            
        	
            
            %recombine parents to get the offspring (crossover)I have
            %changed the name from SelCh to OffCh for clarity and 
            %to be able to reuse SelCh
            %SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
            OffCh = recombin(CROSSOVER,ParCh,PR_CROSS);
            
            %mutate offsprings
            %SelCh = mutateTSP(MUTATION(mut),SelCh,PR_MUT);
            OffCh = mutateTSP(MUTATION{mut},OffCh,PR_MUT);
            
            %output the chromosomes out of the algorithm to be able to
            %examine them, has no use in the algorithm
            %tuning.ParCh = ParCh;
            %tuning.Chrom = Chrom;
            %tuning.OffCh = OffCh;
            
            %evaluate offspring and selected parents, call objective function
            %ObjVSel = tspfunPath(SelCh,Dist);
        	ObjVOff = tspfunPath(OffCh,Dist);
            ObjVPar = tspfunPath(ParCh,Dist);
            
            %reinsert offspring into population
            
            %these two are for the elitism suvivor selection
            %[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
        	%[Chrom ObjV]=reins(Chrom,OffCh,1,1,ObjV,ObjVOff);
            
            %this is for the robin round tournament
            [Chrom ObjV]=new_round_robin(ParCh,OffCh,ObjVPar,ObjVOff,NIND);
            
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

