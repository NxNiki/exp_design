

function ShowInstruction(instruction,textSize,textColor,background,window)
% write instruction which should be cell array of string in the opened
% window
% by Niki ---2012/9/18
%
% add window as the output variable for otherwise the the task bar of
% Windows may appear in the screen or even worse the screen may be
% minimized. (it is strange that ShowImage and ShowText work well without
% the outputing the variable: window.)
% by Niki ---2013/4/16

if nargin<5
    screenNumber = max(Screen('Screens'));
    window       = Screen('OpenWindow', screenNumber);
end

if nargin<4||isempty(background)
    % Background color will be a grey one:
    background=[128, 128, 128];
end

if nargin<3||isempty(textColor)
    textColor=[1 1 1]*0;
end

if nargin<2||isempty(textSize)
    textSize=1;
end

if nargin<1
    instruction = {'欢迎参加我们的实验'};
end

[width, height]  = Screen('WindowSize', window);
textsize=round(width/100)*textSize;

% Clear screen to background color:
Screen('FillRect', window, background);
Screen('TextSize', window, textsize);
Screen('TextFont', window, 'Helvetica');

% write instructions on window...
for i=1:size(instruction,2)
    Screen('DrawText',window, instruction{i}(:), 100, 100+i*(textsize+10),textColor);
end

Screen('DrawText', window, '按空格键继续...', 100, height-4*textsize);
%     Screen('DrawText', window, '按ESC退出...', 100, height-2*textSize);

% Flip to show the instruction:
Screen('Flip',window);

% Wait for keypress
%     DisableKeysForKbCheck([1:26,28:31,33:256]);
[~,keyCode] = KbWait;
key         = KbName(keyCode);
pause       = strcmp(key,'esc')||strcmp(key,'ESCAPE');
%     DisableKeysForKbCheck([]);

if pause
    disp('ShowInstruction: ''esc'' has been pressed to pause the experiment!')
    FlushEvents('keyDown')
    sca
    commandwindow
    ListenChar(0)
    clear all
    return
end

% Wait for key release...
while KbCheck; end;


if nargin<1
    sca
end
end