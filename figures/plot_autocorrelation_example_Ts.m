clear all
close all
clc

%%
addpath('./TRM')
addpath('./m_map')
    
load('data1.mat','lat','lon','rows','colms','days','dates');
load('data2_Ts.mat','TS_U','TS_R','TS_U_detrend','TS_R_detrend');

TSA_U = TS_U;
TSA_R = TS_R;
TSA_U_detrend = TS_U_detrend;
TSA_R_detrend = TS_R_detrend;

load autocorrelation_Ts.mat

acorr_urban = acorr_urban_Ts;
acorr_rural = acorr_rural_Ts;
TSA_U_warm_length = TS_U_warm_length;
TSA_R_warm_length = TS_R_warm_length;

load spectra_data_Ts.mat

TSA_U_spectra_normalized = TS_U_spectra_normalized;
TSA_R_spectra_normalized = TS_R_spectra_normalized;

load mask_urban_and_rural.mat

load gamma_Ts.mat

lambdaminus1_urban = lambdaminus1_urban_Ts;
lambdaminus1_rural = lambdaminus1_rural_Ts;


%%

region_names = {'Global','US','China','Europe'};
region_Num   = length(region_names);

global_index = 1;
US_index     = 2;
China_index  = 3;
EU_index     = 4;
India_index     = 5;
CA_index = 6;


% Global
lat_index{global_index} = 1:length(lat);
lon_index{global_index} = 1:length(lon);

% US
lon_left_EA  = -130+360;
lon_right_EA = -70+360;
lat_low_EA   = 30;
lat_up_EA    = 55;
lat_index{US_index} = find (lat >lat_low_EA  & lat<lat_up_EA);
lon_index{US_index} = find (lon >lon_left_EA & lon<lon_right_EA);    

% China
lon_left_EC  = 95;
lon_right_EC = 120;
lat_low_EC   = 20;
lat_up_EC    = 45;
lat_index{China_index} = find (lat >lat_low_EC  & lat<lat_up_EC);
lon_index{China_index} = find (lon >lon_left_EC & lon<lon_right_EC);
 
% Europe
lon_left_EC  = 0;
lon_right_EC = 60;
lat_low_EC   = 35;
lat_up_EC    = 60;
lat_index{EU_index} = find (lat >lat_low_EC  & lat<lat_up_EC);
lon_index{EU_index} = find (lon >lon_left_EC & lon<lon_right_EC);

% India
lon_left_EC  = 60;
lon_right_EC = 90;
lat_low_EC   = 0;
lat_up_EC    = 30;
lat_index{India_index} = find (lat >lat_low_EC  & lat<lat_up_EC);
lon_index{India_index} = find (lon >lon_left_EC & lon<lon_right_EC);


% Central America
lon_left_EC  = -120+360;
lon_right_EC = -60+360;
lat_low_EC   = 0;
lat_up_EC    = 30;
lat_index{CA_index} = find (lat >lat_low_EC  & lat<lat_up_EC);
lon_index{CA_index} = find (lon >lon_left_EC & lon<lon_right_EC);

%%

Index_to_use = global_index;

mask_index_to_use = mask_urban_temp(lon_index{Index_to_use},lat_index{Index_to_use});

sum(~isnan(mask_index_to_use(:))) % number of grid cells to average
% display_map(mask_index_to_use,1) % map of grid cells to average

