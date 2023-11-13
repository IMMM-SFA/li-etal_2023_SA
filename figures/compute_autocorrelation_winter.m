clear all
close all
clc


%%

load('data1.mat','lat','lon','rows','colms','days','dates','TSA_U','TSA_R');
load('data2.mat',...
    'TSA_U_detrend','TSA_R_detrend','TSA_U_MAX_detrend','TSA_R_MAX_detrend','TSA_U_MIN_detrend','TSA_R_MIN_detrend');

winter_dates = dates(month(dates)==1 | month(dates)==2 | month(dates)==12);   

%%

acorr_days_cal = 31;

TSA_U_detrend_winter = zeros(rows,colms,length(winter_dates))+NaN;
TSA_R_detrend_winter = zeros(rows,colms,length(winter_dates))+NaN;

TSA_U_MAX_detrend_winter = zeros(rows,colms,length(winter_dates))+NaN;
TSA_R_MAX_detrend_winter = zeros(rows,colms,length(winter_dates))+NaN;

TSA_U_MIN_detrend_winter = zeros(rows,colms,length(winter_dates))+NaN;
TSA_R_MIN_detrend_winter = zeros(rows,colms,length(winter_dates))+NaN;


acorr_urban_winter = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_winter = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_max_winter = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_max_winter = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_min_winter = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_min_winter = zeros(rows,colms,acorr_days_cal)+NaN;

TSA_U_warm_length_winter = zeros(rows,colms)+NaN;
TSA_R_warm_length_winter = zeros(rows,colms)+NaN;

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U(i,j,1)) && ~isnan(TSA_R(i,j,1))       

            TSA_U_detrend_winter(i,j,:) = find_winter_data (dates, squeeze(TSA_U_detrend(i,j,:)));
            TSA_R_detrend_winter(i,j,:) = find_winter_data (dates, squeeze(TSA_R_detrend(i,j,:)));

            TSA_U_MAX_detrend_winter(i,j,:) = find_winter_data (dates, squeeze(TSA_U_MAX_detrend(i,j,:)));
            TSA_R_MAX_detrend_winter(i,j,:) = find_winter_data (dates, squeeze(TSA_R_MAX_detrend(i,j,:)));

            TSA_U_MIN_detrend_winter(i,j,:) = find_winter_data (dates, squeeze(TSA_U_MIN_detrend(i,j,:)));
            TSA_R_MIN_detrend_winter(i,j,:) = find_winter_data (dates, squeeze(TSA_R_MIN_detrend(i,j,:)));
            
            TSA_U_warm_length_winter(i,j) = warm_event_length (TSA_U_detrend_winter(i,j,:));
            TSA_R_warm_length_winter(i,j) = warm_event_length (TSA_R_detrend_winter(i,j,:));

            [acorr_urban_winter(i,j,:),lags]=autocorr(TSA_U_detrend_winter(i,j,:),acorr_days_cal-1);
            [acorr_rural_winter(i,j,:)]=autocorr(TSA_R_detrend_winter(i,j,:),acorr_days_cal-1);

            [acorr_urban_max_winter(i,j,:)]=autocorr(TSA_U_MAX_detrend_winter(i,j,:),acorr_days_cal-1);
            [acorr_rural_max_winter(i,j,:)]=autocorr(TSA_R_MAX_detrend_winter(i,j,:),acorr_days_cal-1);           

            [acorr_urban_min_winter(i,j,:)]=autocorr(TSA_U_MIN_detrend_winter(i,j,:),acorr_days_cal-1);
            [acorr_rural_min_winter(i,j,:)]=autocorr(TSA_R_MIN_detrend_winter(i,j,:),acorr_days_cal-1);           
             
         end

    end
end


save('autocorrelation_winter.mat','winter_dates',...
    'TSA_U_detrend_winter','TSA_R_detrend_winter',...
    'TSA_U_MAX_detrend_winter','TSA_R_MAX_detrend_winter',...
    'TSA_U_MIN_detrend_winter','TSA_R_MIN_detrend_winter',...    
    'TSA_U_warm_length_winter','TSA_R_warm_length_winter',...
    'acorr_urban_winter','acorr_rural_winter',...   
    'acorr_urban_max_winter','acorr_rural_max_winter',...   
    'acorr_urban_min_winter','acorr_rural_min_winter',...           
    'lags');










