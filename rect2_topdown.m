function [left,top,right,bottom]=rect2_topdown(im_width,im_height,width,height)
% caculate position of images according to size of image and window. 2
% images are put at the top (i=1) or down (i=2) part in the window.
% by Niki 2013/6/28.

shrinkRatio=max([im_width/width*2,im_height/height*2]);

im_width=im_width/shrinkRatio;
im_height=im_height/shrinkRatio;

left=zeros(1,2);
top=zeros(1,2);

for i=1:2
    left(i) = (width-im_width)/2;
    top(i)  = (i-1)*height/2;
end

right  = left+im_width;
bottom = top+im_height;
