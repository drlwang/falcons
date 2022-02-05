function [ output_args ] = savefigures( hdl,fname,fmat,flgrender,flgkill )
%SAVEFIGURES save the figure for different formats in one line for several
%formats
%   call the export_fig several times to export publication figure for a
%   higher DPI and save various files at once to make the code cleaner
% IN
%   hdl     handle      input figure
%
%   fname   string      file name for output file
%           the path can be include before the file name
%
%   fmat    cell        file format for multiple output
%           default {'-eps'} export eps file
%           for multiple file output then just give more format
%           e.g. {'-eps','-png','-fig'} then give output in those three
%           files
%
%   flgrender   bool    renderer of the ploting figure
%           '-painter'  for raster output {default}
%           '-openGL'   for transparent figure output
% Author: L. Wang
% Update: 2022-01-01 L.Wang add explaination and discriptions
% 


narginchk(2, 5);
if nargin<5||isempty(flgkill),      flgkill = false;        end
if nargin<4||isempty(flgrender),    flgrender = '-painters';end
if nargin<3||isempty(fmat),         fmat = {'-eps'};        end

if isempty(hdl)
    hdl = gcf;
end

% if there is no format indicator then code will be not run and will not store any figure
if isempty(fmat)
   return 
end

if ~iscell(fmat)
    fmat = {fmat};
end


% save the figures
for idx = 1:length(fmat)
    if ~strcmp(fmat{idx},'-fig')
        export_fig( hdl, ...    % figure handle
            fname,...           % name of output file without extension
            flgrender, ...      % renderer,
            ...                 %  -painter for image and -openGL if there are transparent parts
            fmat{idx}, ...      % file format  (-eps,-jpg,-png etc)
            '-r300' );          % resolution in dpi, 300 DPI matches the publication requirements
    else
        saveas(hdl,[fname,'.fig'],'fig')
    end
    
end

% close the figure
if flgkill
    close(hdl)
end

end

