clear all
close all
clc

%% 
load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2.mat');

load autocorrelation_spring.mat


%% compute gamma

AC1_urban_spring = acorr_urban_spring(:,:,2);
AC1_rural_spring = acorr_rural_spring(:,:,2);

lambdaminus1_urban_spring = (-log(AC1_urban_spring)).^(-1);
lambdaminus1_rural_spring = (-log(AC1_rural_spring)).^(-1);

lambdaminus1_diff_spring = lambdaminus1_urban_spring-lambdaminus1_rural_spring;
lambdaminus1_diff_frac_spring = (lambdaminus1_urban_spring-lambdaminus1_rural_spring)./lambdaminus1_rural_spring;


%% compute signficiance 

p_AC_spring= zeros(rows,colms,2)+NaN;
z_AC_spring= zeros(rows,colms);

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TSA_U_detrend_spring(i,j,1)) && ~isnan(TSA_R_detrend_spring(i,j,1))

     

                [p_AC_spring(i,j,:), z_AC_spring(i,j)] = corr_rtest(AC1_urban_spring(i,j), AC1_rural_spring(i,j), length(spring_dates), length(spring_dates));


         end
    end
end


mask_p_AC_spring = nan(size(TSA_U_detrend_spring(:,:,1)));
mask_p_AC_spring (p_AC_spring(:,:,2)<0.05) = 1;

lat_center = (lat + circshift(lat,-1))/2;
lon_center = (lon + circshift(lon,-1))/2;

lat_center(1) = nan;
lon_center(end) = nan;

lat_2d = repmat(lat_center,1,length(lon))';
lon_2d = repmat(lon_center,1,length(lat));
lat_2d_p = lat_2d.*mask_p_AC_spring;
lon_2d_p = lon_2d.*mask_p_AC_spring;

lat_2d_p_reshape = reshape(lat_2d_p,length(lat)*length(lon),1);
lon_2d_p_reshape = reshape(lon_2d_p,length(lat)*length(lon),1);

sig_matrix_spring=[lat_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape)),lon_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape))];

%% 
save('gamma_spring.mat','AC1_urban_spring','AC1_rural_spring','lambdaminus1_urban_spring','lambdaminus1_rural_spring','lambdaminus1_diff_spring','lambdaminus1_diff_frac_spring',...
    'mask_p_AC_spring','sig_matrix_spring');


