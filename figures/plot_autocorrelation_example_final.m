clear all
close all
clc

%%
addpath('./TRM')
addpath('./m_map')
    
load('data1.mat','lat','lon','rows','colms','days','dates','TSA_U','TSA_R');
load('data2.mat','TSA_U_detrend','TSA_R_detrend');

load autocorrelation.mat
load spectra_data.mat
load mask_urban_and_rural.mat
load gamma.mat


urban_color = [0.8500 0.3250 0.0980];
rural_color = [0 0.4470 0.7410];

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
lon_left_EC  = -118+360;
lon_right_EC = -82+360;
lat_low_EC   = 7;
lat_up_EC    = 18;
lat_index{CA_index} = find (lat >lat_low_EC  & lat<lat_up_EC);
lon_index{CA_index} = find (lon >lon_left_EC & lon<lon_right_EC);



Index_to_use = global_index;

mask_index_to_use = zeros(size(mask_urban_temp))+NaN;
mask_index_to_use(lon_index{Index_to_use},lat_index{Index_to_use})=mask_urban(lon_index{Index_to_use},lat_index{Index_to_use});


sum(~isnan(mask_index_to_use(:))) % number of grid cells to average

mask_index_to_use_CA = zeros(size(mask_urban_temp))+NaN;
mask_index_to_use_CA(lon_index{CA_index},lat_index{CA_index})=mask_urban(lon_index{CA_index},lat_index{CA_index});

sum(~isnan(mask_index_to_use_CA(:))) % number of grid cells to average


% display_map(mask_index_to_use,1) % map of grid cells to average

% average temperatures
TSA_U_average = squeeze(mean(TSA_U(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
TSA_R_average = squeeze(mean(TSA_R(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));

TSA_U_detrend_average = squeeze(mean(TSA_U_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));
TSA_R_detrend_average = squeeze(mean(TSA_R_detrend(lon_index{Index_to_use},lat_index{Index_to_use},:).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},:),[1 2],'omitnan'));

% average spectra
TSA_U_spectra_normalized_mean = squeeze(mean(TSA_U_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
TSA_R_spectra_normalized_mean = squeeze(mean(TSA_R_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)),[1 2],'omitnan'));
TSA_U_spectra_normalized_std = squeeze(std(TSA_U_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)), 0, [1, 2], 'omitnan'));
TSA_R_spectra_normalized_std = squeeze(std(TSA_R_spectra_normalized(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(f)), 0, [1, 2], 'omitnan'));

% average autocorrelation

acorr_urban_transform = atanh(acorr_urban);
acorr_rural_transform = atanh(acorr_rural);

acorr_urban_transform_average = squeeze(mean(acorr_urban_transform(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)),[1 2],'omitnan'));
acorr_rural_transform_average = squeeze(mean(acorr_rural_transform(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)).*mask_urban(lon_index{Index_to_use},lat_index{Index_to_use},1:length(lags)),[1 2],'omitnan'));
acorr_urban_average = tanh(acorr_urban_transform_average);
acorr_rural_average = tanh(acorr_rural_transform_average);


df = (sum(~isnan(mask_index_to_use(:)))*1e4)/(1e6)*(days)

acorr_urban_transform_upper = acorr_urban_transform_average + 1.96/(df-3);
acorr_urban_transform_lower = acorr_urban_transform_average - 1.96/(df-3);
acorr_rural_transform_upper = acorr_rural_transform_average + 1.96/(df-3);
acorr_rural_transform_lower = acorr_rural_transform_average - 1.96/(df-3);

acorr_urban_upper = tanh(acorr_urban_transform_upper);
acorr_urban_lower = tanh(acorr_urban_transform_lower);
acorr_rural_upper = tanh(acorr_rural_transform_upper);
acorr_rural_lower = tanh(acorr_rural_transform_lower);


acorr_urban_transform_average_index1 = squeeze(mean(acorr_urban_transform(lon_index{CA_index},lat_index{CA_index},1:length(lags)).*mask_urban(lon_index{CA_index},lat_index{CA_index},1:length(lags)),[1 2],'omitnan'));
acorr_rural_transform_average_index1 = squeeze(mean(acorr_rural_transform(lon_index{CA_index},lat_index{CA_index},1:length(lags)).*mask_urban(lon_index{CA_index},lat_index{CA_index},1:length(lags)),[1 2],'omitnan'));
acorr_urban_average_index1 = tanh(acorr_urban_transform_average_index1);
acorr_rural_average_index1 = tanh(acorr_rural_transform_average_index1);


df = (sum(~isnan(mask_index_to_use_CA(:)))*1e4)/(1e6)*(days)

acorr_urban_transform_upper_index1 = acorr_urban_transform_average_index1 + 1.96/(df-3);
acorr_urban_transform_lower_index1 = acorr_urban_transform_average_index1 - 1.96/(df-3);
acorr_rural_transform_upper_index1 = acorr_rural_transform_average_index1 + 1.96/(df-3);
acorr_rural_transform_lower_index1 = acorr_rural_transform_average_index1 - 1.96/(df-3);

