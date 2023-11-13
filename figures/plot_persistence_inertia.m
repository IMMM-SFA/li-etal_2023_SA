close all
clear all
clc

%% 

load('data1.mat','lon','lat')
load('mu_data.mat')
load('mask_urban_and_rural.mat')

load('gamma_Ts.mat');
load('gamma.mat');

urban_color = [181 14 0]/255;
rural_color = [0 78 218]/255;

%%


edges = [0,0.1,0.2,0.35,0.45,0.6,0.8];


x_sig_temp = mu/1e4.*mask_p_AC;
y_sig_temp = lambdaminus1_diff_frac.*mask_p_AC;

x_sig = x_sig_temp(:);
y_sig = y_sig_temp(:);

keep_sig = ~isnan(x_sig(:)) & ~isnan(y_sig(:));
x2_sig = x_sig(keep_sig);
y2_sig = y_sig(keep_sig);

for i = 2:length(edges)

    xselect_sig = x2_sig > edges(i-1) & x2_sig < edges(i);

    x2_mean_sig(i-1) = mean(x2_sig(xselect_sig));
    x2_std_sig(i-1) = std(x2_sig(xselect_sig));
    
    y2_mean_sig(i-1) = mean(y2_sig(xselect_sig));
    y2_std_sig(i-1) = std(y2_sig(xselect_sig));
    
end


x_sig_temp_Ts = mu/1e4.*mask_p_AC_Ts;
y_sig_temp_Ts = lambdaminus1_diff_frac_Ts.*mask_p_AC_Ts;

x_sig_Ts = x_sig_temp_Ts(:);
y_sig_Ts = y_sig_temp_Ts(:);

keep_sig_Ts = ~isnan(x_sig_Ts(:)) & ~isnan(y_sig_Ts(:));
x2_sig_Ts = x_sig_Ts(keep_sig_Ts);
y2_sig_Ts = y_sig_Ts(keep_sig_Ts);

for i = 2:length(edges)

    xselect_sig = x2_sig_Ts > edges(i-1) & x2_sig_Ts < edges(i);

    x2_mean_sig_Ts(i-1) = mean(x2_sig_Ts(xselect_sig));
    x2_std_sig_Ts(i-1) = std(x2_sig_Ts(xselect_sig));
    
    y2_mean_sig_Ts(i-1) = mean(y2_sig_Ts(xselect_sig));
    y2_std_sig_Ts(i-1) = std(y2_sig_Ts(xselect_sig));
    
end

calculateR2(x2_mean_sig,y2_mean_sig)
calculateR2(x2_mean_sig_Ts,y2_mean_sig_Ts)


figure;
set(gcf, 'Position', [100, 100, 600, 230]) % [Left Bottom Width Hight]
box on 
set(gca, 'Position', [0.1, 0.16, 0.74, 0.82])

hold on

yyaxis left

plot(x2_mean_sig, y2_mean_sig, 'o-','Color',urban_color,'MarkerFaceColor',urban_color,'linewidth',2,'markersize',6)

up_Boundary = y2_mean_sig+y2_std_sig;
down_Boundary = y2_mean_sig-y2_std_sig;
x = [x2_mean_sig fliplr(x2_mean_sig)];
y = [up_Boundary fliplr(down_Boundary)];
h = fill(x,y,urban_color);
% Choose a number between 0 (invisible) and 1 (opaque) for facealpha.  
set(h,'facealpha',0.2)
set(h,'EdgeColor','none')

xlabel('\mu','fontname','Arial','fontsize',12)
ylabel('\delta\Gamma/\Gamma','fontname','Arial','fontsize',12)
xlim([0 0.8])
ylim([-0.2 0.8])

yyaxis right 

plot(x2_mean_sig_Ts, y2_mean_sig_Ts, 'o--','Color',rural_color,'linewidth',2,'markersize',6)

up_Boundary_Ts = y2_mean_sig_Ts+y2_std_sig_Ts;
down_Boundary_Ts = y2_mean_sig_Ts-y2_std_sig_Ts;
x = [x2_mean_sig_Ts fliplr(x2_mean_sig_Ts)];
y = [up_Boundary_Ts fliplr(down_Boundary_Ts)];
h = fill(x,y,rural_color);
% Choose a number between 0 (invisible) and 1 (opaque) for facealpha.  
set(h,'facealpha',0.2)
set(h,'EdgeColor','none')

xlabel('\mu','fontname','Arial','fontsize',12)
ylabel('\delta\Gamma/\Gamma','fontname','Arial','fontsize',12)
xlim([0 0.8])
ylim([-1 4])

set(gca,'fontname','Arial', 'FontSize', 12)
set(gca, 'LineWidth', 1.5)

ax = gca;
ax.YAxis(1).Color = urban_color;
ax.YAxis(2).Color = rural_color;

legend('near-surface air temperature','','surface temperature')
legend('boxoff')

print(gcf,'-dpng','-r600','mu_and_gamma_both')
