clear all
close all
clc


%%

load('data1.mat','lat','lon','rows','colms','days','dates','TSA_U','TSA_R');
load('data2.mat',...
    'TSA_U_detrend','TSA_R_detrend','TSA_U_MAX_detrend','TSA_R_MAX_detrend','TSA_U_MIN_detrend','TSA_R_MIN_detrend');


summer_dates = dates(month(dates)==6 | month(dates)==7 | month(dates)==8);   


%%

acorr_days_cal = 31;

TSA_U_detrend_summer = zeros(rows,colms,length(summer_dates))+NaN;
TSA_R_detrend_summer = zeros(rows,colms,length(summer_dates))+NaN;

TSA_U_MAX_detrend_summer = zeros(rows,colms,length(summer_dates))+NaN;
TSA_R_MAX_detrend_summer = zeros(rows,colms,length(summer_dates))+NaN;

TSA_U_MIN_detrend_summer = zeros(rows,colms,length(summer_dates))+NaN;
TSA_R_MIN_detrend_summer = zeros(rows,colms,length(summer_dates))+NaN;


acorr_urban_summer = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_summer = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_max_summer = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_max_summer = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_min_summer = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_min_summer = zeros(rows,colms,acorr_days_cal)+NaN;

TSA_U_warm_length_summer = zeros(rows,colms)+NaN;
TSA_R_warm_length_summer = zeros(rows,colms)+NaN;

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U(i,j,1)) && ~isnan(TSA_R(i,j,1))       

            TSA_U_detrend_summer(i,j,:) = find_summer_data (dates, squeeze(TSA_U_detrend(i,j,:)));
            TSA_R_detrend_summer(i,j,:) = find_summer_data (dates, squeeze(TSA_R_detrend(i,j,:)));

            TSA_U_MAX_detrend_summer(i,j,:) = find_summer_data (dates, squeeze(TSA_U_MAX_detrend(i,j,:)));
            TSA_R_MAX_detrend_summer(i,j,:) = find_summer_data (dates, squeeze(TSA_R_MAX_detrend(i,j,:)));

            TSA_U_MIN_detrend_summer(i,j,:) = find_summer_data (dates, squeeze(TSA_U_MIN_detrend(i,j,:)));
            TSA_R_MIN_detrend_summer(i,j,:) = find_summer_data (dates, squeeze(TSA_R_MIN_detrend(i,j,:)));
            
            TSA_U_warm_length_summer(i,j) = warm_event_length (TSA_U_detrend_summer(i,j,:));
            TSA_R_warm_length_summer(i,j) = warm_event_length (TSA_R_detrend_summer(i,j,:));

            [acorr_urban_summer(i,j,:),lags]=autocorr(TSA_U_detrend_summer(i,j,:),acorr_days_cal-1);
            [acorr_rural_summer(i,j,:)]=autocorr(TSA_R_detrend_summer(i,j,:),acorr_days_cal-1);

            [acorr_urban_max_summer(i,j,:)]=autocorr(TSA_U_MAX_detrend_summer(i,j,:),acorr_days_cal-1);
            [acorr_rural_max_summer(i,j,:)]=autocorr(TSA_R_MAX_detrend_summer(i,j,:),acorr_days_cal-1);           

            [acorr_urban_min_summer(i,j,:)]=autocorr(TSA_U_MIN_detrend_summer(i,j,:),acorr_days_cal-1);
            [acorr_rural_min_summer(i,j,:)]=autocorr(TSA_R_MIN_detrend_summer(i,j,:),acorr_days_cal-1);           
             
         end

    end
end


save('autocorrelation_summer.mat','summer_dates',...
    'TSA_U_detrend_summer','TSA_R_detrend_summer',...
    'TSA_U_MAX_detrend_summer','TSA_R_MAX_detrend_summer',...
    'TSA_U_MIN_detrend_summer','TSA_R_MIN_detrend_summer',...    
    'TSA_U_warm_length_summer','TSA_R_warm_length_summer',...
    'acorr_urban_summer','acorr_rural_summer',...   
    'acorr_urban_max_summer','acorr_rural_max_summer',...   
    'acorr_urban_min_summer','acorr_rural_min_summer',...           
    'lags');










