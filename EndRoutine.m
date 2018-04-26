
function EndRoutine
% Restore keyboard output to Matlab:
ListenChar(0);

Eyelink('Shutdown');

% Close window:
sca;
commandwindow;
ShowCursor;

end