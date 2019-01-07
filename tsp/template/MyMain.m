% MyMain

close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NIND=200;%50		% Number of individuals
MAXGEN=1000;%100		% Maximum no. of generations
NVAR=26;		% No. of variables
PRECI=1;		% Precision of variables
ELITIST=0.2;%0.25;%0.05    % percentage of the elite population
GGAP=1-ELITIST;		% Generation gap
STOP_PERCENTAGE=.95;%0.95    % percentage of equal fitness individuals for stopping
PR_CROSS=.95;%0.95     % probability of crossover
PR_MUT=0.2;%0.05       % probability of mutation
LOCALLOOP=1; %0     % local loop removal
CROSSOVER = 'myOX';%'xalt_edges';  % default crossover operator
SCALE = 2;% it is 2 by default, should allow the tuning of selection pressure
NGEN_NOIMPROVE = 50;
K = 3; %round robin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Gen_data;
numberOfInstances = 10;%
Gen_data.fitness = zeros(numberOfInstances,1);
Gen_data.fitnessBis = zeros(numberOfInstances,1);
Gen_data.i = 1;
Gen_data.j = 1;

% load the data sets
datasetslist = dir('datasets/');datasetslist = dir('datasets/');
datasets=cell( size(datasetslist,1)-2,1);datasets=cell( size(datasetslist,1)-2 ,1);
for i=1:size(datasets,1);
    datasets{i} = datasetslist(i+2).name;
end

% start with first dataset
data = load(['datasets/' datasets{6}]); %change dataset
x=data(:,1)/max([data(:,1);data(:,2)]);
y=data(:,2)/max([data(:,1);data(:,2)]);
NVAR=size(data,1);

%%
% x1 = [0;2;2;0;-2;-2];
% y1 = [2;1;-1;-2;-1;1];
% x2 = x1 + 6;
% x = [x1;x2];
% y = [y1;y1];
% NVAR = 12;%6

% initialise the user interface
fh = figure('Visible','off','Name','TSP Tool','Position',[0,0,1024,768]);
ah1 = axes('Parent',fh,'Position',[.1 .55 .4 .4]);
plot(x,y,'ko')
ah2 = axes('Parent',fh,'Position',[.55 .55 .4 .4]);
axes(ah2);
xlabel('Generation');
ylabel('Distance (Min. - Gem. - Max.)');
ah3 = axes('Parent',fh,'Position',[.1 .1 .4 .4]);
axes(ah3);
title('Histogram');
xlabel('Distance');
ylabel('Number');

%%


%     for i = 1:numberOfInstances
% 
%         run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, NGEN_NOIMPROVE,K);
%     
%     end

%%

% elitism 0.15
% for myElitism = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4] % [0.1 0.15 0.2 0.3 0.4 0.5]
%     for i = 1:numberOfInstances
% 
%         run_ga(x, y, NIND, MAXGEN, NVAR, myElitism, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, NGEN_NOIMPROVE,K);
%     
%     end
%     
%     Gen_data.i = 1;
%     Gen_data.elitism(Gen_data.j) = myElitism;
%     Gen_data.pop(Gen_data.j) = NIND;
%     
%     
%     Gen_data.j = Gen_data.j + 1;
% end

%pop size 200
% for myPop = [25 50 100 200 400 800]
%     for i = 1:numberOfInstances
% 
%         run_ga(x, y, myPop, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, NGEN_NOIMPROVE,K);
%     
%     end
%     
%     Gen_data.elitism(Gen_data.j) = ELITIST;
%     Gen_data.pop(Gen_data.j) = myPop;
%     Gen_data.i = 1;
%     Gen_data.j = Gen_data.j + 1;
% end


%K value
for myK = [3 5 7 10]
    for i = 1:numberOfInstances

        run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, NGEN_NOIMPROVE,myK);
    
    end
    
    Gen_data.elitism(Gen_data.j) = ELITIST;
    Gen_data.pop(Gen_data.j) = NIND;
    Gen_data.K(Gen_data.j) = myK;
    Gen_data.i = 1;
    Gen_data.j = Gen_data.j + 1;
end

%%

% other_fitness = Gen_data.fitness;
% other_gen = Gen_data.gen;
% other_diversity = Gen_data.diversity;
% other_pop = Gen_data.pop;
% other_elitism = Gen_data.elitism;
% other_timer = Gen_data.timer;


%%

% [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4] gen
% [x    0.1 0.15 0.2 x    0.3 x    0.4 0.5]other
%  a    b   c    d   e    f   g    h   i

