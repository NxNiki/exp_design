function [groupList, stimList]=RandomGroup(rows,varargin)
% generate a list coding the group of stimulus and a list coding the
% stimulus.
% if you don't like the group style of this function, just set rows to be 1
% and reshape the list outside the function, that list will be totally 
% random.
% or run it several times with each time for one row. then the grouplist 
% will have same number of groups but random order in each row.:)
% --- by Niki 2012/10/8.

% see also ExpDesignMat.m

%{
% e.g. if you have 3 groups of stimulus with 5, 6 ,7 items each:
[groupList stimList]=RandomGroup(1,5,6,7)

% you can also run: 
[groupList stimList]=RandomGroup(1,0,6,7) 
% which creates two groups coded by 2 and 3 respectively.

[a,b]=RandomGroup(1,[40 40 40])


% or:  
[a,b]=RandomGroup(2,[2 2],4,4)
% which creates repeated stimulus of the 1st group in two rows


%}


groups=length(varargin);

%% this step will create a groupList like:
% RandomGroup(2,12,2,2)
% ans =
% 
%      1     1     2     1     1     3     1     1
%      1     1     2     1     1     3     1     1
columns=0;
for i=1:groups
    % check if the input rows can be divided by totalItems:
    if mod(varargin{i},rows)
        fprintf('RandomGroup: rows should be a reducible number of the number of items in each group\n')
        fprintf('RandomGroup: improper rows: %d were selected to arrange the %dth group with %d items.\n',rows,i,varargin{i})
        oldRow=rows;
        rows=1;
    end
    
    if length(unique(varargin{i}))>1&&length(varargin{i})>1
        fprintf('RandomGroup: cannot arrange the list in %d rows, generate it in 1 row\n',rows)
        rows=1;
    end
    
    tempList(columns+1:columns+sum(varargin{i}/rows))=i; 
    columns=columns+sum(varargin{i}/rows);
end

% random permutate the list:
tempList=tempList(randperm(numel(tempList)));
% generate other rows with identity items:
groupList=ones(rows,1)*tempList;


%% create the stimList according to the group list
stimList=zeros(rows,columns);
for i=1:groups
    n=length(varargin{i});
    if n>1
        if length(unique(varargin{i}))>1
            % recursion:
            script='[~,temp]=RandomGroup(1';
            for j=1:n
                script=strcat(script,',' ,num2str(varargin{i}(j)) );
            end
            script=strcat(script, ');');
            eval(script)
        else
            temp=mod(randperm(varargin{i}(1)*n),varargin{i}(1))+1;
        end
    else
        temp=randperm(varargin{i});
    end
stimList(groupList==i) = temp;
end

if exist('oldRow','var')
    columns=columns/oldRow;
    stimList=reshape(stimList,columns,oldRow)';
    groupList=reshape(groupList,columns,oldRow)';
end





