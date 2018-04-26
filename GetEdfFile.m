function GetEdfFile(edfFile)
if ~exist('edfData','dir')
    mkdir edfData
end
cd edfData
     try
        fprintf('GetEdfFile: Receiving data file: ''%s''\n', edfFile );
        status=Eyelink('ReceiveFile');
        if status > 0
            fprintf('GetEdfFile: ReceiveFile status %d\n', status);
        end
        if 2==exist(edfFile, 'file')% checks for files or directories.
            fprintf('GetEdfFile: Data file ''%s'' can be found in ''%s''\n', edfFile, pwd );
        end
    catch err
        fprintf('GetEdfFile: Problem receiving data file: ''%s''\n', edfFile );
        cd ..
        rethrow(err)        
     end
     
cd ..
    
end