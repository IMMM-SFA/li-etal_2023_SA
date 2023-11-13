clear all
close all
clc

%% 
load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2.mat');

load autocorrelation.mat


%% compute gamma

AC1_urban = acorr_urban(:,:,2);
AC1_rural = acorr_rural(:,:,2);

lambdaminus1_urban = (-log(AC1_urban)).^(-1);
lambdaminus1_rural = (-log(AC1_rural)).^(-1);

lambdaminus1_diff = lambdaminus1_urban-lambdaminus1_rural;
lambdaminus1_diff_frac = (lambdaminus1_urban-lambdaminus1_rural)./lambdaminus1_rural;


%% compute signficiance 

p_AC= zeros(rows,colms,2)+NaN;
z_AC= zeros(rows,colms);

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U_detrend(i,j,1)) && ~isnan(TSA_R_detrend(i,j,1))

     

                [p_AC(i,j,:), z_AC(i,j)] = corr_rtest(AC1_urban(i,j), AC1_rural(i,j), days, days);


         end
    end
end


mask_p_AC = nan(size(TSA_U_detrend(:,:,1)));
mask_p_AC (p_AC(:,:,2)<0.05) = 1;

lat_center = (lat + circshift(lat,-1))/2;
lon_center = (lon + circshift(lon,-1))/2;

lat_center(1) = nan;
lon_center(end) = nan;

lat_2d = repmat(lat_center,1,length(lon))';
lon_2d = repmat(lon_center,1,length(lat));
lat_2d_p = lat_2d.*mask_p_AC;
lon_2d_p = lon_2d.*mask_p_AC;

lat_2d_p_reshape = reshape(lat_2d_p,length(lat)*length(lon),1);
lon_2d_p_reshape = reshape(lon_2d_p,length(lat)*length(lon),1);

sig_matrix=[lat_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape)),lon_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape))];

%% 
save('gamma.mat','AC1_urban','AC1_rural','lambdaminus1_urban','lambdaminus1_rural','lambdaminus1_diff','lambdaminus1_diff_frac',...
    'mask_p_AC','sig_matrix');


