clear all
close all
clc


%%

load('data1.mat','lat','lon','rows','colms','days','dates',...
    'TSA_U','TSA_R','TSA_U_MAX','TSA_R_MAX','TSA_U_MIN','TSA_R_MIN');


%%

TSA_U_detrend = zeros(rows,colms,days)+NaN;
TSA_R_detrend = zeros(rows,colms,days)+NaN;

TSA_U_detrend_linear = zeros(rows,colms,days)+NaN;
TSA_R_detrend_linear = zeros(rows,colms,days)+NaN;

TSA_U_MAX_detrend = zeros(rows,colms,days)+NaN;
TSA_R_MAX_detrend = zeros(rows,colms,days)+NaN;

TSA_U_MAX_detrend_linear = zeros(rows,colms,days)+NaN;
TSA_R_MAX_detrend_linear = zeros(rows,colms,days)+NaN;

TSA_U_MIN_detrend = zeros(rows,colms,days)+NaN;
TSA_R_MIN_detrend = zeros(rows,colms,days)+NaN;

TSA_U_MIN_detrend_linear = zeros(rows,colms,days)+NaN;
TSA_R_MIN_detrend_linear = zeros(rows,colms,days)+NaN;

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U(i,j,1)) && ~isnan(TSA_R(i,j,1))

             %% detrend the data
             TSA_U_detrend_linear(i,j,:) = detrend(squeeze(TSA_U(i,j,:)),'linear');
             TSA_R_detrend_linear(i,j,:) = detrend(squeeze(TSA_R(i,j,:)),'linear');

             TSA_U_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TSA_U_detrend_linear(i,j,:)));
             TSA_R_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TSA_R_detrend_linear(i,j,:)));

             TSA_U_MAX_detrend_linear(i,j,:) = detrend(squeeze(TSA_U_MAX(i,j,:)),'linear');
             TSA_R_MAX_detrend_linear(i,j,:) = detrend(squeeze(TSA_R_MAX(i,j,:)),'linear');

             TSA_U_MAX_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TSA_U_MAX_detrend_linear(i,j,:)));
             TSA_R_MAX_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TSA_R_MAX_detrend_linear(i,j,:)));

             TSA_U_MIN_detrend_linear(i,j,:) = detrend(squeeze(TSA_U_MIN(i,j,:)),'linear');
             TSA_R_MIN_detrend_linear(i,j,:) = detrend(squeeze(TSA_R_MIN(i,j,:)),'linear');

             TSA_U_MIN_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TSA_U_MIN_detrend_linear(i,j,:)));
             TSA_R_MIN_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TSA_R_MIN_detrend_linear(i,j,:)));

         end

    end
end


save('data2.mat','TSA_U_detrend','TSA_R_detrend','TSA_U_MAX_detrend','TSA_R_MAX_detrend','TSA_U_MIN_detrend','TSA_R_MIN_detrend','-v7.3');











