function [blockformat,exp_str ]= loadblkfmt (blkname)
%loadblkfmt this program loads the different block format
%   
% CALL:  
%
%
% IN: 
%   blkname     [str]       give the block name which need to match the
%                       exist block according to SINEX file format 2.02
%   
% OUT
%   blockformat [N*2]array   a matrix which indecating the begin and end
%                       columns for each value in dataset
%   exp_str     [cellstr, N*3]    First column:an explaination file for each variable  
%                                 Second Column:an variable type indicator to know what the
%                            data type of each variable, such as 'double',
%                            'string', 'int', 'logical' etc.
%                                  Third Column: unit
%
% L. Wang @ BKG 2018.01.11
%
% NOTE: 

% predefined block names of SINEX 2.02

% allblknames = fileread('blocknames.txt');
% allblknames = strsplit(allblknames,'\n','CollapseDelimiters',false)';

if strcmpi(blkname,'SITE/ID')
 % format of SITE/ID
 blockformat = [1 1; % space for real data
     2 5; % stat ID
     7 8; % pointcode
     10 18; %monument/Domes
     20 20; %obs tech
     22 43; % site discription
     45 47; % longitude degree
     49 50; % longitude minute
     52 55; % longitude second
     57 59; % latitude degree
     61 62; % latitude minute
     64 67; % latitude second
     69 75; % approximate height
     ];
 
 exp_str = {'flg_comment','statID','pointcode','monument_Domes','obs_tech',... First Column: description
     'site_discription','longitude_degree','longitude_min','longitude_sec',...
     'latitude_degree','latitude_min','latitude_sec','approximate height'; 
     'empty','string','string','string','string', ... Second Column: variable type
     'string','int','int','double', ...
     'int','int','double','double';
     [],[],[],[],[],...  third column: unit
     [],'degree','minute','second','degree',...
     'minute','second','meter'     }';
 
elseif strcmpi(blkname,'SITE/RECEIVER')
 blockformat = [1 1; % space for real data
     2 5; % stat ID
     7 8; % pointcode
     10 13; % SOLN, solution ID
     15 15; %obs tech
     17 18; % start time,year
     20 22; % start time,doy
     24 28; % start time,second
     30 31; % end time,year
     33 35; % end time,doy
     37 41; % end time,second
     43 62; % Receiver Name& Model
     64 68; % Receiver SN code
     70 80; % Receiver Firmware
     ];
 
 exp_str = {'flg_comment','statID','pointcode','solution_id','obs_tech',... First Column: description
     'start_YY','start_DoY','start_sec','end_YY','end_DoY',...
     'end_sec','receiver_name','receiver_SN','receiver_FW';
     'empty','string','string','string','string', ... Second Column: variable type
     'int','int','int','int', 'int',...
     'int','string','string','string';
     [],[],[],[],[],...  third column: unit
     'year','day','second','year','day',...
     'second',[],[],[]     }';
 
elseif strcmpi(blkname,'SITE/ANTENNA')
     blockformat = [1 1; % space for real data
     2 5; % stat ID
     7 8; % pointcode
     10 13; % SOLN, solution ID
     15 15; %obs tech
     17 18; % start time,year
     20 22; % start time,doy
     24 28; % start time,second
     30 31; % end time,year
     33 35; % end time,doy
     37 41; % end time,second
     43 62; % antenna Name& Model
     64 68; % antenna SN code
     ];
 
 exp_str = {'flg_comment','statID','pointcode','solution_id','obs_tech',... First Column: description
     'start_YY','start_DoY','start_sec','end_YY','end_DoY',...
     'end_sec','antenna_name','antenna_SN';
     'empty','string','string','string','string', ... Second Column: variable type
     'int','int','int','int', 'int',...
     'int','string','string';
     [],[],[],[],[],...  third column: unit
     'year','day','second','year','day',...
     'second',[],[]     }';

elseif strcmpi(blkname,'SITE/GPS_PHASE_CENTER')
     blockformat = [1 1; % space for real data
     2 21; % antenna_name
     23 27; % antenna_SN
     29 34; % L1_offset_Up
     36 41; % L1_offset_North
     43 48; % L1_offset_East
     50 55; % L2_offset_Up
     57 62; % L2_offset_North
     64 69; % L2_offset_East
     71 80; % calibration_model
     ];
 
 exp_str = {'flg_comment','antenna_name','antenna_SN','L1_offset_Up','L1_offset_North',... First Column: description
     'L1_offset_East','L2_offset_Up','L2_offset_North','L2_offset_East','calibration_model';
     'empty','string','string','double','double', ... Second Column: variable type
     'double','double','double','double', 'string';
     [],[],[],'meter','meter', ...  third column: unit
     'meter','meter','meter','meter',[]}';

