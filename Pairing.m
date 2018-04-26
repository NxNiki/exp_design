% generate 2 lists representing all pairs of number from 1 to n.
% --- by Niki 2012/9/26

% find a bug of reduplicate and missing pairs in the last row when n is
% even numbers. as in that case we just use the first half of the last
% row. fix it by changing lag=i+1 to lag=1, anyhow, we will repermute the
% order to avoid same items in adjacent place.
% --- by Niki 2012/9/28

function [list1,list2,LIST1,LIST2]=Pairing(n)
tic
totalComp=sum(1:n-1);

% loop=totalComp/n;
% also (n-1)/2, this may be half plus an integer if n is an even number
loop=ceil((n-1)/2);

matrix1(1:loop,1)=1;
for i=1:loop
    % filling the ith row:
    newHead=2;
    lag=1;
    for j=2:n
        % filling the jth column in 1th row, each column equals the
        % previous column plus lag(i+1):
        matrix1(i,j)=matrix1(i,j-1)+lag;
        % start with a new number if we get a number bigger than n:
        if matrix1(i,j)>n
            matrix1(i,j)=newHead;
            newHead=newHead+1;
        end
    end
end

matrix2=zeros(size(matrix1));
for i=1:loop
    matrix2(i,:)=matrix1(i,:)+i;
    % search for the indexes of which the items are bigger than n:
    index=find(matrix2(i,:)>n);
    matrix2(i,index)=matrix2(i,index)-n;
end

if n<=3
    list1=matrix1;
    list2=matrix2;
else
    matrix1=matrix1';
    matrix2=matrix2';
    list1=matrix1(1:totalComp);
    list2=matrix2(1:totalComp);
end


% these lists may still have same item in adjacent pairs, adjusting ...
maxList=10;
totalList=1;
LIST1(totalList,:)=list1;
LIST2(totalList,:)=list2;
ADJ(totalList)=-1;
while 1
    adjacent=0;
    % check for same item in adjacent place
    for i=1:totalComp-1
        % update the LIST on each loop:
        lastLIST=[list1;list2];
        % same item in adjacent pairs
        if list1(i)==list1(i+1)||list2(i)==list2(i+1)||list2(i)==list1(i+1)||list1(i)==list2(i+1)
            adjacent=adjacent+1;
            % if coming to the end
            if i==totalComp-1
                % interchanging the last and 1st pairs:
                list1(i+1)=lastLIST(1,1);
                list1(1)=lastLIST(1,i+1);
                list2(i+1)=lastLIST(2,1);
                list2(1)=lastLIST(2,i+1);
            else
                % interchanging the i+1th and i+2th pairs:
                list1(i+1)=lastLIST(1,i+2);
                list1(i+2)=lastLIST(1,i+1);
                list2(i+1)=lastLIST(2,i+2);
                list2(i+2)=lastLIST(2,i+1);
            end
        end
    end
    ADJ(totalList)=adjacent;
    if ~adjacent
        fprintf('Pairing: no adjacent items found after %d times adjusting\n',totalList)
        fprintf('Pairing: adjacent items in row%d: %d\n',[1:length(ADJ);ADJ])
        break;
    elseif totalList>=maxList
        fprintf('Pairing: adjacent items still exists after %d times adjusting\n',totalList)
        fprintf('Pairing: adjacent items in row%d: %d\n',[1:length(ADJ);ADJ])
        break;
    else
        
        % check for infinite loop:
        for i=1:totalList
            % if we come to a list same as before, infinite loop occurs:
            % we just need to chech list1 for infinit loop
            if sum(LIST1(i,:)==list1)==totalComp
                fprintf('Pairing: identical list with line %d found during adjusting after %d times adjusting\n',i,totalList)
                fprintf('Pairing: adjacent items in row%d: %d\n',[1:length(ADJ);ADJ])
                
                index=find(ADJ==min(ADJ), 1, 'last' );
                fprintf('Pairing: now select one of the list with least adjacent items, which is in line: %d\n',index)
                list1=LIST1(index,:);
                list2=LIST2(index,:);
                toc
                return
            end
        end
        totalList=totalList+1;
        LIST1(totalList,:)=list1;
        LIST2(totalList,:)=list2;
    end
end
toc



        
