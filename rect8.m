function [left, top, right, bottom]=rect8(img_width,img_height,screen_width,screen_height,i)
% put 8 images on screen (2 rows with 4 in each row) 
% calculate position of the ith image
% by Niki

if nargin<5
    i=1:8;
end

shrinkRatio=max([img_width/screen_width*4,img_height/screen_height*2]);
img_width=img_width/shrinkRatio;
img_height=img_height/shrinkRatio;
left=mod(i-1,4)*screen_width/4;
right  =left+img_width;
top    =screen_height/2+((i-4.5)/abs(i-4.5)-1)/2*img_height;
bottom =top+img_height;   
