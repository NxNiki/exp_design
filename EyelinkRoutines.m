
function [el,width,height,edfFileName]=EyelinkRoutines(fileName,subjectID,disToTop,disToBottom)

dummymode=0;

% define edfFile to store eye movement data:
edfFileName=SetEdffile(fileName,subjectID);

% it is better to put step 3 before step 1 when trying to run in
% non-dummymode without eye tracking system connected

% STEP 3
% Initialization of the connection with the Eyelink Gazetracker.
% exit program if this fails.
if ~EyelinkInit(dummymode)
    fprintf('Eyelink Init aborted.\n');
    % Shutdown Eyelink:
    Eyelink('Shutdown');
    
    % Close window:
    sca;
    commandwindow;
    ShowCursor;
    % Restore keyboard output to Matlab:
    ListenChar(0);
    return;
end

% STEP 1
% Open a graphics window on the main screen
screenNumber = max(Screen('Screens'));
window       = Screen('OpenWindow', screenNumber);
[width, height]  = Screen('WindowSize', window);

% STEP 2
% Provide Eyelink with details about the graphics environment
% and perform some initializations. The information is returned
% in a structure that also contains useful defaults
% and control codes (e.g. tracker state bit and Eyelink key values).
el=EyelinkInitDefaults(window);

[~, vs]=Eyelink('GetTrackerVersion');
fprintf('Running experiment on a ''%s'' tracker.\n', vs );

% open file for recording data
i = Eyelink('Openfile', edfFileName);
if i~=0
    fprintf('Cannot create EDF file ''%s'' ', edfFileName);
    cleanup;
    return;
end

% Pre-Trial Message Commands
% The following message commands, if defined, MUST be sent to the EyeLink data file
% prior to the Trial Start message defined above  (i.e., outside the scope of a trial as defined
% for the viewer). If they are sent during trial recording, these messages will not be
% interpreted. (but this message is listed in the Data Viewer when sent during the trial recording...Niki)
Eyelink('message', 'DISPLAY_COORDS %ld %ld %ld %ld', 0, 0, width-1, height-1);

%     	## screen_distance = <mm to center> | <mm to top> <mm to bottom>
% 	;; Used for visual angle and velocity calculations.
% 	;; Providing <mm to top> <mm to bottom> parameters will give better estimates than <mm to center>
% 	;; <mm to center> = distance from display center to subject in millimeters.
% 	;; <mm to top> = distance from display top to subject in millimeters.
% 	;; <mm to bottom> = distance from display bottom to subject in millimeters.
Eyelink('command', 'screen_distance %d %d',disToTop,disToBottom);

% STEP 4
%     % Do setup and calibrate the eye tracker
%     EyelinkDoTrackerSetup(el);
%     % do a final check of calibration using driftcorrection
%     % You have to hit esc before return.
%     EyelinkDoDriftCorrection(el);

% STEP 5
% SET UP TRACKER CONFIGURATION
% Setting the proper recording resolution, proper calibration type,
% as well as the data file content;
Eyelink('command','screen_pixel_coords = %ld %ld %ld %ld', 0, 0, width-1, height-1);
% set calibration type.
Eyelink('command', 'calibration_type = HV9');
% set parser (conservative saccade thresholds)
Eyelink('command', 'saccade_velocity_threshold = 35');
Eyelink('command', 'saccade_acceleration_threshold = 9500');
% set EDF file contents
Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON');
Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS');
% set link data (used for gaze cursor)
Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON');
Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS');
% allow to use the big button on the eyelink gamepad to accept the
% calibration/drift correction target
Eyelink('command', 'button_function 5 "accept_target_fixation"');    % some routines about the eye tracking system:

HideCursor;
% Passing a value of 2 will enable
% listening, additionally any output of keypresses to Matlab windows is
% suppressed. Use this with care, if your script aborts with an error,
% Matlab may be left with a dead keyboard until the user presses CTRL+C to
% reenable keyboard input.
ListenChar(2);


