function [ status ] = leapyear( year )
% LEAPYEAR check the year is leapyear or not
% L.wang add command to show the git update
% 2022-01-20

year = floor(year);

logvec400 = mod(year, 400) == 0;

logvc4 = mod(year, 4) == 0;

logvec100 = mod(year, 100) ~= 0;

status = logvec400 | (logvc4 &logvec100);
% 
% 
% if mod(year, 400) == 0
% status = true;
% elseif mod(year, 4) == 0 && mod(year, 100) ~= 0
% status = true;
% else
% status = false;
% end
end