function  NewChrIx = tournament(FitnV,Nsel);
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

CurrPop=1;
NewChrIx=zeros(Nsel,1);
K=2;
rand=zeros(K,1);

while (CurrPop<Nsel+1)
    rand=rand_int(K,1,[1 length(FitnV)]);
    pool=[FitnV(rand),rand];
    best=sortrows(pool,2);
    NewChrIx(CurrPop)=best(1,2);
    CurrPop=CurrPop+1;

end
end

