function imdataArray=MakeImageTexture(directory,ImageIndex,imageType)
% read images in specific directory to a cell array. we use cell array
% instead of 4-D matirx as it works well when the images are not in same
% size. 

% by Niki 2013/5/24.

% change numOfImages to ImageIndex, so that the file names need not to be
% from 1 to munOfImages. ImageIndex is a vector coding the names of images.
% by Niki

    imdataArray=cell(1,length(ImageIndex));
%     mapArray=cell(1,numOfImages);
    j=1;
    for i=ImageIndex
        filename=strcat(directory,num2str(i),imageType);
        disp(i)
        [X,map]=imread(filename);
        if isempty(map)
            imdataArray{j}=uint8(X);
        else
            imdata=ind2rgb(X,map)*255;
            imdataArray{j}=uint8(imdata);
        end            
        j=j+1;    
    end
