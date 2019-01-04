function  NewChrIx = tournament(FitnV,Nsel);

%the output of the tournament function is a matrix with the indexes
%of the chosen individuals for parenting

%initialize the size of the parent selection
CurrPop=1;

%initialize the index matrix
NewChrIx=zeros(Nsel,1);

%size of the tournament
K=2;
rand=zeros(K,1);

%run the algorithm while we haven't reached the maximum selection size
while (CurrPop<Nsel+1)
    
    %choose K individuals for the tournament
    rand=rand_int(K,1,[1 length(FitnV)]);
    pool=[FitnV(rand),rand];
    %sort smallest fitness value first
    best=sortrows(pool,2,"descend");
    %select the index of the best individual and store it in NewChrIx
    NewChrIx(CurrPop)=best(1,2);
    
    CurrPop=CurrPop+1;

end
end

