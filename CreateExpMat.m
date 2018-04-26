function [ExpMat,MatLabel]=CreateExpMat(FirstInput,varargin)
% create a matrix of nan and a structure with each field representing the
% column of the matrix. If the first input is a struct, this function will
% regard it as a Matlabel and add new fields to it. ExpMat will only have
% one row.
% by Niki 2013/5/31
% initialize the matrix as -1, as 0 may have meaning in ExpMat.
% by Niki 2013/6/4
% add case for nargin==2
% by Niki 2013/11/26
% initialize the matrix as nan.
% by Niki 2013/12/6
% updata Matlabel if the first input is a struct.
% by Niki 2014/4/14
% refine code creating structure if the first input is not a structure.
% by Niki 2014/12/29

%{
[expmat,label]=CreateExpMat(10,'a','b','c');
[~,label]=CreateExpMat(label,'d','e','f');

[expmat,label]=CreateExpMat(10,{'d','b','c'});
%}

if isstruct(FirstInput)
    MatLabel=FirstInput;
    l=length(fieldnames(MatLabel));
    Rows=1;
    
    % add new labels to struct MatLabel:
    if nargin==2&&iscell(varargin{1})
        str=varargin{1};
        for i=1:length(str)
            script=['MatLabel.' str{i} '=' num2str(i+l) ';'];
            eval(script)
        end
    else
        for i=1:nargin-1
            script=['MatLabel.' varargin{i} '=' num2str(i+l) ';'];
            eval(script)
        end
    end
else
    Rows=FirstInput;
    % create MatLabel as a structure:
    if nargin==2&&iscell(varargin{1})
        str=varargin{1};
        MatLabel=cell2struct(num2cell(1:length(str)),str,2);
    else
        MatLabel=cell2struct(num2cell(1:length(varargin)),varargin,2);
    end
end

Cols=size(fieldnames(MatLabel),1);
ExpMat=nan(Rows,Cols);

end