% average temperatures
TSA_U_average = squeeze(mean(TSA_U(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
TSA_R_average = squeeze(mean(TSA_R(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% TSA_R_average2 = squeeze(mean(TSA_R(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_rural(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));

TSA_U_detrend_average = squeeze(mean(TSA_U_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
TSA_R_detrend_average = squeeze(mean(TSA_R_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% TSA_R_detrend_average2 = squeeze(mean(TSA_R_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_rural(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));

% average spectra
TSA_U_spectra_normalized_average = squeeze(mean(TSA_U_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
TSA_R_spectra_normalized_average = squeeze(mean(TSA_R_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
% TSA_R_spectra_normalized_average2 = squeeze(mean(TSA_R_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_rural(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));

% for k = 1:5
% % TSA_U_all_detrend_average(:,k) = squeeze(mean(TSA_U_all_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:,k).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% TSA_U_all_spectra_normalized_average(:,k) = squeeze(mean(TSA_U_all_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f),k).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
% end

% average autocorrelation

acorr_urban_transform = atanh(acorr_urban);
acorr_rural_transform = atanh(acorr_rural);

acorr_urban_transform_average = squeeze(mean(acorr_urban_transform(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)),[1 2],'omitnan'));
acorr_rural_transform_average = squeeze(mean(acorr_rural_transform(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)),[1 2],'omitnan'));

% df = sum(~isnan(mask_index_to_use(:)))*120;

% acorr_urban_transform_upper = acorr_urban_transform_average + 1.96/(df-3);
% acorr_urban_transform_lower = acorr_urban_transform_average - 1.96/(df-3);
% acorr_rural_transform_upper = acorr_rural_transform_average + 1.96/(df-3);
% acorr_rural_transform_lower = acorr_rural_transform_average - 1.96/(df-3);

acorr_urban_average = tanh(acorr_urban_transform_average);
acorr_rural_average = tanh(acorr_rural_transform_average);

% acorr_urban_upper = tanh(acorr_urban_transform_upper);
% acorr_urban_lower = tanh(acorr_urban_transform_lower);
% acorr_rural_upper = tanh(acorr_rural_transform_upper);
% acorr_rural_lower = tanh(acorr_rural_transform_lower);
% 
% lambdaminus1_urban_average = (-log(acorr_urban_average(2))).^(-1);
% lambdaminus1_rural_average = (-log(acorr_rural_average(2))).^(-1);

% histogram(lambdaminus1_urban)
% hold on
% histogram(lambdaminus1_rural)



urban_color = [181 14 0]/255;
rural_color = [0 78 218]/255;

FontSize_value = 16;
Fontname_value = 'Arial';
n_row = 2;
n_col = 2;
h = figure;
set(h, 'Position', [100, 100, 850, 600]); % [Left Bottom Width Hight]

% [ha, pos] = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
%
%   in:  Nh      number of axes in hight (vertical direction)
%        Nw      number of axes in width (horizontaldirection)
%        gap     gaps between the axes in normalized units (0...1)
%                   or [gap_h gap_w] for different gaps in height and width 
%        marg_h  margins in height in normalized units (0...1)
%                   or [lower upper] for different lower and upper margins 
%        marg_w  margins in width in normalized units (0...1)
%                   or [left right] for different left and right margins
ha = tight_subplot(n_row,n_col,[.12 .12],[0.11 .05],[.08 .03]);

% axes(ha(1));
% 
% plot(1:days,TSA_R_average,'-','LineWidth',0.6,'Color',rural_color)
% hold on
% plot(1:days,TSA_U_average,'-','LineWidth',0.6,'Color',urban_color)
% 
% xlabel('days')
% ylabel('T (K)')
% % ylim([285 315])
% 
% % legend('urban','rural')
% set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
% set(gca, 'LineWidth', 1.5)


axes(ha(1));

yyaxis left 


plot(1:days,TSA_U_detrend_average,'-','LineWidth',0.6,'Color',urban_color)
hold on
xlim([0 365*20])
ylim([-4 2])
xlabel('days')
ylabel('T^\prime (K)')
set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
set(gca, 'LineWidth', 1.5)

set(gca,'XTick',0:2000:8000);
set(gca,'XTickLabel',0:2000:8000);

yyaxis right 


plot(1:days,TSA_R_detrend_average,'-','LineWidth',0.6,'Color',rural_color)
hold on
xlim([0 365*20])
ylim([-2 4])
xlabel('days')
ylabel('T^\prime (K)')

set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
set(gca, 'LineWidth', 1.5)

ax = gca;
ax.YAxis(1).Color = urban_color;
ax.YAxis(2).Color = rural_color;

axes(ha(2));
plot(lags,acorr_urban_average,'-','LineWidth',0.6,'Color',urban_color)
hold on
% plot(lags,acorr_urban_upper,'r--','LineWidth',1)
% hold on
% plot(lags,acorr_urban_lower,'r--','LineWidth',1)
% hold on
plot(lags,acorr_rural_average,'-','LineWidth',0.6,'Color',rural_color)
hold on
% plot(lags,acorr_rural_upper,'b--','LineWidth',1)
% hold on
% plot(lags,acorr_rural_lower,'b--','LineWidth',1)
% hold on


lambda = 0.33;
lags_for_plot=0:0.01:30;
plot(lags_for_plot,exp(-lambda*lags_for_plot),'k-','LineWidth',2)
hold on
% plot(lags,(lambda).^lags,'k-','LineWidth',1)
% hold on
xlabel('\tau \rm (days)')
ylabel('AC')

ylim([-0.1 1])
xlim([0 20])

set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
set(gca, 'LineWidth', 1.5)


set(gca,'XTick',0:4:20);
set(gca,'XTickLabel',0:4:20);

legend('urban','rural','fontname',Fontname_value, 'FontSize', FontSize_value)
legend('boxoff')

axes(ha(3));

loglog(f,f.*TSA_U_spectra_normalized_average,'-','LineWidth',0.6,'Color',urban_color)
hold on
loglog(f,f.*TSA_R_spectra_normalized_average,'-','LineWidth',0.6,'Color',rural_color)
hold on

lambda = 0.45;
loglog(f,f.*(4*lambda)./((2*pi*f).^2+(lambda)^2),'k-','LineWidth',2)
hold on
plot([lambda/(2*pi) lambda/(2*pi)],[1e-2 1e0],'k--','LineWidth',1)
hold on
xlabel('\itf \rm (day^{-1})')
ylabel('\itf \rmE_{T}/\sigma_{T}^2')

xlim([9e-3 0.49])
ylim([6e-2 1e0])

set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
set(gca, 'LineWidth', 1.5)

axes(ha(4));

scatplot([lambdaminus1_urban(:);lambdaminus1_rural(:)],[TSA_U_warm_length(:);TSA_R_warm_length(:)]);
hold on
xlabel('\Gamma (days)','FontSize',16)
ylabel('Heat Event Length (days)','FontSize',16)
set(gca,'XLim',[0 10]);
set(gca,'YLim',[0 10]);
set(gca,'XTick',0:2:10);
set(gca,'YTick',0:2:10);
set(gca,'XTickLabel',0:2:10);
set(gca,'YTickLabel',0:2:10);
set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
set(gca, 'LineWidth', 1.5)
box on

print(gcf,'-dpng','-r600','Average_autocorrelation_spectrum_Ts')


%%
% urban_color = [181 14 0]/255;
% rural_color = [0 78 218]/255;
% 
% FontSize_value = 16;
% Fontname_value = 'Arial';
% n_row = 1;
% n_col = 2;
% h = figure;
% set(h, 'Position', [100, 100, 850, 350]); % [Left Bottom Width Hight]
% 
% % [ha, pos] = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
% %
% %   in:  Nh      number of axes in hight (vertical direction)
% %        Nw      number of axes in width (horizontaldirection)
% %        gap     gaps between the axes in normalized units (0...1)
% %                   or [gap_h gap_w] for different gaps in height and width 
% %        marg_h  margins in height in normalized units (0...1)
% %                   or [lower upper] for different lower and upper margins 
% %        marg_w  margins in width in normalized units (0...1)
% %                   or [left right] for different left and right margins
% ha = tight_subplot(n_row,n_col,[.12 .12],[0.15 .05],[.07 .03]);
% 
% axes(ha(1));
% 
% h = histogram(lambdaminus1_urban);
% hold on
% h.BinWidth = 0.5;
% xlim([0 10])
% ylim([0 800])
% xlabel('days')
% ylabel('Number of grid cells')
% % ylim([285 315])
% 
% % legend('urban','rural')
% set(h,'faceColor',urban_color)
% set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
% set(gca, 'LineWidth', 1.5)
% 
% 
% axes(ha(2));
% 
% h2=histogram(lambdaminus1_rural);
% hold on
% h2.BinWidth = 0.5;
% xlim([0 10])
% ylim([0 800])
% xlabel('days')
% ylabel('Number of grid cells')
% set(h2,'faceColor',rural_color)
% set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
% set(gca, 'LineWidth', 1.5)
% 
% print(gcf,'-dpng','-r600','Autocorrelation_histogram_Ts')

%%
% 
% Index_to_use = India_index;
% 
% mask_index_to_use = zeros(size(mask_urban_temp))+NaN;
% mask_index_to_use(lon_index{Index_to_use},lat_index{Index_to_use})=1;
% 
% % sum(~isnan(mask_index_to_use(:))) % number of grid cells to average
% % display_map(mask_index_to_use,1) % map of grid cells to average
% 
% % average temperatures
% TSA_U_average = squeeze(mean(TSA_U(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% TSA_R_average = squeeze(mean(TSA_R(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% TSA_R_average2 = squeeze(mean(TSA_R(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_rural(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% 
% TSA_U_detrend_average = squeeze(mean(TSA_U_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% TSA_R_detrend_average = squeeze(mean(TSA_R_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% TSA_R_detrend_average2 = squeeze(mean(TSA_R_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_rural(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% 
% % average spectra
% TSA_U_spectra_normalized_average = squeeze(mean(TSA_U_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
% TSA_R_spectra_normalized_average = squeeze(mean(TSA_R_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
% TSA_R_spectra_normalized_average2 = squeeze(mean(TSA_R_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_rural(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
% 
% % for k = 1:5
% % % TSA_U_all_detrend_average(:,k) = squeeze(mean(TSA_U_all_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:,k).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
% % TSA_U_all_spectra_normalized_average(:,k) = squeeze(mean(TSA_U_all_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f),k).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
% % end
% 
% % average autocorrelation
% 
% acorr_urban_transform = atanh(acorr_urban);
% acorr_rural_transform = atanh(acorr_rural);
% 
% acorr_urban_transform_average = squeeze(mean(acorr_urban_transform(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)),[1 2],'omitnan'));
% acorr_rural_transform_average = squeeze(mean(acorr_rural_transform(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)),[1 2],'omitnan'));
% 
% df = sum(~isnan(mask_index_to_use(:)))*120;
% 
% acorr_urban_transform_upper = acorr_urban_transform_average + 1.96/(df-3);
% acorr_urban_transform_lower = acorr_urban_transform_average - 1.96/(df-3);
% acorr_rural_transform_upper = acorr_rural_transform_average + 1.96/(df-3);
% acorr_rural_transform_lower = acorr_rural_transform_average - 1.96/(df-3);
% 
% acorr_urban_average = tanh(acorr_urban_transform_average);
% acorr_rural_average = tanh(acorr_rural_transform_average);
% 
% acorr_urban_upper = tanh(acorr_urban_transform_upper);
% acorr_urban_lower = tanh(acorr_urban_transform_lower);
% acorr_rural_upper = tanh(acorr_rural_transform_upper);
% acorr_rural_lower = tanh(acorr_rural_transform_lower);
% 
% lambdaminus1_urban_average = (-log(acorr_urban_average(2))).^(-1);
% lambdaminus1_rural_average = (-log(acorr_rural_average(2))).^(-1);
% 
% 
% urban_color = [181 14 0]/255;
% rural_color = [0 78 218]/255;
% 
% FontSize_value = 16;
% Fontname_value = 'Arial';
% n_row = 2;
% n_col = 2;
% h = figure;
% set(h, 'Position', [100, 100, 850, 600]); % [Left Bottom Width Hight]
% 
% % [ha, pos] = tight_subplot(Nh, Nw, gap, marg_h, marg_w)
% %
% %   in:  Nh      number of axes in hight (vertical direction)
% %        Nw      number of axes in width (horizontaldirection)
% %        gap     gaps between the axes in normalized units (0...1)
% %                   or [gap_h gap_w] for different gaps in height and width 
% %        marg_h  margins in height in normalized units (0...1)
% %                   or [lower upper] for different lower and upper margins 
% %        marg_w  margins in width in normalized units (0...1)
% %                   or [left right] for different left and right margins
% ha = tight_subplot(n_row,n_col,[.12 .12],[0.11 .05],[.07 .03]);
% 
% axes(ha(1));
% 
% plot(1:days,TSA_R_average,'-','LineWidth',0.6,'Color',rural_color)
% hold on
% plot(1:days,TSA_U_average,'-','LineWidth',0.6,'Color',urban_color)
% 
% xlabel('days')
% ylabel('T (K)')
% % ylim([285 315])
% 
% % legend('urban','rural')
% set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
% set(gca, 'LineWidth', 1.5)
% 
% 
% axes(ha(2));
% 
% plot(1:days,TSA_R_detrend_average,'-','LineWidth',0.6,'Color',rural_color)
% hold on
% plot(1:days,TSA_U_detrend_average,'-','LineWidth',0.6,'Color',urban_color)
% hold on
% ylim([-4 4])
% xlabel('days')
% ylabel('T^\prime (K)')
% % legend('urban','rural')
% set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
% set(gca, 'LineWidth', 1.5)
% 
% axes(ha(3));
% plot(lags,acorr_urban_average,'-','LineWidth',0.6,'Color',urban_color)
% hold on
% % plot(lags,acorr_urban_upper,'r--','LineWidth',1)
% % hold on
% % plot(lags,acorr_urban_lower,'r--','LineWidth',1)
% % hold on
% plot(lags,acorr_rural_average,'-','LineWidth',0.6,'Color',rural_color)
% hold on
% % plot(lags,acorr_rural_upper,'b--','LineWidth',1)
% % hold on
% % plot(lags,acorr_rural_lower,'b--','LineWidth',1)
% % hold on
% 
% 
% lambda = 0.3;
% lags_for_plot=0:0.01:30;
% plot(lags_for_plot,exp(-lambda*lags_for_plot),'k-','LineWidth',2)
% hold on
% % plot(lags,(lambda).^lags,'k-','LineWidth',1)
% % hold on
% xlabel('\it\tau \rm (days)')
% ylabel('AC')
% % legend('urban','rural')
% set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
% ylim([-0.1 1])
% xlim([0 15])
% set(gca, 'LineWidth', 1.5)
% 
% axes(ha(4));
% 
% loglog(f,f.*TSA_U_spectra_normalized_average,'-','LineWidth',0.6,'Color',urban_color)
% hold on
% loglog(f,f.*TSA_R_spectra_normalized_average,'-','LineWidth',0.6,'Color',rural_color)
% hold on
% 
% lambda = 0.3;
% loglog(f,f.*(4*lambda)./((2*pi*f).^2+(lambda)^2),'k-','LineWidth',2)
% hold on
% plot([lambda/(2*pi) lambda/(2*pi)],[1e-2 1e0],'k--','LineWidth',1)
% hold on
% xlabel('\itf \rm (day^{-1})')
% ylabel('\itfE_{T}/\sigma_{T}^2')
% legend('urban','rural','fontname',Fontname_value, 'FontSize', FontSize_value)
% legend('boxoff')
% 
% xlim([9e-3 0.49])
% ylim([6e-2 1e0])
% 
% set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
% set(gca, 'LineWidth', 1.5)
% 
% print(gcf,'-dpng','-r600','Average_autocorrelation_spectrum_Ts_2')



