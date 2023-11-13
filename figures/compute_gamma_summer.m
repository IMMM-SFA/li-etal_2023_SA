clear all
close all
clc

%% 
load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2.mat');

load autocorrelation_summer.mat

%% compute gamma

AC1_urban_summer = acorr_urban_summer(:,:,2);
AC1_rural_summer = acorr_rural_summer(:,:,2);

lambdaminus1_urban_summer = (-log(AC1_urban_summer)).^(-1);
lambdaminus1_rural_summer = (-log(AC1_rural_summer)).^(-1);

lambdaminus1_diff_summer = lambdaminus1_urban_summer-lambdaminus1_rural_summer;
lambdaminus1_diff_frac_summer = (lambdaminus1_urban_summer-lambdaminus1_rural_summer)./lambdaminus1_rural_summer;


%% compute signficiance 

p_AC_summer= zeros(rows,colms,2)+NaN;
z_AC_summer= zeros(rows,colms);

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U_detrend_summer(i,j,1)) && ~isnan(TSA_R_detrend_summer(i,j,1))

     

                [p_AC_summer(i,j,:), z_AC_summer(i,j)] = corr_rtest(AC1_urban_summer(i,j), AC1_rural_summer(i,j), length(summer_dates), length(summer_dates));


         end
    end
end


mask_p_AC_summer = nan(size(TSA_U_detrend_summer(:,:,1)));
mask_p_AC_summer (p_AC_summer(:,:,2)<0.05) = 1;

lat_center = (lat + circshift(lat,-1))/2;
lon_center = (lon + circshift(lon,-1))/2;

lat_center(1) = nan;
lon_center(end) = nan;

lat_2d = repmat(lat_center,1,length(lon))';
lon_2d = repmat(lon_center,1,length(lat));
lat_2d_p = lat_2d.*mask_p_AC_summer;
lon_2d_p = lon_2d.*mask_p_AC_summer;

lat_2d_p_reshape = reshape(lat_2d_p,length(lat)*length(lon),1);
lon_2d_p_reshape = reshape(lon_2d_p,length(lat)*length(lon),1);

sig_matrix_summer=[lat_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape)),lon_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape))];

%% 
save('gamma_summer.mat','AC1_urban_summer','AC1_rural_summer','lambdaminus1_urban_summer','lambdaminus1_rural_summer','lambdaminus1_diff_summer','lambdaminus1_diff_frac_summer',...
    'mask_p_AC_summer','sig_matrix_summer');


