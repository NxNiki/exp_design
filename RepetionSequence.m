function seq=RepetionSequence(NumOfItems,Repetition,LagRange)
% this function generate a vector with repetitave components, the lag
% between 2 adjacent identical components is constrained within a range.
% the code is adapted form sequence_rep2.m and sequence_rep3.m
% by Niki 2013/5/19
% unfinished...


% numOfitems=40;
% repetition=2;
% lag=4:7;% the lag between two adjacent repetitions range from 4 to 7

isok=1;
while isok
    seq=zeros(1,NumOfItems*Repetition);
    rep=kron(ones(1,ceil(NumOfItems/length(LagRange))),LagRange); 
    rep=rep(1:NumOfItems);
    a=randperm(NumOfItems);
    for i=1:NumOfItems
        % first
        % find the index of the first unfilled element (equals 0) in seq:
        p=1;while seq(p)~=0 && p<80,p=p+1;end
        
        seq(p)=a(i);
    
        % second
        % add index with the lag:
        mm=p+unique(rep); 
        mm(mm>80)=[]; % can't go beyond the length
        if isempty(find(seq(mm)==0, 1)),break;end % quit if all cells are taken
        
        tmp=randperm(length(rep));
        % if the index is not overflow and seq with that index has been
        % filled, reset tmp:
        while p+rep(tmp(1))<81 && seq(p+rep(tmp(1)))~=0,tmp=randperm(length(rep));end
        seq(p+rep(tmp(1)))=a(i);

        rep(tmp(1))=[];% remove that lag;
%         i=i+1; % next trial 
    end
%     if isempty(find(seq==0, 1)),
%         isok=0;
%         a=dir('seq2_*.mat');
%         filename=sprintf('seq2_%02d',length(a)+1);
%         eval(sprintf('save %s seq',filename));
%         fprintf('got one, saved as %s!\n',filename);
%     end
end