function yyyy = yy2yyyy(YY)
%YY2YYYY convert two digits year format to four digits
%   
% CALL:  
%
%
% IN: 
%   YY    [str]/[N*1]array  SINEX/GNSS two digits year format
%
%   
% OUT
%   yyyy  [N*1]   a list of the year with four letter format
%
%
% L. Wang @ BKG 20180111
%
% NOTE: This code is not perfect A.T.M.; 
%       1. heading is included in the first block
%       2. the save line number is in error, both for begin line and end
%       line (due to this is not really used in the future, no need to change)
%
%       3 do not exclude comment lines in the sinex file


% if input is char foramt change to numbers
if ischar(YY)
    YY = str2num(YY);
end

H_21st = YY<=50;

yyyy = zeros(size(YY));

yyyy(H_21st) = YY(H_21st) +2000;
yyyy(~H_21st) = YY(~H_21st) +1900;