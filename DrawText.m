% same as ShowText except that it won't filp the window
% by Niki 2012/10/13.


function DrawText(window,text,size,position_x,position_y)

if nargin<5||isempty(position_y)
    position_y='center';
end
if nargin<4||isempty(position_x)
    position_x='center';
end
if nargin<3||isempty(size)
    size=1;
end

[width,height]=Screen('WindowSize',window);
textSize=round(width/100)*size;
textLength=length(text);

if strcmp(position_x,'center')
    textPosition_x=(width-1.4*textLength*textSize)/2;
elseif strcmp(position_x,'left')
    textPosition_x=textSize*2;
elseif strcmp(position_x,'right')
    textPosition_x=width-(textLength+2)*textSize;
end

if strcmp(position_y,'center')
    textPosition_y=(height-1.5*textSize)/2;
elseif strcmp(position_y,'top')
    textPosition_y=textSize*2;
elseif strcmp(position_y,'bottom')
    textPosition_y=height-textSize*2;
end

Screen('TextSize', window, textSize);
Screen('DrawText',window,text,textPosition_x,textPosition_y);

% Screen('Flip',window);
end



% (width-.8*textSize)/2, (height-1.5*textSize)/2