function [stimulusList1,stimulusList2]=generatePairList(stimulusList,responseList,varargin)
%{
% pair stimulusList according to the responseList: only the stimulus with
% same response will be paired. varargin should be the key codes of
response if they are not '1','2','3', which is the specific form.
% by Niki

% modified to general form
% by Niki ---2013/4/19.

% it is better to operate on vectors than on cell first, then translated
% numbers in vector into string in cell. this function is complicated and
% inefficient...
% by Niki ---2013/6/27.

add case for vector input. It is faster to input vector and then convert
the output vector to string if it is needed.
by Niki ---2013/6/28

fix the bug for row vector input by adding the case:
        stimulusList1=cat(2,subStimListPair{:,1});
        stimulusList2=cat(2,subStimListPair{:,2});
by Niki ---2013/7/16

%}

if iscell(stimulusList)&&iscell(responseList)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % cell input:
    numOfstim=size(responseList,1)*size(responseList,2);
    if nargin==2
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % specific form:
        
        keyCode.want  ='1';
        keyCode.unsure='2';
        keyCode.reject='3';
        
        I.w=0;
        I.e=0;
        I.r=0;
        for i=1:numOfstim
            switch responseList{i}
                case keyCode.want
                    I.w=I.w+1;
                case keyCode.unsure
                    I.e=I.e+1;
                case keyCode.reject
                    I.r=I.r+1;
            end
        end
        
        substimList.w=cell(1,I.w);
        substimList.e=cell(1,I.e);
        substimList.r=cell(1,I.r);
        
        j.w=1;
        j.e=1;
        j.r=1;
        for i=1:numOfstim
            switch responseList{i}
                case keyCode.want
                    substimList.w{j.w}=stimulusList{i};
                    j.w=j.w+1;
                case keyCode.unsure
                    substimList.e{j.e}=stimulusList{i};
                    j.e=j.e+1;
                case keyCode.reject
                    substimList.r{j.r}=stimulusList{i};
                    j.r=j.r+1;
            end
        end
        
        % stimulusList2=[List.w List.e List.r];
        [pairCode.w(1,:),pairCode.w(2,:)]=Pairing(I.w);
        [pairCode.e(1,:),pairCode.e(2,:)]=Pairing(I.e);
        [pairCode.r(1,:),pairCode.r(2,:)]=Pairing(I.r);
        
        stimPairList.w1=substimList.w(pairCode.w(1,:));
        stimPairList.w2=substimList.w(pairCode.w(2,:));
        stimPairList.e1=substimList.e(pairCode.e(1,:));
        stimPairList.e2=substimList.e(pairCode.e(2,:));
        stimPairList.r1=substimList.r(pairCode.r(1,:));
        stimPairList.r2=substimList.r(pairCode.r(2,:));
        
        stimulusList1=[stimPairList.w1 stimPairList.e1 stimPairList.r1];
        stimulusList2=[stimPairList.w2 stimPairList.e2 stimPairList.r2];
        
        %         stimulusCode=randperm(size(stimulusList1,2));
        %         stimulusList1=stimulusList1(stimulusCode);
        %         stimulusList2=stimulusList2(stimulusCode);
        
    else
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % general form:
        
        numOfkeys=length(varargin);
        
        for iKey=1:numOfkeys
            rspCount=zeros(1,numOfkeys);
            for iStim=1:numOfstim
                if strcmp(responseList{iStim},varargin{iKey})
                    rspCount(iKey)=rspCount(iKey)+1;
                end
            end
        end
        
        subLength=rspCount.*(rspCount-1)./2;
        startIndex=[1 subLength+1];
        for iKey=1:numOfkeys
            substimList=cell(1,rspCount(iKey));
            iSub=1;
            for iStim=1:numOfstim
                if strcmp(responseList{iStim},varargin{iKey})
                    substimList{iSub}=stimulusList{iStim};
                    iSub=iSub+1;
                end
            end
            
            [pairCode(1,:),pairCode(2,:)]=Pairing(rspCount(iKey));
            stimPairList1=substimList(pairCode.w(1,:));
            stimPairList2=substimList(pairCode.w(2,:));
            
            stimulusList1(startIndex(ikey):subLength(ikey+1))=stimPairList1;
            stimulusList2(startIndex(ikey):subLength(ikey+1))=stimPairList2;
        end
        
        %         stimulusCode=randperm(size(stimulusList1,2));
        %         stimulusList1=stimulusList1(stimulusCode);
        %         stimulusList2=stimulusList2(stimulusCode);
    end
    
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % vector input:
    rspRange=unique(responseList);
    subStimListPair=cell(length(rspRange),2);
    for i=1:length(rspRange)
        index=responseList==rspRange(i);
        subStimList=stimulusList(index);
        [pairIndex1,pairIndex2]=Pairing(sum(index));
        subStimListPair{i,1}=subStimList(pairIndex1);
        subStimListPair{i,2}=subStimList(pairIndex2);
    end
    if size(stimulusList,1)>size(stimulusList,2)
        stimulusList1=cat(1,subStimListPair{:,1});
        stimulusList2=cat(1,subStimListPair{:,2});
    else
        stimulusList1=cat(2,subStimListPair{:,1});
        stimulusList2=cat(2,subStimListPair{:,2});
    end
end

% random permute the list:
len=size(stimulusList1,1)*size(stimulusList1,2);
randIndex=randperm(len);
stimulusList1=stimulusList1(randIndex);
stimulusList2=stimulusList2(randIndex);

end

