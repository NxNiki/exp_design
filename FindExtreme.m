function [largest,largeind,smallest,smallind]=FindExtreme(vector,n) 
% find the largest and smallest n elements in a vector.


% change the code by using sort
% by Niki 2013/11/25

if nargin<3
    n=3;
end


% the old code:
% largest=[];
% smallest=[];
% 
% j=0;
% while length(largest)<number
% largest=find(vector>=max(vector)-j);
% j=j+1;
% end
% 
% j=0;
% while length(smallest)<number
% smallest=find(vector<=min(vector)+j);
% j=j+1;
% end


[V,I]=sort(vector);

largest=sort(vector(vector>=V(length(V)-n+1)));
smallest=sort(vector(vector<=V(n)));

largeind=I(length(I)-length(largest)+1:end);
smallind=I(1:length(smallest));
