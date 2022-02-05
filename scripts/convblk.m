function [dataout] = convblk(blkdata,blkname)
%CONVBLK convert the block into corresponding matrix or data to be used
% from the block table into a readable variable
% CALL:
%   [dataout] = convblk(blkdata,blkname)
% IN:
%   blkdata     a row of cell including strings
%   blkname     the block name
%
% OUT:
%   dataout     convert to numbers etc.
%
% 2021-06-16
% L. Wang @ BKG
% 

MJD0 = 2400000.5;

%load the block explaination matrix (unit and data type)
 [~,exp_str ]= loadblkfmt (blkname);
 
 
 if iscell(blkdata)
     % remove the data if it is commented
     flg_rm = ~cellfun('isempty',cellstr(blkdata{1,1}));

     if any(flg_rm)
         for idx = 1:length(blkdata)
            blkdata{idx} = blkdata{idx}(~flg_rm,:);
         end
     end
 end
 
 if strcmpi(blkname,'SITE/ID')
     % not finished so far
     dataout = cell(1,7);
     dataout{1,1} = cellstr(blkdata{1,2}); % ID
     dataout{1,2} = cellstr(blkdata{1,3}); % type
     dataout{1,3} = cellstr(blkdata{1,4}); % domes
     dataout{1,4} = cellstr(blkdata{1,6}); % discriptions
     dataout{1,5} = str2double(cellstr(blkdata{1,7}))+str2double(cellstr(blkdata{1,8}))/60+str2double(cellstr(blkdata{1,9}))/60/60; % longitude
     dataout{1,6} = str2double(cellstr(blkdata{1,10}))+str2double(cellstr(blkdata{1,11}))/60+str2double(cellstr(blkdata{1,12}))/60/60; % latitude
     dataout{1,7} = str2double(cellstr(blkdata{1,13})) ;  %height (m)        
 
 elseif strcmpi(blkname,'SOLUTION/EPOCHS')
      % not finished so far
     dataout = cell(1,7);
     dataout{1,1} = cellstr(blkdata{1,2}); % ID
     dataout{1,2} = cellstr(blkdata{1,3}); % PT
     dataout{1,3} = str2double(cellstr(blkdata{1,4})); % solution index
     dataout{1,4} = cellstr(blkdata{1,5}); % T

     dataout{1,5} = JD(yy2yyyy(str2double(cellstr(blkdata{1,6}))))-MJD0 ...
         + str2double(cellstr(blkdata{1,7})) + str2double(cellstr(blkdata{1,8}))./86400; % start date
     
     dataout{1,6} = JD(yy2yyyy(str2double(cellstr(blkdata{1,9}))))-MJD0 ...
         +str2double(cellstr(blkdata{1,10}))+str2double(cellstr(blkdata{1,11}))./86400; % end date
     
     dataout{1,7} = JD(yy2yyyy(str2double(cellstr(blkdata{1,12}))))-MJD0 ...
        +str2double(cellstr(blkdata{1,13}))+str2double(cellstr(blkdata{1,14}))./86400; % mean date
     

     
 elseif strcmpi(blkname,'SOLUTION/ESTIMATE') || ...
        strcmpi(blkname,'SOLUTION/APRIORI') 
     
     dataout = cell(1,10);
     
     dataout{1,1} = str2double(cellstr(blkdata{1,2})); % index
     dataout{1,2} = cellstr(blkdata{1,3}); % type
     dataout{1,3} = cellstr(blkdata{1,4}); % stations id
     dataout{1,4} = cellstr(blkdata{1,5}); % point code
     dataout{1,5} = cellstr(blkdata{1,6}); % solution id
     
     %time--decimal year
     YYYY = yy2yyyy(str2double(cellstr(blkdata{1,7}))); 
     DOY = str2double(cellstr(blkdata{1,8}));
     sec = str2double(cellstr(blkdata{1,9}));
     
     H_leap = leapyear(YYYY);
     yearday = 365+H_leap;
     
     dataout{1,6} = YYYY+(DOY-1)./yearday+sec./86400;
     

     
     dataout{1,7} = cellstr(blkdata{1,10}); % unit
     dataout{1,8} = cellstr(blkdata{1,11}); % constrain
     dataout{1,9} = str2double(cellstr(blkdata{1,12})); % value (a prior / estimated)
     dataout{1,10} = str2double(cellstr(blkdata{1,13})); % sigma
     
     
     
elseif strcmpi(blkname,'SOLUTION/STATISTICS')      
     
     dataout = cell(1,2);
     
     dataout{1,1} = cellstr(blkdata{1,2}); % paramete name
     dataout{1,2} = str2double(cellstr(blkdata{1,3})); % value
     
     
     
     
 elseif strcmpi(blkname,'SOLUTION/MATRIX_APRIORI L COVA') || ...
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
     if iscell(blkdata)
         Rindex = str2double(cellstr(blkdata{1,2}));
         Cindex = str2double(cellstr(blkdata{1,3})); 
         Mx     = str2double(cellstr(blkdata{1,4}));
         Mxp1   = str2double(cellstr(blkdata{1,5}));
         Mxp2   = str2double(cellstr(blkdata{1,6}));
     else
         H_rm_empty = blkdata(:,1)==0 | blkdata(:,2)==0;
         blkdata(H_rm_empty,:)=[];
         Rindex = blkdata(:,1);
         Cindex = blkdata(:,2); 
         Mx     = blkdata(:,3);
         Mxp1   = blkdata(:,4);
         Mxp2   = blkdata(:,5);
     end
%      % remove empty value which is converted to NaN
%      Mx(isnan(Mx))=0;
%      Mxp1(isnan(Mxp1))=0;
%      Mxp2(isnan(Mxp2))=0;
     
     clear blkdata;
     maxRC = max([max(Rindex),max(Cindex)])+2;
     dataout = zeros(maxRC,maxRC); % square matrix
     
     idx = sub2ind(size(dataout),Rindex,Cindex);
     dataout(idx) = Mx;
     
     H_p = isnan(Mxp1);
     R_temp = Rindex(~H_p);
     C_temp = Cindex(~H_p);
     idx = sub2ind(size(dataout),R_temp,C_temp+1);
     dataout(idx) = Mxp1(~H_p);
     
     H_p = isnan(Mxp2);
     R_temp = Rindex(~H_p);
     C_temp = Cindex(~H_p);
     idx = sub2ind(size(dataout),R_temp,C_temp+2);
     dataout(idx) = Mxp2(~H_p);
     
     diagMat = diag(dataout);
     dataout = dataout+dataout';
     %       dataout(1:max(Rindex)+1:end) = diagMat;
     dataout(1:maxRC+1:end) = diagMat;
     % remove the extra added two dimension
     dataout(end-1:end,:)=[];
     % remove extra column
     if all(dataout(:,end)==0), dataout(:,end)=[];end
     if all(dataout(:,end)==0), dataout(:,end)=[];end
     % check the dimension
     [Rnum,Cnum] = size(dataout);
     if Rnum~=Cnum, warning(['the corariance matrix dimension:',num2str(Rnum),'X',num2str(Cnum)]);end
 else
     disp('------------------------------------------------------')
     disp(['The input block name: ',blkname,' does not supported'])
     disp('please check the block name again!')
     disp('------------------------------------------------------')
 end
     
 
 
 
 

end

