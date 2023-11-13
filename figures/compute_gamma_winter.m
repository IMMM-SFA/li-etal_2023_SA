clear all
close all
clc

%% 
load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2.mat');

load autocorrelation_winter.mat


%% compute gamma

AC1_urban_winter = acorr_urban_winter(:,:,2);
AC1_rural_winter = acorr_rural_winter(:,:,2);

lambdaminus1_urban_winter = (-log(AC1_urban_winter)).^(-1);
lambdaminus1_rural_winter = (-log(AC1_rural_winter)).^(-1);

lambdaminus1_diff_winter = lambdaminus1_urban_winter-lambdaminus1_rural_winter;
lambdaminus1_diff_frac_winter = (lambdaminus1_urban_winter-lambdaminus1_rural_winter)./lambdaminus1_rural_winter;


%% compute signficiance 

p_AC_winter= zeros(rows,colms,2)+NaN;
z_AC_winter= zeros(rows,colms);

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U_detrend_winter(i,j,1)) && ~isnan(TSA_R_detrend_winter(i,j,1))

     

                [p_AC_winter(i,j,:), z_AC_winter(i,j)] = corr_rtest(AC1_urban_winter(i,j), AC1_rural_winter(i,j), length(winter_dates), length(winter_dates));


         end
    end
end


mask_p_AC_winter = nan(size(TSA_U_detrend_winter(:,:,1)));
mask_p_AC_winter (p_AC_winter(:,:,2)<0.05) = 1;

lat_center = (lat + circshift(lat,-1))/2;
lon_center = (lon + circshift(lon,-1))/2;

lat_center(1) = nan;
lon_center(end) = nan;

lat_2d = repmat(lat_center,1,length(lon))';
lon_2d = repmat(lon_center,1,length(lat));
lat_2d_p = lat_2d.*mask_p_AC_winter;
lon_2d_p = lon_2d.*mask_p_AC_winter;

lat_2d_p_reshape = reshape(lat_2d_p,length(lat)*length(lon),1);
lon_2d_p_reshape = reshape(lon_2d_p,length(lat)*length(lon),1);

sig_matrix_winter=[lat_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape)),lon_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape))];

%% 
save('gamma_winter.mat','AC1_urban_winter','AC1_rural_winter','lambdaminus1_urban_winter','lambdaminus1_rural_winter','lambdaminus1_diff_winter','lambdaminus1_diff_frac_winter',...
    'mask_p_AC_winter','sig_matrix_winter');


