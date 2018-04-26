% determine the name of stimulus according to the codeList
% by Niki 2012/12/3

function stimList=StimulusCode(codeList,headString,tailString)

[rows,cols]=size(codeList);
stimList=cell(rows,cols);

for i=1:rows
    for j=1:cols
        stimList{i,j}=[headString sprintf('%03d',codeList(i,j)) tailString];
    end
end