% elite = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.5];
% meanA = mean(Gen_data.fitness(:,1));
% meanB = mean([Gen_data.fitness(:,2);other_fitness(:,1)]);
% meanC = mean([Gen_data.fitness(:,3);other_fitness(:,2)]);
% meanD = mean([Gen_data.fitness(:,4);other_fitness(:,3)]);
% meanE = mean(Gen_data.fitness(:,5));
% meanF = mean([Gen_data.fitness(:,6);other_fitness(:,4)]);
% meanG = mean(Gen_data.fitness(:,7));
% meanH = mean([Gen_data.fitness(:,8);other_fitness(:,5)]);
% meanI = mean(other_fitness(:,6));
% 
% meanfits = [meanA meanB meanC meanD meanE meanF meanG meanH meanI];
% 
% timeA = mean(Gen_data.timer(:,1));
% timeB = mean([Gen_data.timer(:,2);other_timer(:,1)]);
% timeC = mean([Gen_data.timer(:,3);other_timer(:,2)]);
% timeD = mean([Gen_data.timer(:,4);other_timer(:,3)]);
% timeE = mean(Gen_data.timer(:,5));
% timeF = mean([Gen_data.timer(:,6);other_timer(:,4)]);
% timeG = mean(Gen_data.timer(:,7));
% timeH = mean([Gen_data.timer(:,8);other_timer(:,5)]);
% timeI = mean(other_timer(:,6));
% 
% meantime = [timeA timeB timeC timeD timeE timeF timeG timeH timeI];

%meanfits = mean([Gen_data.fitness, other_firness]);
%meantime = mean([Gen_data.timer, other_timer]);
%varfits = var([Gen_data.fitness, other_firness]);

% meanfits2 = mean(other_fitness);
% meantime2 = mean(other_timer);
% meandiversity2 = mean(other_diversity);
% meanNgen2 = mean(other_gen);
% 
% meanfits3 = mean(Gen_data.fitness);
% meantime3 = mean(Gen_data.timer);
% meandiversity3 = mean(Gen_data.diversity);
% meanNgen3 = mean(Gen_data.gen);
% 
% figure(2);
% plot(other_pop(7:12),meanfits2(7:12));  
% set(gca,'fontsize',12);
% title('Average path length in function of population size')
% xlabel('Number of individuals [/]')
% ylabel('Path length [/]')
% 
% figure(3);
% plot(elite,meanfits);  
% set(gca,'fontsize',12);
% title('Average path length in function of elitism percentage')
% xlabel('Elistism [%]')
% ylabel('Path length [/]')
% 
% figure(4);
% plot(Gen_data.elitism(1:8),meandiversity3(1:8));  
% set(gca,'fontsize',12);
% title('Average difference of path length in function of elitism percentage')
% xlabel('Elistism [%]')
% ylabel('Difference of path [/]')
% 
% 
% figure(5);
% plot(other_pop(7:12),meantime2(7:12));  
% set(gca,'fontsize',12);
% title('Average time of computation in function of population size')
% xlabel('Number of individuals [/]')
% ylabel('Time [s]')
% 
% figure(6);
% plot(other_pop(7:12),meandiversity2(7:12));  
% set(gca,'fontsize',12);
% title('Average difference of path in function of population size')
% xlabel('Number of individuals [/]')
% ylabel('Difference of path [/]')
% 
% figure(7);
% plot(other_pop(7:12),meanNgen2(7:12));  
% set(gca,'fontsize',12);
% title('Average number of generations in function of population size')
% xlabel('Number of individuals [/]')
% ylabel('Ngen [/]')
% 
% figure(8);
% plot(Gen_data.elitism(1:8),meantime3(1:8));  
% set(gca,'fontsize',12);
% title('Average time of computation in function of elitism percentage')
% xlabel('Elistism [%]')
% ylabel('Time [s]')
% 
% figure(9);
% plot(Gen_data.elitism(1:8),meanNgen3(1:8));  
% set(gca,'fontsize',12);
% title('Average number of generations in function of elitism percentage')
% xlabel('Elistism [%]')
% ylabel('Ngen [/]')

%%

meanfits4 = mean(Gen_data.fitness);
meantime4 = mean(Gen_data.timer);
meandiversity4 = mean(Gen_data.diversity);
meanNgen4 = mean(Gen_data.gen);

figure(10);
plot(Gen_data.K,meanfits4);  
set(gca,'fontsize',12);
title('Average path length in function of size round-robin')
xlabel('K-tournament [/]')
ylabel('Path length [/]')

figure(11);
plot(Gen_data.K,meantime4);  
set(gca,'fontsize',12);
title('Average time of computation in function of size round-robin')
xlabel('K-tournament [/]')
ylabel('Time [s]')

figure(12);
plot(Gen_data.K,meanNgen4);  
set(gca,'fontsize',12);
title('Average number of generations in function of size round-robin')
xlabel('K-tournament [/]')
ylabel('Ngen [/]')

figure(13);
plot(Gen_data.K,meandiversity4);  
set(gca,'fontsize',12);
title('Average difference of path length in function of size round-robin')
xlabel('K-tournament [/]')
ylabel('Difference of path [/]')
