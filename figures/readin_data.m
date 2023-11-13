clear all
close all
clc

addpath('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof/lnd/hist2/')

start_year = 1991;
end_year = 2010;

pct_urban = ncread('pct_urban_0.9x1.25_global.nc','pct_urban');
lat = ncread('urban_I2000Clm50Sp_f09_g17_regular_roof.clm2.h0.2010-01-01-00000.nc','lat');
lon = ncread('urban_I2000Clm50Sp_f09_g17_regular_roof.clm2.h0.2010-01-01-00000.nc','lon');

dates= [datetime(start_year,1,1):1:datetime(end_year,12,31)]';  
dates(month(dates)==2 & day(dates)==29) = [];


TSA_U =[];TSA_R =[];
TSA_U_MAX =[];TSA_R_MAX =[];
TSA_U_MIN =[];TSA_R_MIN =[];

% TSA_U1 =[];TSA_U2 =[];TSA_U3 =[];TSA_U4 =[];TSA_U5 =[];
FSA_U =[];FSA_R =[];
FIRA_U=[];FIRA_R=[];
FIRE_U=[];FIRE_R=[];
FSH_U=[];FSH_R=[];
FLH_U=[];FLH_R=[];
FGR_U=[];FGR_R=[];
Qanth=[];



for i = start_year:end_year
   
   test=F_ncread_all(strcat('urban_I2000Clm50Sp_f09_g17_regular_roof.clm2.h0.',num2str(i),'-01-01-00000.nc'));
   %% temperatures
   TSA_R=cat(3,TSA_R,test.TSA_R.data);
   TSA_U=cat(3,TSA_U,test.TSA_U.data);
   TSA_R_MAX=cat(3,TSA_R_MAX,test.TREFMXAV_R.data);
   TSA_U_MAX=cat(3,TSA_U_MAX,test.TREFMXAV_U.data);
   TSA_R_MIN=cat(3,TSA_R_MIN,test.TREFMNAV_R.data);
   TSA_U_MIN=cat(3,TSA_U_MIN,test.TREFMNAV_U.data);
%    TSA_U1=cat(3,TSA_U1,test.TROOF_SURFACE.data);
%    TSA_U2=cat(3,TSA_U2,test.TSUNWALL_SURFACE.data);
%    TSA_U3=cat(3,TSA_U3,test.TSHADEWALL_SURFACE.data);
%    TSA_U4=cat(3,TSA_U4,test.TROADIMPERV_SURFACE.data);
%    TSA_U5=cat(3,TSA_U5,test.TROADPERV_SURFACE.data);

   %% fluxes
   %eberror = FSA_U - FIRA_U - FSH_U - EFLX_LH_TOT_U - FGR_U + Qanth/pct_urban*100
   
    FSA_U=cat(3,FSA_U,test.FSA_U.data);
    FSA_R=cat(3,FSA_R,test.FSA_R.data);
 
    FIRA_U=cat(3,FIRA_U,test.FIRA_U.data); % net longwave (outgoing - incoming)
    FIRA_R=cat(3,FIRA_R,test.FIRA_R.data);
 
    FIRE_U=cat(3,FIRE_U,test.FIRE_U.data); % outgoing longwave
    FIRE_R=cat(3,FIRE_R,test.FIRE_R.data); 
 
    FSH_U=cat(3,FSH_U,test.FSH_U.data);
    FSH_R=cat(3,FSH_R,test.FSH_R.data);
 
    FLH_U=cat(3,FLH_U,test.EFLX_LH_TOT_U.data);
    FLH_R=cat(3,FLH_R,test.EFLX_LH_TOT_R.data);
 
    FGR_U=cat(3,FGR_U,test.FGR_U.data);
    FGR_R=cat(3,FGR_R,test.FGR_R.data);
 
    Qanth = cat(3,Qanth,test.Qanth.data);
 
    Qanth_U = Qanth./pct_urban*100;

   %% missing values

   TSA_U (abs(TSA_U)>1e6)=NaN;
   TSA_R (abs(TSA_R)>1e6)=NaN;  
   TSA_U_MAX (abs(TSA_U_MAX)>1e6)=NaN;
   TSA_R_MAX (abs(TSA_R_MAX)>1e6)=NaN;  
   TSA_U_MIN (abs(TSA_U_MIN)>1e6)=NaN;
   TSA_R_MIN (abs(TSA_R_MIN)>1e6)=NaN;  
%    TSA_U1 (abs(TSA_U1)>1e6)=NaN;
%    TSA_U2 (abs(TSA_U2)>1e6)=NaN;
%    TSA_U3 (abs(TSA_U3)>1e6)=NaN;
%    TSA_U4 (abs(TSA_U4)>1e6)=NaN;
%    TSA_U5 (abs(TSA_U5)>1e6)=NaN;
   

    FSA_U (abs(FSA_U)>1e6)=NaN;
    FSA_R (abs(FSA_R)>1e6)=NaN;
    FIRA_U (abs(FIRA_U)>1e6)=NaN;
    FIRA_R (abs(FIRA_R)>1e6)=NaN;
    FIRE_U (abs(FIRE_U)>1e6)=NaN;
    FIRE_R (abs(FIRE_R)>1e6)=NaN;
    FSH_U (abs(FSH_U)>1e6)=NaN;
    FSH_R (abs(FSH_R)>1e6)=NaN;
    FLH_U (abs(FLH_U)>1e6)=NaN;
    FLH_R (abs(FLH_R)>1e6)=NaN;
    FGR_U (abs(FGR_U)>1e6)=NaN;
    FGR_R (abs(FGR_R)>1e6)=NaN;


   %% check energy balance
    eberror_U = FSA_U - FIRA_U - FSH_U - FLH_U - FGR_U + Qanth_U;
    eberror_R = FSA_R - FIRA_R - FSH_R - FLH_R - FGR_R;
 
     if max(abs(eberror_R(:))) > 0.5 || max(abs(eberror_U(:))) > 0.5
 
     print('something wrong')
 
     end


end


[rows,colms,days]=size(TSA_R);

save('data1.mat','lat','lon','rows','colms','days','dates',...
    'TSA_U','TSA_R',...
    'TSA_U_MAX','TSA_R_MAX',...
    'TSA_U_MIN','TSA_R_MIN',...
    'FSA_U', 'FSA_R',...
     'FIRA_U','FIRA_R',...
     'FIRE_U','FIRE_R',...
     'FSH_U','FSH_R',...
     'FLH_U','FLH_R',...
     'FGR_U','FGR_R',...
     'Qanth_U')

%    'TSA_U1','TSA_U2','TSA_U3','TSA_U4','TSA_U5',...
 
