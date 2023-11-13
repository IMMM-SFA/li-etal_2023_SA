clear all
close all
clc


%%

load('data1.mat','lat','lon','rows','colms','days','dates','TSA_U','TSA_R');
load('data2.mat',...
    'TSA_U_detrend','TSA_R_detrend','TSA_U_MAX_detrend','TSA_R_MAX_detrend','TSA_U_MIN_detrend','TSA_R_MIN_detrend');

autumn_dates = dates(month(dates)==9 | month(dates)==10 | month(dates)==11);   


%%

acorr_days_cal = 31;

TSA_U_detrend_autumn = zeros(rows,colms,length(autumn_dates))+NaN;
TSA_R_detrend_autumn = zeros(rows,colms,length(autumn_dates))+NaN;

TSA_U_MAX_detrend_autumn = zeros(rows,colms,length(autumn_dates))+NaN;
TSA_R_MAX_detrend_autumn = zeros(rows,colms,length(autumn_dates))+NaN;

TSA_U_MIN_detrend_autumn = zeros(rows,colms,length(autumn_dates))+NaN;
TSA_R_MIN_detrend_autumn = zeros(rows,colms,length(autumn_dates))+NaN;


acorr_urban_autumn = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_autumn = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_max_autumn = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_max_autumn = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_min_autumn = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_min_autumn = zeros(rows,colms,acorr_days_cal)+NaN;

TSA_U_warm_length_autumn = zeros(rows,colms)+NaN;
TSA_R_warm_length_autumn = zeros(rows,colms)+NaN;

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U(i,j,1)) && ~isnan(TSA_R(i,j,1))       

            TSA_U_detrend_autumn(i,j,:) = find_autumn_data (dates, squeeze(TSA_U_detrend(i,j,:)));
            TSA_R_detrend_autumn(i,j,:) = find_autumn_data (dates, squeeze(TSA_R_detrend(i,j,:)));

            TSA_U_MAX_detrend_autumn(i,j,:) = find_autumn_data (dates, squeeze(TSA_U_MAX_detrend(i,j,:)));
            TSA_R_MAX_detrend_autumn(i,j,:) = find_autumn_data (dates, squeeze(TSA_R_MAX_detrend(i,j,:)));

            TSA_U_MIN_detrend_autumn(i,j,:) = find_autumn_data (dates, squeeze(TSA_U_MIN_detrend(i,j,:)));
            TSA_R_MIN_detrend_autumn(i,j,:) = find_autumn_data (dates, squeeze(TSA_R_MIN_detrend(i,j,:)));
            
            TSA_U_warm_length_autumn(i,j) = warm_event_length (TSA_U_detrend_autumn(i,j,:));
            TSA_R_warm_length_autumn(i,j) = warm_event_length (TSA_R_detrend_autumn(i,j,:));

            [acorr_urban_autumn(i,j,:),lags]=autocorr(TSA_U_detrend_autumn(i,j,:),acorr_days_cal-1);
            [acorr_rural_autumn(i,j,:)]=autocorr(TSA_R_detrend_autumn(i,j,:),acorr_days_cal-1);

            [acorr_urban_max_autumn(i,j,:)]=autocorr(TSA_U_MAX_detrend_autumn(i,j,:),acorr_days_cal-1);
            [acorr_rural_max_autumn(i,j,:)]=autocorr(TSA_R_MAX_detrend_autumn(i,j,:),acorr_days_cal-1);           

            [acorr_urban_min_autumn(i,j,:)]=autocorr(TSA_U_MIN_detrend_autumn(i,j,:),acorr_days_cal-1);
            [acorr_rural_min_autumn(i,j,:)]=autocorr(TSA_R_MIN_detrend_autumn(i,j,:),acorr_days_cal-1);           
             
         end

    end
end


save('autocorrelation_autumn.mat','autumn_dates',...
    'TSA_U_detrend_autumn','TSA_R_detrend_autumn',...
    'TSA_U_MAX_detrend_autumn','TSA_R_MAX_detrend_autumn',...
    'TSA_U_MIN_detrend_autumn','TSA_R_MIN_detrend_autumn',...    
    'TSA_U_warm_length_autumn','TSA_R_warm_length_autumn',...
    'acorr_urban_autumn','acorr_rural_autumn',...   
    'acorr_urban_max_autumn','acorr_rural_max_autumn',...   
    'acorr_urban_min_autumn','acorr_rural_min_autumn',...           
    'lags');










