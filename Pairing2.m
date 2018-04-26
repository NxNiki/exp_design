function [list1,list2]=Pairing2(n1,n2)
tempList1=1:n1;
for i=1:n2
    start=(i-1)*n1;
    list1(start+1:start+n1)=tempList1;
end
tempList2(1:n1)=1;
for i=1:n2
    start=(i-1)*n1;
    list2(start+1:start+n1)=tempList2+i-1;
end

randomIndex=randperm(numel(list1));

list1=list1(randomIndex);
list2=list2(randomIndex);


end