acorr_urban_upper_index1 = tanh(acorr_urban_transform_upper_index1);
acorr_urban_lower_index1 = tanh(acorr_urban_transform_lower_index1);
acorr_rural_upper_index1 = tanh(acorr_rural_transform_upper_index1);
acorr_rural_lower_index1 = tanh(acorr_rural_transform_lower_index1);


%%
FontSize_value = 16;
Fontname_value = 'Arial';
n_row = 1;
n_col = 3;
h = figure;
set(h, 'Position', [0, 0, 1400, 400]); % [Left Bottom Width Hight]

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
ha = tight_subplot(n_row,n_col,[.12 .05],[0.15 .05],[.08 .03]);



% Ensure 'lags' is a column vector for consistency
if isrow(lags)
    lags = lags'; % Transpose to column vector
end

% Panel A - Urban and Rural with error bars for Global
axes(ha(1));
hold on;

% Calculate the errors for the urban data
urban_error_upper = acorr_urban_upper - acorr_urban_average;
urban_error_lower = acorr_urban_average - acorr_urban_lower;

% Urban autocorrelation with error bars
errorbar(lags, acorr_urban_average, urban_error_lower, urban_error_upper, 'o', 'LineWidth', 1.5, 'Color', urban_color, 'MarkerFaceColor', urban_color, 'CapSize', 10);

% Calculate the errors for the rural data
rural_error_upper = acorr_rural_upper - acorr_rural_average;
rural_error_lower = acorr_rural_average - acorr_rural_lower;

% Rural autocorrelation with error bars
errorbar(lags, acorr_rural_average, rural_error_lower, rural_error_upper, 'x', 'LineWidth', 1.5, 'Color', rural_color, 'MarkerFaceColor', rural_color, 'CapSize', 10);

% Theoretical curve
lambda = 0.3;
lags_for_plot = 0:0.01:30;
plot(lags_for_plot, exp(-lambda*lags_for_plot), 'k-', 'LineWidth', 2);

% Plot formatting
xlabel('\tau \rm (days)');
ylabel('AC');
ylim([0 1]);
xlim([0 10]);
set(gca, 'FontName', Fontname_value, 'FontSize', FontSize_value, 'LineWidth', 1.5);
set(gca, 'XTick', 0:2:10, 'XTickLabel', 0:2:10);
legend('Urban', 'Rural', 'Theoretical', 'FontName', Fontname_value, 'FontSize', FontSize_value);
legend('boxoff');
box on;

% Release the plot hold
hold off;

% Panel 2 - Urban and Rural autocorrelation with error bars for Central America
axes(ha(2));
hold on;

% Calculate the distance from the mean to the upper and lower bounds for error bars
urban_error_upper_index1 = acorr_urban_upper_index1 - acorr_urban_average_index1;
urban_error_lower_index1 = acorr_urban_average_index1 - acorr_urban_lower_index1;
rural_error_upper_index1 = acorr_rural_upper_index1 - acorr_rural_average_index1;
rural_error_lower_index1 = acorr_rural_average_index1 - acorr_rural_lower_index1;

% Urban error bars
errorbar(lags, acorr_urban_average_index1, urban_error_lower_index1, urban_error_upper_index1, ...
    'o', 'LineWidth', 1.5, 'Color', urban_color, 'MarkerFaceColor', urban_color, 'CapSize', 10);

% Rural error bars
errorbar(lags, acorr_rural_average_index1, rural_error_lower_index1, rural_error_upper_index1, ...
    'x', 'LineWidth', 1.5, 'Color', rural_color, 'MarkerFaceColor', rural_color, 'CapSize', 10);


% Urban error bars
errorbar(lags, acorr_urban_average_index1, urban_error_lower_index1, urban_error_upper_index1, ...
    '-o', 'LineWidth', 1.5, 'Color', urban_color, 'MarkerFaceColor', urban_color, 'CapSize', 10);

% Rural error bars
errorbar(lags, acorr_rural_average_index1, rural_error_lower_index1, rural_error_upper_index1, ...
    '-x', 'LineWidth', 1.5, 'Color', rural_color, 'MarkerFaceColor', rural_color, 'CapSize', 10);


% Additional plot settings
xlabel('\tau \rm (days)')
ylabel('AC')
ylim([0 1])
xlim([0 10])
set(gca, 'fontname', Fontname_value, 'FontSize', FontSize_value)
set(gca, 'LineWidth', 1.5)
set(gca, 'XTick', 0:2:10)
set(gca, 'XTickLabel', 0:2:10)
legend({'Urban', 'Rural'}, 'fontname', Fontname_value, 'FontSize', FontSize_value)
legend('boxoff')
box on
hold off;


axes(ha(3));

