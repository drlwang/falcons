function [ data_out, file_heading, file_ending ] = readcrd( filename , strfmt,headline,endline)
%READCRD read the .CRD file to get the station information
%   
% CALL:  
%
%
% IN: 
%   filename    [str]       input .CRD file 
%   
%   strfmt      [array][N*2]discrip the crd file format
%
%   headline    [scale]     number of headlines
%
%   endline     [scale]     number of endlines
%   
% OUT
%   data_out    [cellstr] 1*N   all the read data
%
%   file_heading [string]
%
%   file_ending  [string]
%
%  
%
% L. Wang @ BKG 20180111
%
% NOTE: 

% initial result in char format
narginchk(1, 4);

if nargin<4 || isempty(endline), endline = 0;end
if nargin<3 || isempty(headline), headline = 0;end
if nargin<2 || isempty(strfmt)
    strfmt =[1 ,3;
        6,9;
        11,19;
        23,36;
        38,51;
        53,66;
        71,71];
end



% give the headline number
headline = 6;
endline = 22;

% store the final result
sec_num = length(strfmt(:,1));
data_out = cell(1,sec_num);




% load all ASCII as string
data_all = fileread(filename);
data_all = strsplit(data_all,'\n','CollapseDelimiters',false)';

l_length = cellfun('length',data_all);

line_num = length(l_length);

sec_length = strfmt(:,2)-strfmt(:,1)+1;

data_all = char(data_all);

% extract the file heading
if endline>0
    file_ending = data_all(end-endline:end,:);
    data_all(end-endline:end,:)=[];
else
    file_ending=[];
end

% extract the file ending
if  headline>0
    file_heading = data_all(1:headline,:);
    data_all(1:headline,:)=[];
else
    file_heading=[];
end

% initialization of the cell for the output data
for idx = 1:sec_num
    data_out{idx} =data_all(:,strfmt(idx,1):strfmt(idx,2)) ;
end



end


