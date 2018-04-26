
% 'PRESS ANY KEY TO START NEXT STAGE, PRESS ESC TO QUIT'
% by Niki 2013/9/9.
function littlebreak(interval)

if nargin==0
    interval=5;
end

commandwindow
disp('PRESS ANY KEY TO START NEXT STAGE, PRESS ESC TO QUIT')

% Wait for keypress
%     DisableKeysForKbCheck([1:26,28:31,33:256]);
[~,keyCode] = KbWait([],2,interval+GetSecs);
key         = KbName(keyCode);
pause       = strcmp(key,'esc')||strcmp(key,'ESCAPE');
%     DisableKeysForKbCheck([]);

if pause
    disp('littlebreak: ''esc'' has been pressed to pause the experiment!')
    FlushEvents('keyDown')
    sca
    commandwindow
    ListenChar(0)
    clear all
    return
end

% Wait for key release...
while KbCheck; end;

disp('littlebreak: GO ON FOR NEXT STAGE!')