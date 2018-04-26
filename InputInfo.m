% get information about participant:
% by Niki 2013

% code age and gender as number
% by Niki 2013/11/25


function Info = InputInfo(varargin)
    
    prompt     = {'Name', 'Age', 'Gender'};
    dlg_title  = 'Enter information of the participant:';
    num_lines  = 1;
    
    if nargin>1
        prompt=cat(2,prompt,varargin);
    end
    prompt_default=prompt;
    prompt_default(2:3)={'0','female'};
    answer     = inputdlg(prompt,dlg_title,num_lines,prompt_default);
    
    
    Info.Name=answer{1};
    Info.Age=str2double(answer{2});    
    Info.Gender=+(strcmp(answer{3},'male')||strcmp(answer{3},'ÄÐ'));% convert logic to numeric in case error in Eyelink message sending.
    
    for i=1:nargin
    eval(['Info.' prompt{i} ' = answer{i};'])
    end
    


end