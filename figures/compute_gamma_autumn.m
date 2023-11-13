clear all
close all
clc

%% 
load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2.mat');

load autocorrelation_autumn.mat


%% compute gamma

AC1_urban_autumn = acorr_urban_autumn(:,:,2);
AC1_rural_autumn = acorr_rural_autumn(:,:,2);

lambdaminus1_urban_autumn = (-log(AC1_urban_autumn)).^(-1);
lambdaminus1_rural_autumn = (-log(AC1_rural_autumn)).^(-1);

lambdaminus1_diff_autumn = lambdaminus1_urban_autumn-lambdaminus1_rural_autumn;
lambdaminus1_diff_frac_autumn = (lambdaminus1_urban_autumn-lambdaminus1_rural_autumn)./lambdaminus1_rural_autumn;


%% compute signficiance 

p_AC_autumn= zeros(rows,colms,2)+NaN;
z_AC_autumn= zeros(rows,colms);

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U_detrend_autumn(i,j,1)) && ~isnan(TSA_R_detrend_autumn(i,j,1))

     

                [p_AC_autumn(i,j,:), z_AC_autumn(i,j)] = corr_rtest(AC1_urban_autumn(i,j), AC1_rural_autumn(i,j), length(autumn_dates), length(autumn_dates));


         end
    end
end


mask_p_AC_autumn = nan(size(TSA_U_detrend_autumn(:,:,1)));
mask_p_AC_autumn (p_AC_autumn(:,:,2)<0.05) = 1;

lat_center = (lat + circshift(lat,-1))/2;
lon_center = (lon + circshift(lon,-1))/2;

lat_center(1) = nan;
lon_center(end) = nan;

lat_2d = repmat(lat_center,1,length(lon))';
lon_2d = repmat(lon_center,1,length(lat));
lat_2d_p = lat_2d.*mask_p_AC_autumn;
lon_2d_p = lon_2d.*mask_p_AC_autumn;

lat_2d_p_reshape = reshape(lat_2d_p,length(lat)*length(lon),1);
lon_2d_p_reshape = reshape(lon_2d_p,length(lat)*length(lon),1);

sig_matrix_autumn=[lat_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape)),lon_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape))];

%% 
save('gamma_autumn.mat','AC1_urban_autumn','AC1_rural_autumn','lambdaminus1_urban_autumn','lambdaminus1_rural_autumn','lambdaminus1_diff_autumn','lambdaminus1_diff_frac_autumn',...
    'mask_p_AC_autumn','sig_matrix_autumn');


