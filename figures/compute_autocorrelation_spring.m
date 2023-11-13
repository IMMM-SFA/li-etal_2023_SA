clear all
close all
clc


%%

load('data1.mat','lat','lon','rows','colms','days','dates','TSA_U','TSA_R');
load('data2.mat',...
    'TSA_U_detrend','TSA_R_detrend','TSA_U_MAX_detrend','TSA_R_MAX_detrend','TSA_U_MIN_detrend','TSA_R_MIN_detrend');

spring_dates = dates(month(dates)==3 | month(dates)==4 | month(dates)==5);   


%%

acorr_days_cal = 31;

TSA_U_detrend_spring = zeros(rows,colms,length(spring_dates))+NaN;
TSA_R_detrend_spring = zeros(rows,colms,length(spring_dates))+NaN;

TSA_U_MAX_detrend_spring = zeros(rows,colms,length(spring_dates))+NaN;
TSA_R_MAX_detrend_spring = zeros(rows,colms,length(spring_dates))+NaN;

TSA_U_MIN_detrend_spring = zeros(rows,colms,length(spring_dates))+NaN;
TSA_R_MIN_detrend_spring = zeros(rows,colms,length(spring_dates))+NaN;


acorr_urban_spring = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_spring = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_max_spring = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_max_spring = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_min_spring = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_min_spring = zeros(rows,colms,acorr_days_cal)+NaN;

TSA_U_warm_length_spring = zeros(rows,colms)+NaN;
TSA_R_warm_length_spring = zeros(rows,colms)+NaN;

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U(i,j,1)) && ~isnan(TSA_R(i,j,1))       

            TSA_U_detrend_spring(i,j,:) = find_spring_data (dates, squeeze(TSA_U_detrend(i,j,:)));
            TSA_R_detrend_spring(i,j,:) = find_spring_data (dates, squeeze(TSA_R_detrend(i,j,:)));

            TSA_U_MAX_detrend_spring(i,j,:) = find_spring_data (dates, squeeze(TSA_U_MAX_detrend(i,j,:)));
            TSA_R_MAX_detrend_spring(i,j,:) = find_spring_data (dates, squeeze(TSA_R_MAX_detrend(i,j,:)));

            TSA_U_MIN_detrend_spring(i,j,:) = find_spring_data (dates, squeeze(TSA_U_MIN_detrend(i,j,:)));
            TSA_R_MIN_detrend_spring(i,j,:) = find_spring_data (dates, squeeze(TSA_R_MIN_detrend(i,j,:)));
            
            TSA_U_warm_length_spring(i,j) = warm_event_length (TSA_U_detrend_spring(i,j,:));
            TSA_R_warm_length_spring(i,j) = warm_event_length (TSA_R_detrend_spring(i,j,:));

            [acorr_urban_spring(i,j,:),lags]=autocorr(TSA_U_detrend_spring(i,j,:),acorr_days_cal-1);
            [acorr_rural_spring(i,j,:)]=autocorr(TSA_R_detrend_spring(i,j,:),acorr_days_cal-1);

            [acorr_urban_max_spring(i,j,:)]=autocorr(TSA_U_MAX_detrend_spring(i,j,:),acorr_days_cal-1);
            [acorr_rural_max_spring(i,j,:)]=autocorr(TSA_R_MAX_detrend_spring(i,j,:),acorr_days_cal-1);           

            [acorr_urban_min_spring(i,j,:)]=autocorr(TSA_U_MIN_detrend_spring(i,j,:),acorr_days_cal-1);
            [acorr_rural_min_spring(i,j,:)]=autocorr(TSA_R_MIN_detrend_spring(i,j,:),acorr_days_cal-1);           
             
         end

    end
end


save('autocorrelation_spring.mat','spring_dates',...
    'TSA_U_detrend_spring','TSA_R_detrend_spring',...
    'TSA_U_MAX_detrend_spring','TSA_R_MAX_detrend_spring',...
    'TSA_U_MIN_detrend_spring','TSA_R_MIN_detrend_spring',...    
    'TSA_U_warm_length_spring','TSA_R_warm_length_spring',...
    'acorr_urban_spring','acorr_rural_spring',...   
    'acorr_urban_max_spring','acorr_rural_max_spring',...   
    'acorr_urban_min_spring','acorr_rural_min_spring',...           
    'lags');










