

function edfFileName=SetEdffile(fileName,subjectID)

% the entered EDF file name is 1 to 8 characters in length and only
% numbers or letters are allowed.(the 8.3 DOS naming conventions)
if length(fileName)>5
    fileName=fileName(1:5);
end

edfFileName=[fileName num2str(subjectID) '.edf'];

if length(edfFileName)>(8+length('.edf'))
    sca;
    fprintf('SetEdffile: the edfFlie name:''%s'' is longer than 8 charactors, please change it!',edfFileName)
    error('SetEdffile: the entered EDF file name is 1 to 8 characters in length and only numbers or letters are allowed.(the 8.3 DOS naming conventions?)')
end

