clear all
close all
clc


%%

load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2_Ts.mat',...
    'TS_U_detrend','TS_R_detrend');
%%

acorr_days_cal = 31;

acorr_urban_Ts = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_rural_Ts = zeros(rows,colms,acorr_days_cal)+NaN;
acorr_UHI_Ts = zeros(rows,colms,acorr_days_cal)+NaN;

TS_U_warm_length = zeros(rows,colms)+NaN;
TS_R_warm_length = zeros(rows,colms)+NaN;

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TS_U_detrend(i,j,1)) && ~isnan(TS_R_detrend(i,j,1))
             %% compute the warm even length

             TS_U_warm_length(i,j) = warm_event_length (TS_U_detrend(i,j,:));
             TS_R_warm_length(i,j) = warm_event_length (TS_R_detrend(i,j,:));
             %% compute the autocorrelation

            [acorr_urban_Ts(i,j,:),lags]=autocorr(TS_U_detrend(i,j,:),acorr_days_cal-1);
            [acorr_rural_Ts(i,j,:)]=autocorr(TS_R_detrend(i,j,:),acorr_days_cal-1);           
            [acorr_UHI_Ts(i,j,:)]=autocorr(squeeze(TS_U_detrend(i,j,:)-TS_R_detrend(i,j,:)),acorr_days_cal-1);

         end

    end
end


save('autocorrelation_Ts.mat',...
    'TS_U_warm_length','TS_R_warm_length','acorr_urban_Ts','acorr_rural_Ts','acorr_UHI_Ts','lags');











