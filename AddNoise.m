function img2=AddNoise(img,percentage,PixSize)
% add noise (salt and pepper) to picture in specific percentage of pixels
% by Niki 2013/9/23.

[R,C]=size(img);
r=floor(R/PixSize);
c=floor(C/PixSize);
Ind=zeros(r,c);

NumReversePixel=round(r*c*percentage);
saltpepperPixel=randi(r*c,1,NumReversePixel);
Ind(saltpepperPixel)=1;
saltPixel=saltpepperPixel(randperm(length(saltpepperPixel),round(NumReversePixel/2)));
Ind(saltPixel)=2;

IND=Expand(Ind,PixSize,PixSize);

img2=img;
img2(IND==1)=0;
img2(IND==2)=255;