function latinSquare=CreateLatinSquare(n,interleave)
% create a latinsquare with order: n
% by Niki ---2012/9/18
% the interleave style has a better order balance especially if n is
% large, to get a latinsquare with interleve style: CreatLatinSquare(n,1).
% by Niki---2013/3/18
% rewrite alghrithm to imporve speed
% by Niki 2014/7/1

% test:
if nargin==0
    CreateLatinSquare(10,1)
    CreateLatinSquare(9,0)
    CreateLatinSquare(10,0)
    CreateLatinSquare(9,1)
    return
end

if nargin<2
    interleave=1;
end

latinSquare=nan(n);
latinSquare(:,1)=1:n;

if interleave==1
    shiftsize=(.5-mod(1:n-1,2))/.5.*ceil((1:n-1)/2);
else
    shiftsize=n-1:-1:1;
end

for col=2:n
    latinSquare(:,col)=circshift((1:n)',shiftsize(col-1));
end


% previous code:===========================================================
% function latinSquare=CreateLatinSquare(n,interleave)
% %% first row of latin square:
% % interleave style
% if interleave
%     halfValue=ceil(n/2);
%     % first half of the list, an extra value is needed when n is an even number
%     list1=1:halfValue+1;
%     % second half:
%     list2=n:-1:halfValue+1;
%     % 1st column of latin square:
%     latinSquare(:,1)=1:n;
%
%     for i=2:n
%         % even place:
%         if mod(i,2)
%             % put number in the 2nd list in reverse order in this place
%             latinSquare(1,i)=list2((i-1)/2);
%         else
%             latinSquare(1,i)=list1(i/2+1);
%         end
%     end
% % normal style:
% else
%     latinSquare(1,:)=1:n;
% end
%
%
% %% the rest rows:
% for i=2:n
%     for j=2:n
%         if latinSquare(i-1,j)==n
%             latinSquare(i,j)=1;
%         else
%             latinSquare(i,j)=latinSquare(i-1,j)+1;
%         end
%     end
% end

