function Mat2=SortWithOrder(Mat,Vec,ColofMat)
% sort rows of matrix so that the order of specific column of Mat are same
% as that in Vec.
% by Niki 2014/7/7

dataInCol=Mat(ColofMat);
len=length(dataInCol);
var=length(unique(dataInCol));
grpLen=len/var;

if size(Vec,2)>1
    Vec=Vec';
end

Mat=sortrows(Mat,ColofMat);

if rem(grpLen,1)==0
    dataInCol_mat=reshape(sort(dataInCol),grpLen,var);
    if all(mean(dataInCol_mat,2)==var)
        Vec=repmat(Vec,1,grpLen)';
        Vec=Vec(:);
        [~,ind]=sort(Vec);
        Mat2=Mat(ind,:);
    end
end
    


