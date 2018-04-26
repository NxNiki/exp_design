function [PressKey,ReactionTime]=RecordResponse(IntervalForResponse,ResponseKey,ResponseForNext)
% written on the basis of WaitTill.m
% this function will wait for IntervalForResponse seconds end even if get a
% response. (on condition that ResponseForNext is set to 0)
% and will return the reaction time rather than the time point when a
% response is detected.
% by Niki 2012/5/23
%{
% add defult settings --- Niki 2012/9/24

% this function may have problem in recording RT if called too fast e.g.
% for i=1:50
% [a,b]=RecordResponse(5,'s',1)
% end

% and:

% for i=1:20
% [a,b]=RecordResponse(5,'s',1)
% WaitSecs(2);
% i
% end
% --- by Niki 2013/4/30

% define StartTime as persistent variable to inhibit record when the
% function is called too frequently. The function will return
% LastResponse and LastReactionTime if it has been called within
% LazyInterval seconds before. it is STRONGLY RECOMMENDED to use a keyboard
% wiht PS port rather than USB port, in order to get accurate, and
% sometimes (when real time feedback displaying is needed) correct reaction
% time.
% --- by Niki 2013/5/1

% change while loop according to the updated WaitTill function:
% old: while GetSecs<EndSecs
% new: while 1, break inside the loop if EndSecs arrive.
% maybe it is faster...
% --- by Niki 2013/6/1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% problem caused by global variable again: the PressKey output mistakenly
% be assigned the variable LastRespose in function SUBSEQUENT_MEMORY_TEST
% and the reaction time is extermely tiny. edf file in DataViewer shows the
% interval during this function is just 2-4 ms. It is strange for sometimes
% it returns the correct RT, except for the first trial. And also OK when
% testing only 3 trials and 6 filler.
% the reason is unclearly yet. Now the global variable has been all
% cancelled. As to the problem in the real time feed back script: Evaluate,
% just add: while KbCheck; end after this function to wait for the key
% press release. Anyway this make the code clean, we avoid global variable
% when alternative solution exists.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% add while KbCheck; end in the front of the script so solve the problem of
% tiny RT in real time feedback situation, beside, it can cope with the
% situation in which key is persistently pressed in order to get a fast
% response :)
% --- by Niki 2013/6/2
%}

startTime=GetSecs;


% hold on while key is pressed:
while KbCheck; end

if nargin<3
    ResponseForNext=1;
    disp('RecordResponse: default setting: ResponseForNext=1')
elseif nargin<2
    ResponseKey={'k','j'};
    disp('RecordResponse: default ResopnseKey: k j')
elseif nargin<1
    IntervalForResponse=5;
    disp('RecordResponse: default IntervalForStimulus: 5 seconds')
end


EndSecs=startTime+IntervalForResponse;

PressKey='';
try, FlushEvents; end %#ok in case GetChar is used, clear buffer
while 1
    [kk, tt] = ReadKey(ResponseKey);
    if  ~isempty(kk) && isempty(PressKey)
        PressKey     = kk;
        clickSec     = tt;
        if ResponseForNext,break; end
    end
    if tt>EndSecs,break;end
end
FlushEvents('keyDown');

if ~isempty(PressKey)
    ReactionTime = clickSec-startTime;
else
    ReactionTime=nan;
end


end
