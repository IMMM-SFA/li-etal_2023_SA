close all
clear all
clc

%%

load('data1.mat','lat','lon','rows','colms','days','dates','TSA_U','TSA_R');

%% 

mask_urban_temp = nan(size(TSA_U(:,:,1)));
mask_urban_temp(~isnan(TSA_U(:,:,1))) = 1;
mask_urban = repmat(mask_urban_temp, 1, 1, days);

% sum(~isnan(mask_urban_temp(:))) = 4241

% display_map(mask_urban_temp,1)

mask_rural_temp = nan(size(TSA_R(:,:,1)));
mask_rural_temp(~isnan(TSA_R(:,:,1))) = 1;
mask_rural = repmat(mask_rural_temp, 1, 1, days);

% sum(~isnan(mask_rural_temp(:))) = 15277

% display_map(mask_rural_temp,1)

%%

save('mask_urban_and_rural.mat','mask_urban','mask_rural','mask_urban_temp','mask_rural_temp','-v7.3');
