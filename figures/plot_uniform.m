close all
clear all
clc

%%

addpath('./TRM')
load data_uniform.mat

%%

for case_number = 2:6

AC1_urban = acorr_urban(:,:,2,case_number);
AC1_rural = acorr_urban(:,:,2,1);

p_AC= zeros(rows,colms,2)+NaN;
z_AC= zeros(rows,colms);


for i = 1: rows
    for j = 1:colms
                
             
                [p_AC(i,j,:), z_AC(i,j)] = corr_rtest(AC1_urban(i,j), AC1_rural(i,j), days, days);


    end
end


mask_p_AC = nan(size(p_AC(:,:,2)));
mask_p_AC (p_AC(:,:,2)<0.05) = 1;

mask_p_AC_all(:,:,case_number) = mask_p_AC;


lambdaminus1_urban(:,:,case_number) = (-log(AC1_urban)).^(-1);
lambdaminus1_rural(:,:,case_number) = (-log(AC1_rural)).^(-1);

lambdaminus1_diff(:,:,case_number) = lambdaminus1_urban(:,:,case_number)-lambdaminus1_rural(:,:,case_number);
lambdaminus1_diff_frac(:,:,case_number) = (lambdaminus1_urban(:,:,case_number)-lambdaminus1_rural(:,:,case_number))./lambdaminus1_rural(:,:,case_number);

mu_diff(:,:,case_number)=(mu(:,:,case_number)-mu(:,:,1))./mu(:,:,1);


end





%%

region_names = {'Global','Tropic (20^oS-20^oN)','NH extratropic (20^o-60^oN)','SH extratropic (20^o-60^oS)'};
region_Num   = length(region_names);

global_index = 1;
Tropic_index = 2;
NH_index     = 3;
SH_index     = 4;


% Global
lat_index{global_index} = 1:length(lat);
lon_index{global_index} = 1:length(lon);

% Tropics
lon_left_EA  = 0;
lon_right_EA = 360;
lat_low_EA   = -20;
lat_up_EA    = 20;
lat_index{Tropic_index} = find (lat >lat_low_EA  & lat<lat_up_EA);
lon_index{Tropic_index} = find (lon >lon_left_EA & lon<lon_right_EA);    

% NH
lon_left_EC  = 0;
lon_right_EC = 360;
lat_low_EC   = 20;
lat_up_EC    = 60;
lat_index{NH_index} = find (lat >lat_low_EC  & lat<lat_up_EC);
lon_index{NH_index} = find (lon >lon_left_EC & lon<lon_right_EC);
 
% SH
lon_left_EC  = 0;
lon_right_EC = 360;
lat_low_EC   = -60;
lat_up_EC    = -20;
lat_index{SH_index} = find (lat >lat_low_EC  & lat<lat_up_EC);
lon_index{SH_index} = find (lon >lon_left_EC & lon<lon_right_EC);


mask_index_to_use = zeros(rows,colms,6)+NaN;

for Index_to_use = 1:4

mask_index_to_use(lon_index{Index_to_use},lat_index{Index_to_use},Index_to_use)=1;


mu_diff_temp(:,:,Index_to_use) = reshape (mu_diff(:,:,2:6).*mask_p_AC_all(:,:,2:6).*mask_index_to_use(:,:,Index_to_use),[rows*colms,5]);

lambdaminus1_diff_temp(:,:,Index_to_use) = reshape (lambdaminus1_diff(:,:,2:6).*mask_p_AC_all(:,:,2:6).*mask_index_to_use(:,:,Index_to_use),[rows*colms,5]);

lambdaminus1_diff_frac_temp(:,:,Index_to_use) = reshape (lambdaminus1_diff_frac(:,:,2:6).*mask_p_AC_all(:,:,2:6).*mask_index_to_use(:,:,Index_to_use),[rows*colms,5]);

x(:,Index_to_use) = squeeze(nanmean(mu_diff_temp(:,:,Index_to_use)));
y_2(:,Index_to_use)= squeeze(nanmean(lambdaminus1_diff_temp(:,:,Index_to_use)));
y(:,Index_to_use) = squeeze(nanmean(lambdaminus1_diff_frac_temp(:,:,Index_to_use)));
y_std(:,Index_to_use) = squeeze(nanstd(lambdaminus1_diff_frac_temp(:,:,Index_to_use)));

end

color(1,:) = [0 78 218]/255;
color(2,:) = [104 175 75]/255;
color(3,:) = [255 113 0]/255;
color(4,:) = [181 14 0]/255;

FontSize_value = 16;
Fontname_value = 'Arial';

figure;
set(gcf, 'Position', [100, 100, 650, 320]) % [Left Bottom Width Hight]
box on 
set(gca, 'Position', [0.1, 0.14, 0.85, 0.82])

hold on

% plot(x2,y2,'k.')
% hold on
% errorbar(x2_mean,y2_mean,y2_std,'ro','MarkerFaceColor','r','markersize',8)
% hold on

for Index_to_use = 1:4
plot(Index_to_use)=errorbar(x(:,Index_to_use),y(:,Index_to_use),y_std(:,Index_to_use),'-o','Color',color(Index_to_use,:),'MarkerEdgeColor',color(Index_to_use,:),'MarkerFaceColor',color(Index_to_use,:),'markersize',8)
hold on
% set(gca,'xscale','log')
end

legend([plot(1) plot(2) plot(3) plot(4)],{region_names{1},region_names{2},region_names{3},region_names{4}},'Location','northwest','NumColumns',2)
legend('boxoff')

xlabel('\Delta\Omega/\Omega','fontname',Fontname_value, 'FontSize', FontSize_value)
ylabel('\Delta\Gamma/\Gamma','fontname',Fontname_value, 'FontSize', FontSize_value)
xlim([0 50])
ylim([0 1])
set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
set(gca, 'LineWidth', 1.5)

print(gcf,'-dpng','-r600','Omega_and_gamma')