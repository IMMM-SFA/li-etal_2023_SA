close all
clear all
clc

%%

addpath('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof/lnd/hist2/')

surf=F_ncread_all(strcat('surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824.nc'));


for i =1:3

    mu_roof_temp(:,:,i) = squeeze(mean(sqrt(surf.CV_ROOF.data(:,:,i,:).*surf.TK_ROOF.data(:,:,i,:)),4)).*surf.WTLUNIT_ROOF.data(:,:,i).*surf.PCT_URBAN.data(:,:,i);
    mu_wall_temp(:,:,i) = squeeze(mean(sqrt(surf.CV_WALL.data(:,:,i,:).*surf.TK_WALL.data(:,:,i,:)),4)).*(2*surf.CANYON_HWR.data(:,:,i)).*(1-surf.WTLUNIT_ROOF.data(:,:,i)).*surf.PCT_URBAN.data(:,:,i);
    mu_imp_temp(:,:,i) = squeeze(mean(sqrt(surf.CV_IMPROAD.data(:,:,i,:).*surf.TK_IMPROAD.data(:,:,i,:)),4)).*surf.WTROAD_PERV.data(:,:,i).*(1-surf.WTLUNIT_ROOF.data(:,:,i)).*surf.PCT_URBAN.data(:,:,i);

end


mu_roof = sum(mu_roof_temp,3)./sum(surf.PCT_URBAN.data,3);
mu_wall = sum(mu_wall_temp,3)./sum(surf.PCT_URBAN.data,3);
mu_imp = sum(mu_imp_temp,3)./sum(surf.PCT_URBAN.data,3);
mu = mu_roof+mu_wall+mu_imp;


save('mu_data.mat','mu','mu_roof','mu_wall','mu_imp');
