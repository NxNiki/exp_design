function [code1, code2] = ExpDesign(levelList)
% by Niki 2014/6/29
% add code1 by Niki 2015/1/26

% see also RandomGroup.m

%{
ExpDesign([3,2,2,2,45])
ExpDesign([3,4,2,2])
ExpDesign([3,3,2,2])
ExpDesign([3,6,2,2])
[a,b]= ExpDesign([1,3,4])
[a,b]= ExpDesign([2,3,4])
%}

rows=prod(levelList);
cols=length(levelList);

code2=nan(rows,cols);
code1=code2;

code2(:,1)=kron(ones(1,rows/levelList(1)),1:levelList(1))';
for i=2:cols-1
    reptition = prod(levelList(1:i-1));
    code2(:,i)=kron(1:rows/reptition, ones(1,reptition))';
    code2(:,i)=mod(code2(:,i)-1,levelList(i))+1;
end
code2(:,cols)=kron(1:levelList(cols),ones(1,rows/levelList(cols)))';

% code1 has the order of rows rearranged, which is more commonly used in
% Psychological experiments. It can be obtained by sortrows(code2, 1:cols),
% but we think sort algorithms may take longer time to run.
code1(:,1)=kron(1:levelList(1),ones(1,rows/levelList(1)))';
for i=2:cols-1
    reptition = prod(levelList(i+1:cols));
    code1(:,i)=kron(1:rows/reptition, ones(1,reptition))';
    code1(:,i)=mod(code1(:,i)-1,levelList(i))+1;
end
code1(:,cols)=kron(ones(1,rows/levelList(cols)),1:levelList(cols))';
    