
clear all
close all
clc


%%

load('data1.mat','lat','lon','rows','colms','days','dates',...
    'TSA_U','TSA_R','FIRA_U','FIRA_R','FIRE_U','FIRE_R');

%%
sb = 5.6704*10^(-8); % stephan-boltzman constant (W/(m^2 K^4))
epsilon_U = 0.88;
epsilon_R = 0.96;

LW_in_U = FIRE_U - FIRA_U ;
LW_out_U = FIRE_U;
LW_in_R = FIRE_R - FIRA_R ;
LW_out_R = FIRE_R;

TS_U = ((LW_out_U-(1-epsilon_U).*LW_in_U)/(epsilon_U.*sb)).^(1/4);
TS_R = ((LW_out_R-(1-epsilon_R).*LW_in_R)/(epsilon_R.*sb)).^(1/4);

% addpath('/Users/danl/MatlabFunctions/TRM')
% display_map(squeeze(mean(TS_U-TS_R,3)), 20);

%%

TS_U_detrend = zeros(rows,colms,days)+NaN;
TS_R_detrend = zeros(rows,colms,days)+NaN;

TS_U_detrend_linear = zeros(rows,colms,days)+NaN;
TS_R_detrend_linear = zeros(rows,colms,days)+NaN;

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U(i,j,1)) && ~isnan(TSA_R(i,j,1))

             %% detrend the data

             TS_U_detrend_linear(i,j,:) = detrend(squeeze(TS_U(i,j,:)),'linear');
             TS_R_detrend_linear(i,j,:) = detrend(squeeze(TS_R(i,j,:)),'linear');

             TS_U_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TS_U_detrend_linear(i,j,:)));
             TS_R_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TS_R_detrend_linear(i,j,:))); 
         end
    end
end


save('data2_Ts.mat','TS_U','TS_R','TS_U_detrend','TS_R_detrend','-v7.3');











