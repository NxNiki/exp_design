 function expMinutes = computeExpDur(numOfstim,stimulusInterval,interTrialInterval,fixationInterval)
% this function gives a rough estimation of the duration of the whole experiment 
expSeconds=0;
for i=1:size(numOfstim)
    if size(stimulusInterval,2)>1
        t1=stimulusInterval(i);
    else
        t1=stimulusInterval;
    end
    
    if size(interTrialInterval,2)>1
        t2=interTrialInterval(i);
    else
        t2=interTrialInterval;
    end
    
    if size(fixationInterval,2)>1
        t3=fixationInterval(i);
    else
        t3=fixationInterval;
    end
    expSeconds=expSeconds+(t1+t2+t3)*numOfstim(i);
    
end
expMinutes       = round(expSeconds/60);