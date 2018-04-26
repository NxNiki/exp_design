function [size, position_x,position_y]=TranslateTextParameter(width,height,text,Size,Position_x,Position_y)
% postion_x and position_y should range from 1(right or up) to 10(left or
% down) or string: center, left, right, botton, top.
% by Niki 2013/4

% add case for 3 inputs with the third argument being a struct, with field
% name: text, x, y.
% add case for 1 output being one struct, with fields: size, x and y.
% by Niki 2013/11/27




if nargin<6||isempty(Position_y)||~isfield(text,'y')
    Position_y='center';
end
if nargin<5||isempty(Position_x)||~isfield(text,'x')
    Position_x='center';
end
if nargin<4||isempty(Size)||~isfield(text,'size')
    Size=1;
end

if isstruct(text)
    Size=text.size;
    Position_x=text.x;
    Position_y=text.y;
    text=text.text;
end

size=round(width/100)*Size;

% translate x position:
if isa(Position_x,'numeric')
    if Position_x>10
        Position_x=10;
    elseif Position_x<1;
        Position_x=1;
    end
    position_x=width/10*Position_x;
else
    textLength=length(text);
    
    if strcmp(Position_x,'center')
        position_x=(width-textLength*size)/2;
    elseif strcmp(Position_x,'left')
        position_x=size*2;
    elseif strcmp(Position_x,'right')
        position_x=width-(textLength+2)*size;
    end
end

% translate y position:
if isa(Position_y,'numeric')
    if Position_y>10
        Position_y=10;
    elseif Position_y<1;
        Position_y=1;
    end
    position_y=height/10*Position_y;
else
    if strcmp(Position_y,'center')
        position_y=(height-1.5*size)/2;
    elseif strcmp(Position_y,'top')
        position_y=size/2;
    elseif strcmp(Position_y,'bottom')
        position_y=height-size*2;
    end    
end

if nargout==1
    sz=size;
    clear size
    size.x=position_x;
    size.y=position_y;
    size.size=sz;
end

end