elseif strcmpi(blkname,'SITE/ECCENTRICITY')
     % format of SOLUTION/EPOCHS
    blockformat = [1 1; % space for real data
     2 5; % stat ID
     7 8; % pointcode
     10 13; %solution ID
     15 15; %obs tech
     17 18; % start epoch YY
     20 22; % start epoch Doy
     24 28; % start epoch second
     30 31; % end epoch YY
     33 35; % end epoch Doy
     37 41; % end epoch second
     43 45; % ecc_reference_system
     47 54; % ecc_up_x
     56 63; % ecc_north_y
     65 72; % ecc_east_z
     ];
 
 exp_str = {'flg_comment','statID','pointcode','solution_ID','obs_tech',... First Column: description
     'start_YY','start_DoY','start_sec','end_YY','end_DoY',...
     'end_sec','ecc_reference_system','ecc_up_x','ecc_north_y','ecc_east_z';
     'empty','string','string','string','string', ... Second Column: variable type
     'string','int','int','int', 'int',...
     'int','string','double','double','double';
     [],[],[],[],[], ...  third column: unit
     'year','day','second','year','day', ...
     'second',[],'meter','meter','meter'};
     
elseif strcmpi(blkname,'SOLUTION/EPOCHS')

     % format of SOLUTION/EPOCHS
    blockformat = [1 1; % space for real data
     2 5; % stat ID
     7 8; % pointcode
     10 13; %solution ID
     15 15; %obs tech
     17 18; % start epoch YY
     20 22; % start epoch Doy
     24 28; % start epoch second
     30 31; % end epoch YY
     33 35; % end epoch Doy
     37 41; % end epoch second
     43 44; % mean epoch YY
     46 48; % mean epoch Doy
     50 54; % mean epoch second
     ];
 
 exp_str = {'flg_comment','statID','pointcode','solution_ID','obs_tech',... First Column: description
     'start_YY','start_DoY','start_sec','end_YY','end_DoY',...
     'end_sec','mean_YY','mean_DoY','mean_sec';
     'empty','string','string','string','string', ... Second Column: variable type
     'string','int','int','int', 'int',...
     'int','int','int','int';
     [],[],[],[],[], ...  third column: unit
     'year','day','second','year','day', ...
     'second','year','day','second'};
 
elseif strcmpi(blkname,'SOLUTION/ESTIMATE') || ...
    strcmpi(blkname,'SOLUTION/APRIORI') 
    % format of SOLUTION/ESTIMATE
    
    blockformat = [1 1; % space for real data
     2 6; % parameter index
     8 13; % parameter type
     15 18; % site code
     20 21; %point code
     23 26; % solution iD
     28 29; % estimate epoch YY
     31 33; % estimate epoch doy
     35 39; % estimate epoch second
     41 44; % unit
     46 47; % constrain applied
     48 68; % estimated value
     70 80; % standard deviation
     ];
 
 exp_str = {'flg_comment','parameter index','parameter type','site code','point code',... First Column: description
     'solution iD','epoch YY','epoch DOY','epoch sec','unit',...
     'constrain code','estimated value','standard deviation';
     'empty','string','string','string','string', ... Second Column: variable type
     'string','int','int','int', 'string',...
     'string','double','double';
     [],[],[],[],[], ...  third column: unit
     [],'year','day','second',[],...
     [],'specified','specified'}';

elseif strcmpi(blkname,'SOLUTION/STATISTICS') 
        blockformat = [1 1; % space for real data
     2 31; % _STATISTICAL PARAMETER________
     33 54; % __VALUE(S)____________
     ];
%  
 exp_str = {'flg_comment','statistical parameter','value'}';
 
elseif  strcmpi(blkname,'SOLUTION/MATRIX_APRIORI L COVA') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_APRIORI U COVA') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_APRIORI L CORR') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_APRIORI U CORR') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_APRIORI L INFO') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_APRIORI U INFO') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_ESTIMATE L COVA') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_ESTIMATE U COVA') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_ESTIMATE L CORR') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_ESTIMATE U CORR') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_ESTIMATE L INFO') || ...
        strcmpi(blkname,'SOLUTION/MATRIX_ESTIMATE U INFO') 
    
    % CORR - correlation matrix
    % COVA - covariance matrix
    % INFO - information matrix (of Normals) ie COVA^(-1)
    
    % L -lower triangular form
    % U -upper triangular form
    
    blockformat = [1 1; % space for real data
     2 6; % row_index
     8 12; % column_index
     14 34; % element_row_column; element at (row,column)
     36 56; % element_row_column_p1; element at (row,column+1)
     58 78; % element_row_column_p2; element at (row,column+2)
     ];
 
 exp_str = {'flg_comment','row_index','column_index','element_row_column','element_row_column_p1',... First Column: description
     'element_row_column_p2';
     'empty','int','int','double','double', ... Second Column: variable type
     'double';
     [],[],[],[],[], ...  third column: unit
     []}';
    
        
        
    
else
    % for the undefined blocks can be extend here
    blockformat = [];
    exp_str = [];
end