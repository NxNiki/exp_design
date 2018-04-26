
function ResetResult(varargin)
% build and save a new struct data set with input string as domains
% --- by Niki 2012/6/27
% change '[]' to '{}' so that the struct is 0*0 rather than 1*1 
% --- by Niki 2012/8/5
% note: input string as variables.
% e.g.ResetResult('Orientation_Resolution','Response','ReactionTime','ResponseCorrectness')

% make fileName as global variable as in other funcitons
% by Niki ---2012/9/16

% add new default field: BehaviorData and some instructions in the command
% window
% by Niki ---2012/9/16

global fileName


fprintf('ResetResult: the ResetResult will create a new .mat file named %s_Result\n',fileName)
fprintf('ResetResult: generally, this will be done if you run the script for the first time in current PC\n')
fprintf('ResetResult: if you have a .mat file with the same name in current folder, it will be overwrite!!\n')
go = input('ResetResult: enter 1 if you want to create the file\n','s');

if go=='1'
    extraDomains=length(varargin);
    for i=1:extraDomains
        if ~ischar(fileName)||~ischar(varargin{i})
            disp('please input strings as parameters!')
            return
        end
    end

    script1=strcat(fileName,'=struct(','''Date'',','{},','''Name'',','{},','''ID'',','{},','''BehaviorData'',','{}');
    for i=1:extraDomains
        script1=strcat(script1,',''',varargin{i}, ''',{}');
    end
    script1=strcat(script1,')');

    script2=['save' ' ' fileName '_Result' ' ' fileName];
    eval(script1);
    eval(script2);
end


end
