
function subjectID=SetResultFile(fileName,DefaultFields)
% this function load the result.mat file and get a subjectID.
%
% name the edf file according to the subjectID and input variable: fileName
%
% assign a name as string to the edfFlie according to some convention. the
% fileName is same as the name of the main function(e.g. EyesOnImage) and
% the subjectID is defined by the size of struct data storing the
% experiment data. The edfFile name is head+subjectID (e.g. I135.edf)
% --- by Niki
%
% add ResetResult if this function faile to load the _Result.mat file
% by Niki ---2012/9/16
%
% delete edf file naming for eye movement experiments so that it could be
% used for only behavior experiments.
%
% put the code in ResetResult in current function
% by Niki ---2013/5/19
%
% put 'Result_' before fileName to construct the name of .mat file storing
% results.
% by Niki ---2013/7/13


% DefaultFields=  { 'subjectInfo', 'Date','BehaviorData'};


try
    load(['Result_' fileName],fileName)
    %     script{1} =['load ' 'Result_' fileName ' ' fileName];
    %     eval(script{1})
catch myerr
    myerr.message
    disp('SetResultfile: no Result file found in current folder, it seems that this script is being run for the first time')
    disp('SetResultfile: or the result file has been deleted. Trying to create a .mat file to store the experiment information')
    fprintf('SetResultfile: this file is a struct with fields: %s',DefaultFields{:})
    disp('SetResultfile: you can add your customer fields in the script')
    
    fprintf('SetResultfile: the ResetResult will create a new .mat file named %s_Result\n',fileName)
    fprintf('SetResultfile: generally, this will be done if you run the script for the first time in current PC\n')
    fprintf('SetResultfile: if you have a .mat file with the same name in current folder, it will be overwritten!!\n')
    %     go = input('SetResultfile: enter 1 if you want to create the file\n','s');
    
    %     if go=='1'
    extraDomains=length(DefaultFields);
    for i=1:extraDomains
        if ~ischar(fileName)||~ischar(DefaultFields{i})
            disp('please input strings as parameters!')
            return
        end
    end
    
    script1=strcat(fileName,'=struct(''' , DefaultFields{1} ,''',{}');
    for i=2:extraDomains
        script1=strcat(script1,',''',DefaultFields{i}, ''',{}');
    end
    script1=strcat(script1,')');
    
    % script2=['save ' 'Result_' fileName ' ' fileName];
    eval(script1);
    % eval(script2);
    save(['Result_' fileName],fileName)
    %     end
    % see if the file can be loaded:
    %         script{1} =['load ' 'Result_' fileName ' ' fileName];
    %         eval(script{1})
    load(['Result_' fileName],fileName)
end
script{2} =['length(' fileName ')+1;'];
subjectID =eval(script{2});

end
