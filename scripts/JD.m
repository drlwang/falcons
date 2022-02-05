% This function is for converting the time to julian data. It is supported to 
% the vector input
% IN:
%   -yy: year
%   -mm: month; defaut zeros with the same size like year
%   -dd: day; defaut zeros with the same size like year
%   -hour: hour (24 hour format); defaut zeros with the same size like year
%   -minute: minute, no second input, second can transfer to minute; defaut
%   zeros with the same size like year
% OUT:
%   - JD: julian date
%------------------------------------------------------------------------
% Lin, WANG; Uni-Stuttgart; TU Delft

function y=JD(yy,mm,dd,hour,minute)

if (nargin > 5), error('Too Many Input!\n'); end
if (nargin < 5), minute=zeros(size(yy)) ; end
if (nargin < 4), hour=zeros(size(yy)) ; end
if (nargin < 3), dd=ones(size(yy)) ; end
if (nargin < 2), mm=ones(size(yy)) ; end
if (nargin < 1), error('Too Few Input! At least put a year!\n') ; end

% if input is an array aready
% if length(yy())


if ~isa(hour,'numeric'), error('Please use 24 hour format for hours!');end

MaxL = max([length(yy),length(mm),length(dd),length(hour),length(minute) ]);
MinL = min([length(yy),length(mm),length(dd),length(hour),length(minute) ]);

if MaxL~=MinL
    error 'the input data is not in the same size!!'
end
    
ymod = yy;
H = mm<3;
ymod(H) = ymod(H) -1;


mmod = mm;
mmod(H)=mmod(H)+12;


A = floor (ymod ./ 100);
B = 2 - A + floor ( A./4 );
y = floor (365.25 .* ymod)+floor (30.6001.*(mmod+1))+ dd + B+ 1720994.5;
y=y+hour./24+minute./1440;