clear all
close all
clc

%% 
load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2_Ts.mat');

load autocorrelation_Ts.mat


%% compute gamma

AC1_urban_Ts = acorr_urban_Ts(:,:,2);
AC1_rural_Ts = acorr_rural_Ts(:,:,2);

lambdaminus1_urban_Ts = (-log(AC1_urban_Ts)).^(-1);
lambdaminus1_rural_Ts = (-log(AC1_rural_Ts)).^(-1);

lambdaminus1_diff_Ts = lambdaminus1_urban_Ts-lambdaminus1_rural_Ts;
lambdaminus1_diff_frac_Ts = (lambdaminus1_urban_Ts-lambdaminus1_rural_Ts)./lambdaminus1_rural_Ts;


%% compute signficiance 

p_AC= zeros(rows,colms,2)+NaN;
z_AC= zeros(rows,colms);

for i = 1: rows
    for j = 1:colms
                
         if ~isnan(TS_U_detrend(i,j,1)) && ~isnan(TS_R_detrend(i,j,1))

     

                [p_AC(i,j,:), z_AC(i,j)] = corr_rtest(AC1_urban_Ts(i,j), AC1_rural_Ts(i,j), days, days);


         end
    end
end


mask_p_AC_Ts = nan(size(TS_U_detrend(:,:,1)));
mask_p_AC_Ts (p_AC(:,:,2)<0.05) = 1;

lat_center = (lat + circshift(lat,-1))/2;
lon_center = (lon + circshift(lon,-1))/2;

lat_center(1) = nan;
lon_center(end) = nan;

lat_2d = repmat(lat_center,1,length(lon))';
lon_2d = repmat(lon_center,1,length(lat));
lat_2d_p = lat_2d.*mask_p_AC_Ts;
lon_2d_p = lon_2d.*mask_p_AC_Ts;

lat_2d_p_reshape = reshape(lat_2d_p,length(lat)*length(lon),1);
lon_2d_p_reshape = reshape(lon_2d_p,length(lat)*length(lon),1);

sig_matrix_Ts=[lat_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape)),lon_2d_p_reshape(~isnan(lat_2d_p_reshape) & ~isnan(lon_2d_p_reshape))];

%% 
save('gamma_Ts.mat','AC1_urban_Ts','AC1_rural_Ts','lambdaminus1_urban_Ts','lambdaminus1_rural_Ts','lambdaminus1_diff_Ts','lambdaminus1_diff_frac_Ts',...
    'mask_p_AC_Ts','sig_matrix_Ts');