scatplot([lambdaminus1_urban(:);lambdaminus1_rural(:)],[TSA_U_warm_length(:);TSA_R_warm_length(:)]);
hold on

% scatplot([lambdaminus1_urban_summer(:);lambdaminus1_rural_summer(:)],[TSA_U_HW_spatial{variable_to_plot,method_to_plot}(:);TSA_R_HW_spatial{variable_to_plot,method_to_plot}(:)]);
% hold on

xlabel('\Gamma (days)','FontSize',16)
ylabel('Heat Event Length (days)','FontSize',16)

% title('Grid cell', 'FontWeight', 'normal')
set(gca,'XLim',[0 8]);
set(gca,'YLim',[0 8]);
set(gca,'XTick',0:2:8);
set(gca,'YTick',0:2:8);
set(gca,'XTickLabel',0:2:8);
set(gca,'YTickLabel',0:2:8);
set(gca,'fontname',Fontname_value, 'FontSize', FontSize_value)
set(gca, 'LineWidth', 1.5)
box on

% labels = {'A', 'B', 'C', 'D'};
% for i = 1:length(ha)
%     axes(ha(i)); % Make current axis active
%     text(-0.1, 1.15, labels{i}, 'Units', 'Normalized', 'VerticalAlignment', 'Top', 'FontSize', FontSize_value, 'FontWeight', 'Bold');
% end

print(gcf,'-dpng','-r600','Average_autocorrelation')



%%
figure;
set(gcf, 'Position', [100, 100, 650, 400]) % [Left Bottom Width Hight]
box on 
set(gca, 'Position', [0.12, 0.16, 0.85, 0.8])

hold on


f_linear = f(2:end-1); 

TSA_U_pre_multiplied = f_linear .* TSA_U_spectra_normalized_mean(2:end-1);
TSA_R_pre_multiplied = f_linear .* TSA_R_spectra_normalized_mean(2:end-1);

TSA_U_upper_pre_multiplied = f_linear .* (TSA_U_spectra_normalized_mean(2:end-1) + TSA_U_spectra_normalized_std(2:end-1));
TSA_U_lower_pre_multiplied = f_linear .* (TSA_U_spectra_normalized_mean(2:end-1) - TSA_U_spectra_normalized_std(2:end-1));
TSA_R_upper_pre_multiplied = f_linear .* (TSA_R_spectra_normalized_mean(2:end-1) + TSA_R_spectra_normalized_std(2:end-1));
TSA_R_lower_pre_multiplied = f_linear .* (TSA_R_spectra_normalized_mean(2:end-1) - TSA_R_spectra_normalized_std(2:end-1));


% Rural mean and shading
fill([f_linear; flipud(f_linear)], [TSA_R_upper_pre_multiplied; flipud(TSA_R_lower_pre_multiplied)], rural_color, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
p2 = plot(f_linear, TSA_R_pre_multiplied, 'x', 'LineWidth', 1.5, 'Color', rural_color);


% Urban mean and shading
fill([f_linear; flipud(f_linear)], [TSA_U_upper_pre_multiplied; flipud(TSA_U_lower_pre_multiplied)], urban_color, 'FaceAlpha', 0.3, 'EdgeColor', 'none');
p1 = plot(f_linear, TSA_U_pre_multiplied, 'o', 'LineWidth', 1.5, 'Color', urban_color);


% Plot theoretical curve on linear axes
lambda = 0.45;
p3 = plot(f_linear, f_linear.*(4*lambda)./((2*pi*f_linear).^2 + lambda^2), 'k-', 'LineWidth', 2);
hold on
plot([lambda/(2*pi) lambda/(2*pi)],[0.01 1e0],'k--','LineWidth',1)
hold on
% Set the axes labels
xlabel('\itf \rm (day^{-1})');
ylabel('\itf \rmE_{T}/\sigma_{T}^2');


% % Set the axis limits (choose limits that make sense for your data)
% xlim([0, 0.5]);
% ylim([0, 0.5]);
% 
% % Set the ticks to mimic a log-log scale (you will need to adjust this based on your actual f values)
% set(gca, 'XTick', 0:0.1:0.5);
% set(gca, 'XTickLabel', {'0', '0.1', '0.2', '0.3','0.4','0.5'});
% set(gca, 'YTick', 0:0.1:0.5);
% set(gca, 'YTickLabel', {'0', '0.1', '0.2', '0.3','0.4','0.5'});

% Set the axes to log-log
set(gca, 'XScale', 'log', 'YScale', 'log');
xlim([1e-2, 0.5]);
ylim([0.05, 1]);

% Set the font properties
set(gca, 'fontname', 'Arial', 'FontSize', 16);
set(gca, 'LineWidth', 1.5);

% Create the legend
legend([p1, p2, p3], {'Urban', 'Rural', 'Theoretical'},'fontname',Fontname_value, 'FontSize', FontSize_value);
legend('boxoff');
box on
% Release the plot hold
hold off;


print(gcf,'-dpng','-r600','Spectrum')




