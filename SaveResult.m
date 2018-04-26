% save results according to the fileName, the result should be a struct 
% which contain subjectName, subjectId, Date, and behaviorData as fields. 
% this function helps to improve your efficiency in writing the script.
% ---by Niki

%{
% cancel the use of global variable: fileName 
% change subjectName to subjectInfo (age and gender may also be saved).
% ---by Niki 2013/4/15

% rewrite codes printing BehaviorData so that Matirx can be displayed
% properly.
% by Niki 2013/5/19

% cancel global variable: subjectID, make it input of the function instead
% by Niki 2013/5/25

% cancel global variable: BehaviorData, Date
% by Niki 2013/6/2

% put 'Result_' before fileName to construct the name of .mat file storing
% results. Just to make all result .mat files to be put together.
% by Niki ---2013/7/13

save result file in a folder: Result, it will also be saved in current
folder as a backup.
by Niki ---2013/11/18
%}



function SaveResult(fileName,Date,subjectInfo,BehaviorData)

if ~exist('Result','dir')
    mkdir Result;
end

format shorte
    try
        resultFile =['Result_' fileName];
        script     ={...
                    ['load' ' ' resultFile ' ' fileName];...% if not loading the previous variable, it will be replaced by a new variable with the same name.(the previous results will be lost then) 
                    [fileName '(subjectInfo.ID).subjectInfo=subjectInfo;'];...
%                     [fileName '(subjectID).ID=subjectID;'];...
                    [fileName '(subjectInfo.ID).Date=Date;'];...
                    [fileName '(subjectInfo.ID).BehaviorData=BehaviorData;'];...
                    ['save ' resultFile ' ' fileName];...
                    'cd Result'; ...
                    ['save ' resultFile ' ' fileName];...
                    'cd ..';...
                    };

        for i=1:length(script)
            eval(script{i})
        end
        
    catch err
        fprintf('SaveResult: Errors occur when saving experiment information ''%s''\n', resultFile )
        fprintf('SaveResult: it deserves attention and may happen in the %dth line of the function!',i)
        rethrow(err)
    end 
    
    
    % printing BehaviorData in the command window:
    fieldnameList=fieldnames(BehaviorData);
    try
        for iField=1:size(fieldnameList,1)
            fprintf('SaveResult: BehaviorData:%s\n',fieldnameList{iField})
            fprintf('SaveResult: Please check whether there are problems with BehaviorData:\n');

            script=[fieldnameList{iField},'=BehaviorData.' fieldnameList{iField} ''];
            eval(script)
        end
    catch err
        fprintf('\n')
        fprintf('SaveResult: an error occurs when displaying the behavior data\n');
        fprintf('SaveResult: take it easy as this WON''T effect the data saving process!\n')
        fprintf('SaveResult: the error may be caused by improper data type in the struct: BehaviorData\n');
%         fprintf('SaveResult: only cell type data can be displayed properly\n')
        fprintf('SaveResult: check the %dth field in struct: BehaviorData\n',iField)
        err.message
    end 
    fprintf('SaveResult: Experiment information has been successfully saved:\n')
    fprintf('SaveResult: Name:%s\n',subjectInfo.Name)
    fprintf('SaveResult: ID: %d\n',subjectInfo.ID)
    fprintf('SaveResult: Date: %s\n',Date)
    fprintf('SaveResult: Find behaviour data in ''%s'' in current folder\n',resultFile)
        


end