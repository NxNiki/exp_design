% adapted from sequence_rep3.m by Gui Xue.

% function seq=RepetitionSequence3(noStim,lag)
noStim=40;
lag=4:7;
totalLength=noStim*3;
layerOfseq=4;

tic
Seq=zeros(totalLength,2,layerOfseq);
for iSeq=1:layerOfseq
    while 1
        seq=zeros(totalLength,2);
        % store all lag for the first repetition:
        rep1=kron(ones(1,noStim/length(lag)),lag);
        % store all lag for the second repetition:
        rep2=rep1;
        
        a=randperm(noStim);
        for i=1:noStim
            % first emergence in seq:
            
            % find the index of the 1st unfilled position:
            p=1;while seq(p,1)~=0 && p<totalLength,p=p+1;end
            % p=find(seq(:,1)==0,1,'first');
            % put stim number in that position:
            seq(p)=a(i);
            seq(p,2)=1;
            
            % second emergence in seq:
            
            mm=p+unique(rep1); mm(mm>totalLength)=[]; % can't go beyond the length
            if isempty(find(seq(mm,1)==0, 1)),break;end % quit if all cells are taken
            
            tmp=randperm(length(rep1));
            while p+rep1(tmp(1))<=totalLength && seq(p+rep1(tmp(1)),1)~=0,tmp=randperm(length(rep1));end
            seq(p+rep1(tmp(1)))=a(i);
            seq(p+rep1(tmp(1)),2)=2;
            
            p=p+rep1(tmp(1)); % updata position
            rep1(tmp(1))=[];% remove that lag;
            
            % Third emergence in seq:
            
            mm=p+unique(rep2); mm(mm>totalLength)=[]; % can't go beyond the length
            if isempty(find(seq(mm,1)==0, 1)),break;end % quit if all cells are taken
            
            tmp=randperm(length(rep2));
            while p+rep2(tmp(1))<=totalLength && seq(p+rep2(tmp(1)),1)~=0,tmp=randperm(length(rep2));end
            seq(p+rep2(tmp(1)))=a(i);
            seq(p+rep2(tmp(1)),2)=3;
            
            rep2(tmp(1))=[];% remove that lag;
            
        end
        if isempty(find(seq(:,1)==0, 1))
            break
        end
    end
    
    Seq(:,:,iSeq)=seq(:,:);
end

save Seq Seq -append
toc








