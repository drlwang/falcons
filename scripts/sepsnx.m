function [ flist, snxinfo ] = sepsnx( filename,tmpfld ,rm_head)
%SEPSNX this program seperate the SINEX file into block ASCII files
%   
% CALL:  
%
%
% IN: 
%   filename    [str]       input SINEX file (large file take long calculation time)
%   tmpfld      [str]       output folder address for the ASCII files for
%                       each block
%   
% OUT
%   flist       [cellstr]   a list of the output files
%   snxinfo     [struct]    includes the information for each block
%                       including block names, begin row, end row 
%
% L. Wang @ BKG 20180109
%
% NOTE: 
%       1. heading is included in the first block
%       2. the save line number is in error, both for begin line and end
%       line (due to this is not really used in the future, no need to change)
%
%       3 do not exclude comment lines in the sinex file
% Update: 2021-06-11 line index is corrected - problem 2 solved



narginchk(1, 3);
if nargin<3 || isempty(rm_head),rm_head = false; end

if nargin<2 || isempty(tmpfld),tmpfld = './tmp/'; end

% creat the temperal folder is not exist
if ~exist(tmpfld)
    mkdir(tmpfld);
end

% make sure temperal folder directory is correct
if ~strcmp(tmpfld(end),filesep)
    tmpfld(end+1) = filesep;
end


fid  = fopen(filename,'r');

% give error if SINEX file do not exist
if fid <0
    error([filename,'is not found']);
end

% line number index
lnum = 1;

% block number index
blknum = 1;
% block name string
blknam = [];

% temperal cellstr for speedup IO writing time
tempstr = cell(10000,1);
strnum = 1;

% this one save all the information or use for temperal export
blocks = struct('name','empty',...
    'begl',0,'endl',0,...
    'data',[]);


while ~feof(fid)
    
    
    if strnum == 1000
        % save the read data into the seperated blocks
        if rm_head
            H_rm = cellfun(@(x) x(1), tempstr(1:end-1));
            H_rm = logical(cellfun(@length,cellstr(H_rm)));
            tempstr(H_rm)=[];
            
        end
        
        for idx = 1:length(tempstr)-1
            
            fprintf(fsaveid,'%s\n',tempstr{idx});
            
        end
        strnum =1;
        tempstr =  cell(1000,1);
        strnum = strnum+1;
%         lnum = lnum+1;
        continue
    else
        tline = fgetl(fid);
        
        tempstr{strnum} = tline;
        strnum = strnum+1;
        lnum = lnum+1;
    end
    
    
    
    
    if isempty(tline)
        strnum = strnum+1;
        lnum = lnum+1;
        continue
    end
    
    
    % heading information
    if strcmp(tline(1),'%')
        if strcmpi(tline(2:7),'ENDSNX')
            break;
        end
        
        blocks(blknum).name = 'heading';
        blocks(blknum).data = tline;
        
        % save the heading into file
        fsaveid = fopen([tmpfld,blocks(blknum).name,'.txt'],'w+');
        fprintf(fsaveid,'%s \n',blocks(blknum).data);
        fclose(fsaveid);
        
        blocks(blknum).begl =lnum-1;
        blocks(blknum).endl =lnum-1;
        
        blknam = blocks(blknum).name;
        blknum = blknum+1;
        
        % reset the matrix
        strnum =1;
        tempstr =  cell(1000,1);
        
%         lnum = lnum+1;
        continue
    end
    
    % find the start of a block
    if strcmp(tline(1),'+')
        
        blocks(blknum).name = tline(2:end);
        
        % saved block data
        fsavename = [tmpfld,strrep(blocks(blknum).name,'/','_'),'.txt'];
%         fsavename = strrep(fsavename,'/','_');
        fsaveid = fopen(fsavename,'w+');
        
        
        blocks(blknum).begl = lnum-1;
        
        
        blknam = blocks(blknum).name;
        
%         lnum = lnum+1;
        continue
    end
    
    % find the end of a block
    
    if strcmp(tline(1),'-')
        
        if ~strcmp(tline(2:end),blocks(blknum).name)
%         fprintf('');
        error('the block name is not consistant');
        end
        
        
        
        if rm_head
            savetempstr = tempstr(1:strnum-1);
            H_rm = cellfun(@(x) x(1), savetempstr);
            H_rm = logical(cellfun(@length,cellstr(H_rm)));
            savetempstr(H_rm)=[];
            tempstr = savetempstr;
            strnum = length(tempstr)+1;
        end
        
        % write the temp str into the files
        
        for idx = 1:strnum-1
            fprintf(fsaveid,'%s\n',tempstr{idx});
        end
        
        % reset the matrix
        strnum =1;
        tempstr =  cell(1000,1);
        
        
        fclose(fsaveid);
        
        
        blocks(blknum).endl = lnum-1;
        
        blknum = blknum+1;
        
%         lnum = lnum+1;
        continue
    end
    
    % find the seperate row
    if isempty(tline) || length(tline)<2
%         lnum = lnum+1;
        continue
    end
    
    % find the seperate row
    if strcmp(tline(1:2),'*-')
%         lnum = lnum+1;
        continue
    end
    
    
    
    
        
    
    
end



snxinfo = blocks;
flist = cell(length(blocks),1);

for idx = 1:length(blocks)
    flist{idx} = [strrep(blocks(idx).name,'/','_'),'.txt'];
end


[~,name] = fileparts(filename);
save([tmpfld,name,'_tmp.mat'],'flist', 'snxinfo');

end

