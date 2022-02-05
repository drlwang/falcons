function [data_out ] = readsnxblk(filename, blockformat,exp_str,flg_readfmt)
%READCRD read the block ascii file export from a sinex file
%   
% CALL:  
%
%
% IN: 
%   filename    [str]       ASCII block file
%   
%   blockformat [array][N*2]discrip the block format can load from
%               loadblkfmt.m with specified block name
%
%   exp_str     experssion cellstr for the format of block
%
%   flg_readfmt [logical]  1 read from lines 0 read from table format
%
% OUT
%   data_out    [cellstr] 1*N   all the read data
%
%  
% Note: this works for any block ecept solution matrix
% L. Wang @ BKG 20180111
%
% NOTE: 

narginchk(3, 4);
if nargin<4 || isempty(flg_readfmt),flg_readfmt = true; end



filpro = dir(filename);
% check big file or not (larger than 50MB)
flg_bigdata =  filpro.bytes/1024/1024 >50;
clear filpro;

if flg_bigdata || ~flg_readfmt
%     blktype = 'SOLUTION/MATRIX_ESTIMATE L COVA';
    
    % prepare the option for reading solution matrix
%     [blockformat,exp_str ] = loadblkfmt (blktype);
    
    opts = detectImportOptions ( filename );
    opts.VariableNames = exp_str(2:end,1)';
    
    for idx =1:length(opts.VariableNames)
        opts.VariableOptions(idx).FillValue = 0;
    end
    
    dat_table = readtable ( filename , opts);
    data_out = zeros(size(dat_table));
    for idx = 1:width(dat_table)
        data_out(:,idx) = dat_table.(exp_str{idx+1,1});
    end
%     data_out = [dat_table.(exp_str{2,1}) dat_table.(exp_str{3,1}) dat_table.(exp_str{4,1}) dat_table.(exp_str{5,1}) dat_table.(exp_str{6,1})];
    
else
    
    
    blk = fileread(filename);
    blk = strsplit(blk,'\n','CollapseDelimiters',false)';
    blk_char = char(blk);
    
    H_data = blk_char(:,1)=='*'| blk_char(:,1)=='+'|blk_char(:,1)=='-'|blk_char(:,1)=='%'; % the indicator for the data rows
    %remove all the space
    H_empty = logical(sum(~isspace(blk_char),2));
    
    H_data = ~(H_data|~H_empty);
    blk_char_new = blk_char(H_data,:);
    
    data_out = cell(1,length(blockformat(:,1)));
    
    for idx =1:length(blockformat(:,1))
        data_out{idx} = blk_char_new(:,blockformat(idx,1):blockformat(idx,2));
    end
    
end
