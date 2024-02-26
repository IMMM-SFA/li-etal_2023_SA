clear all
close all
clc


%%
start_year = 1991;
end_year = 2010;

dates= [datetime(start_year,1,1):1:datetime(end_year,12,31)]';
dates(month(dates)==2 & day(dates)==29) = [];
summer_dates = dates(month(dates)==6 | month(dates)==7 | month(dates)==8);

%%

for case_number = 1:6

TSA_R =[];
TSA_U =[];

for i = start_year:end_year

    if case_number == 1

        test=F_ncread_all(strcat('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform/lnd/hist/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform.clm2.h0.',num2str(i),'-01-01-00000.nc'));
        if i == start_year
        lat = test.lat.data;
        lon = test.lon.data;
        end
    else

        test=F_ncread_all(strcat('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform',num2str(case_number),'/lnd/hist/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform',num2str(case_number),'.clm2.h0.',num2str(i),'-01-01-00000.nc'));

    end
   TSA_R=cat(3,TSA_R,test.TSA_R.data);
   TSA_U=cat(3,TSA_U,test.TSA_U.data);

   TSA_U (abs(TSA_U)>1e6)=NaN;
   TSA_R (abs(TSA_R)>1e6)=NaN;

   clear test

end



TSA_U_all(:,:,:,case_number) =TSA_U;
TSA_R_all(:,:,:,case_number) =TSA_R;

TSA_R_save= TSA_R;

clear TSA_U TSA_R


% load('../regular/hist2/data1.mat','TSA_R')
% max(abs(TSA_R_save(:)-TSA_R(:)))
%
% figure
% plot(TSA_R_save(:),TSA_R(:),'ro')
% hold on


end

%%

for case_number = 1:6


if case_number == 1

surf=F_ncread_all(strcat('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform/lnd/hist/surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824-urbuniform.nc'));


end

if case_number == 2

surf=F_ncread_all(strcat('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform2/lnd/hist/surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824-urbuniform-tkcvx2.nc'));


end

if case_number == 3

surf=F_ncread_all(strcat('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform3/lnd/hist/surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824-urbuniform-tkcvx5.nc'));

end

if case_number == 4

surf=F_ncread_all(strcat('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform4/lnd/hist/surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824-urbuniform-tkcvx10.nc'));

end

if case_number == 5

surf=F_ncread_all(strcat('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform5/lnd/hist/surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824-urbuniform-tkcvx20.nc'));

end

if case_number == 6

surf=F_ncread_all(strcat('/projectnb/urbanclimate/public/CLM_output/urban_I2000Clm50Sp_f09_g17_regular_roof_urbuniform6/lnd/hist/surfdata_0.9x1.25_16pfts_Irrig_CMIP6_simyr2000_c170824-urbuniform-tkcvx50.nc'));

end


for ii =1:3

    mu_roof_temp(:,:,ii) = squeeze(mean(sqrt(surf.CV_ROOF.data(:,:,ii,:).*surf.TK_ROOF.data(:,:,ii,:)),4)).*surf.WTLUNIT_ROOF.data(:,:,ii).*surf.PCT_URBAN.data(:,:,ii);
    mu_wall_temp(:,:,ii) = squeeze(mean(sqrt(surf.CV_WALL.data(:,:,ii,:).*surf.TK_WALL.data(:,:,ii,:)),4)).*(2*surf.CANYON_HWR.data(:,:,ii)).*(1-surf.WTLUNIT_ROOF.data(:,:,ii)).*surf.PCT_URBAN.data(:,:,ii);
    mu_imp_temp(:,:,ii) = squeeze(mean(sqrt(surf.CV_IMPROAD.data(:,:,ii,:).*surf.TK_IMPROAD.data(:,:,ii,:)),4)).*surf.WTROAD_PERV.data(:,:,ii).*(1-surf.WTLUNIT_ROOF.data(:,:,ii)).*surf.PCT_URBAN.data(:,:,ii);

end


mu_roof = sum(mu_roof_temp,3)./sum(surf.PCT_URBAN.data,3);
mu_wall = sum(mu_wall_temp,3)./sum(surf.PCT_URBAN.data,3);
mu_imp = sum(mu_imp_temp,3)./sum(surf.PCT_URBAN.data,3);

mu(:,:,case_number) = mu_roof+mu_wall+mu_imp;

clear surf


end

% display_map_all_positive(mu(:,:,1)/1e4, 1)

% display_map_all_positive(mu(:,:,5)/1e4, 2)


%%

[rows,colms,days]=size(TSA_U_all(:,:,:,1));

TSA_U_detrend = zeros(rows,colms,days)+NaN;
TSA_R_detrend = zeros(rows,colms,days)+NaN;

TSA_U_detrend_summer = zeros(rows,colms,length(summer_dates))+NaN;
TSA_R_detrend_summer = zeros(rows,colms,length(summer_dates))+NaN;

TSA_U_detrend_linear = zeros(rows,colms,days)+NaN;
TSA_R_detrend_linear = zeros(rows,colms,days)+NaN;

acorr_days_cal = 91;
acorr_urban = zeros(rows,colms,acorr_days_cal,6)+NaN;
acorr_urban_summer = zeros(rows,colms,acorr_days_cal,6)+NaN;
acorr_rural = zeros(rows,colms,acorr_days_cal,6)+NaN;
acorr_rural_summer = zeros(rows,colms,acorr_days_cal,6)+NaN;

for case_number = 1: 6

for i = 1: rows
    for j = 1:colms

         if ~isnan(TSA_U_all(i,j,1,1)) && ~isnan(TSA_R_all(i,j,1,1))


            TSA_U_detrend_linear(i,j,:) = detrend(squeeze(TSA_U_all(i,j,:,case_number)),'linear');
            TSA_U_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TSA_U_detrend_linear(i,j,:)));

            [acorr_urban(i,j,:,case_number),lags]=autocorr(TSA_U_detrend(i,j,:),acorr_days_cal-1);

            TSA_U_detrend_summer(i,j,:) = find_summer_data (dates, squeeze(TSA_U_detrend(i,j,:)));
            [acorr_urban_summer(i,j,:,case_number),lags]=autocorr(TSA_U_detrend_summer(i,j,:),acorr_days_cal-1);

            TSA_R_detrend_linear(i,j,:) = detrend(squeeze(TSA_R_all(i,j,:,case_number)),'linear');
            TSA_R_detrend(i,j,:) = remove_mean_seasonal_cycle (dates, squeeze(TSA_R_detrend_linear(i,j,:)));
            [acorr_rural(i,j,:,case_number),lags2]=autocorr(TSA_R_detrend(i,j,:),acorr_days_cal-1);

            TSA_R_detrend_summer(i,j,:) = find_summer_data (dates, squeeze(TSA_R_detrend(i,j,:)));
            [acorr_rural_summer(i,j,:,case_number),lags]=autocorr(TSA_R_detrend_summer(i,j,:),acorr_days_cal-1);


         end
    end
end


end


save('data_unform.mat','lat','lon','rows','colms','days','dates','summer_dates','mu','TSA_U_all','TSA_R_all',...
    'acorr_urban','acorr_rural','acorr_urban_summer','acorr_rural_summer','lags')


