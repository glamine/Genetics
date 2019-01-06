% MyMain

close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NIND=200;%50		% Number of individuals
MAXGEN=1000;%100		% Maximum no. of generations
NVAR=26;		% No. of variables
PRECI=1;		% Precision of variables
ELITIST=0.15;%0.25;%0.05    % percentage of the elite population
GGAP=1-ELITIST;		% Generation gap
STOP_PERCENTAGE=.95;%0.95    % percentage of equal fitness individuals for stopping
PR_CROSS=.95;%0.95     % probability of crossover
PR_MUT=.15;%0.05       % probability of mutation
LOCALLOOP=1; %0     % local loop removal
CROSSOVER = 'myOX';%'xalt_edges';  % default crossover operator
SCALE = 2;% it is 2 by default, should allow the tuning of selection pressure
NGEN_NOIMPROVE = 50;
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

% elitism 0.15
for myElitism = [0.1 0.15 0.2 0.3 0.4 0.5]
    for i = 1:numberOfInstances

        run_ga(x, y, NIND, MAXGEN, NVAR, myElitism, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, SCALE, NGEN_NOIMPROVE);
    
    end
    
    Gen_data.i = 1;
    Gen_data.elitism(Gen_data.j) = myElitism;
    Gen_data.pop(Gen_data.j) = NIND;
    
    
    Gen_data.j = Gen_data.j + 1;
end

%pop size 200
for myPop = [25 50 100 200 400 800]
    for i = 1:numberOfInstances

        run_ga(x, y, myPop, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, SCALE, NGEN_NOIMPROVE);
    
    end
    
    Gen_data.elitism(Gen_data.j) = ELITIST;
    Gen_data.pop(Gen_data.j) = myPop;
    Gen_data.i = 1;
    Gen_data.j = Gen_data.j + 1;
end


