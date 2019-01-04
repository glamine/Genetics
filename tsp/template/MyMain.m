% MyMain

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NIND=200;%50		% Number of individuals
MAXGEN=1;%100		% Maximum no. of generations
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global tuning;

%complete table
tuning.summary = zeros(9,9);

%fitness column
tuning.fitness = zeros(numberOfInstances,1);

%mean column
tuning.mean = zeros(numberOfInstances,1);

%max column
tuning.max = zeros(numberOfInstances,1);

%diversity column
tuning.div  = zeros(numberOfInstances,1);

%generations column
tuning.gen = zeros(numberOfInstances,1);

%timer column
tuning.timer  = zeros(numberOfInstances,1);

%counter 1
tuning.i = 1;

%counter 2
tuning.j = 1;

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

    
    run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3, SCALE);
    


%run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3);

%figure(8);
