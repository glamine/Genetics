% MyMain

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NIND=500;%50		% Number of individuals
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
NGEN_NOIMPROVE = 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global tuning;


tuning.numberOfInstances = 10;

%complete table
tuning.summary = zeros(9,9); 

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

%counter 2
tuning.j = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global Gen_data;
numberOfInstances = 3;%
Gen_data.fitness = zeros(numberOfInstances,1);
Gen_data.fitnessBis = zeros(numberOfInstances,1);
Gen_data.i = 1;

% load the data sets
datasetslist = dir('datasets/');datasetslist = dir('datasets/');
datasets=cell( size(datasetslist,1)-2,1);datasets=cell( size(datasetslist,1)-2 ,1);
for i=1:size(datasets,1);
    datasets{i} = datasetslist(i+2).name;
end

% start with first dataset
data = load(['datasets/' datasets{10}]); %change dataset
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
    
    run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, SCALE, NGEN_NOIMPROVE);
    


%run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);

%figure(8);
