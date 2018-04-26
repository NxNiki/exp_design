% this function won't draw the background, as it is more efficient put this
% step before the loop. HideCursor is also not excuted for the same reason.

% adjusted to be able to show 2 images simultaneously, one on top, the
% other on buttom of the screen.
% --- by Niki 2012/9/27


function [top, left, imScale_x, imScale_y, VBLTimestamp, StimulusOnsetTime, FlipTimestamp, Missed, Beampos]=...
    ShowImage(window, directory, file, fullScreen,flip)
if nargin<5
    flip=1;
end
if nargin<4||isempty(fullScreen)
    fullScreen=0;
end

if iscell(file)
    numberOfImages=size(file,2);
else
    numberOfImages=1;
end

filename=strcat(directory,file);
% if the varialbe file is a cell, strcat will return a cell with same size as file

[width, height]  = Screen('WindowSize', window);

switch numberOfImages
    case 1
        imdata=imread(filename);
        [imScale_y, imScale_x, ~]=size(imdata);
        imtex1=Screen('MakeTexture', window, imdata);
        if fullScreen
            Screen('DrawTexture',window,imtex1,[],[0 0 width, height])
            top=0;
            left=0;
            imScale_x=width;
            imScale_y=height;
        elseif size(imdata,1)>height||size(imdata,2)>width            
            % adjust the size of the image in order to put it into the top and
            % bottom half of the window.
            shrinkRatio=max([imScale_x/width,imScale_y/height]);
            imScale_x=imScale_x/shrinkRatio;
            imScale_y=imScale_y/shrinkRatio;
            
            left   =(width-imScale_x)/2;
            right  =(width+imScale_x)/2;
            top    =(height-imScale_y)/2;
            bottom =(height+imScale_y)/2;
            
            Screen('DrawTexture',window,imtex1,[],[left top right, bottom])
            fprintf('ShowImage: the image %s is larger than the screen. shrink it to fit the screen.\n',filename)
        else
            Screen('DrawTexture', window, imtex1);
            left   =(width-imScale_x)/2;
%             right  =(width+imScale_x)/2;
            top    =(height-imScale_y)/2;
%             bottom =(height+imScale_y)/2;
        end
        % type: 'Screen DrawTexture?' in the command window for more details if you want to display the image in a specific manner

    case 2
        imdata1=imread(filename{1});
        imtex1=Screen('MakeTexture', window, imdata1);
        imdata2=imread(filename{2});
        imtex2=Screen('MakeTexture', window, imdata2);
        
        [imScale_y(1), imScale_x(1), ~]=size(imdata1);
        [imScale_y(2), imScale_x(2), ~]=size(imdata2);
        
        % adjust the size of the image in order to put it into the top and
        % bottom half of the window.
        shrinkRatio=max([imScale_x/width,imScale_y/height*2]);
        imScale_x=imScale_x/shrinkRatio;
        imScale_y=imScale_y/shrinkRatio;        
        
        left   =(width-imScale_x)/2;
        right  =(width+imScale_x)/2;
        top    =[0, height-imScale_y(2)];
        bottom =[imScale_y(1),height];
       
        if imScale_x(1)>=imScale_y(1)
            % put the first image on the top half of the screen:
            % the "y" pen start location defines the base line of drawn text
            % when the last parameter is set to 1:
            Screen('DrawTexture', window, imtex1,[],[left(1) top(1) right(1) bottom(1)]);       
            % put the 2nd image on the botton half of the screen:
            % the "y" pen start location defines the top of drawn text
            % when the last parameter is set to 0:
            Screen('DrawTexture', window, imtex2,[],[left(2) top(2) right(2) bottom(2)]);   
        end
    otherwise
        fprintf('ShowImage: Sorry, I cannot draw more than 2 images simultaneously :(\n')
        sca
        return
end

if flip
% Show result on screen:copy the window into the onscreen window.
[VBLTimestamp, StimulusOnsetTime, FlipTimestamp, Missed, Beampos] =Screen('Flip', window);
else
   VBLTimestamp ='';
   StimulusOnsetTime='';
   FlipTimestamp=''; 
   Missed ='';
   Beampos ='';
    
end