clear all
close all
clc


%%

load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2.mat',...
    'TSA_U_detrend','TSA_R_detrend','TSA_U_MAX_detrend','TSA_R_MAX_detrend','TSA_U_MIN_detrend','TSA_R_MIN_detrend');
%%

acorr_days_cal = 31;

acorr_urban = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_UHI = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_max = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_max = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_UHI_max = zeros(rows,colms,acorr_days_cal)+NaN;

acorr_urban_min = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_min = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_UHI_min = zeros(rows,colms,acorr_days_cal)+NaN;

TSA_U_warm_length = zeros(rows,colms)+NaN;
TSA_R_warm_length = zeros(rows,colms)+NaN;


for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U_detrend(i,j,1)) && ~isnan(TSA_R_detrend(i,j,1))
             %% compute the warm even length

             TSA_U_warm_length(i,j) = warm_event_length (TSA_U_detrend(i,j,:));
             TSA_R_warm_length(i,j) = warm_event_length (TSA_R_detrend(i,j,:));

             %% compute the autocorrelation

            [acorr_urban(i,j,:),lags]=autocorr(TSA_U_detrend(i,j,:),acorr_days_cal-1);
            [acorr_rural(i,j,:)]=autocorr(TSA_R_detrend(i,j,:),acorr_days_cal-1);           
            [acorr_UHI(i,j,:)]=autocorr(squeeze(TSA_U_detrend(i,j,:)-TSA_R_detrend(i,j,:)),acorr_days_cal-1);

            [acorr_urban_max(i,j,:)]=autocorr(TSA_U_MAX_detrend(i,j,:),acorr_days_cal-1);
            [acorr_rural_max(i,j,:)]=autocorr(TSA_R_MAX_detrend(i,j,:),acorr_days_cal-1);           
            [acorr_UHI_max(i,j,:)]=autocorr(squeeze(TSA_U_MAX_detrend(i,j,:)-TSA_R_MAX_detrend(i,j,:)),acorr_days_cal-1);

            [acorr_urban_min(i,j,:)]=autocorr(TSA_U_MIN_detrend(i,j,:),acorr_days_cal-1);
            [acorr_rural_min(i,j,:)]=autocorr(TSA_R_MIN_detrend(i,j,:),acorr_days_cal-1);           
            [acorr_UHI_min(i,j,:)]=autocorr(squeeze(TSA_U_MIN_detrend(i,j,:)-TSA_R_MIN_detrend(i,j,:)),acorr_days_cal-1);

         end

    end
end


save('autocorrelation.mat',...
    'TSA_U_warm_length','TSA_R_warm_length',...
    'acorr_urban','acorr_rural','acorr_UHI','lags',...
    'acorr_urban_max','acorr_rural_max','acorr_UHI_max',...
    'acorr_urban_min','acorr_rural_min','acorr_UHI_min');











