close all
clear all
clc

%% 
addpath('./TRM')
addpath('./m_map/')

load('data1.mat','lon','lat')
load('gamma_spring.mat','lambdaminus1_diff_frac_spring','sig_matrix_spring','mask_p_AC_spring');
load('mu_data.mat')
load('mask_urban_and_rural.mat')

%% Figure 2a

plot_value = lambdaminus1_diff_frac_spring;

values_get_size = size(plot_value);
var_plot_final_relocation(1:values_get_size(1)/2,:) = plot_value((values_get_size(1)/2+1):values_get_size(1),:); % flip left-right
var_plot_final_relocation((values_get_size(1)/2+1):values_get_size(1),:) = plot_value(1:values_get_size(1)/2,:);

lon_relocation(1:values_get_size(1)/2,1) = lon((values_get_size(1)/2+1):values_get_size(1),1)-360;
lon_relocation((values_get_size(1)/2+1):values_get_size(1),1) = lon(1:values_get_size(1)/2,1);

[xx,yy] = meshgrid(lon_relocation,lat);
xx = xx';
yy = yy';

figure;
set(gcf, 'Position', [100, 100, 650, 310]) % [Left Bottom Width Hight]
m_proj('Equidistant','long',[-180,180],'lat',[-60,90]);
% m_proj('miller','lon',180,'lat',[-90 90])
% m_contourf(xx,yy,var_plot,50,'linestyle','none')
m_pcolor(xx,yy,var_plot_final_relocation)
% shading interp
% h=m_coast('patch',[0.8 0.8 0.8],'edgecolor','none');
hold on;
% m_gshhs_i('patch',[0.6 0.6 0.6],'edgecolor','k');
m_coast('color',[0 0 0],'linewidth',1);
% m_coast('patch',[1 .85 .7]);
m_grid('ytick',[-60:30:90],'xtick',[-180:60:180],'tickdir','out','linest','none','fontname','Arial','fontsize',12,'linewidth',1.5);
% title(variable_plot_all{ivar},'fontsize',12);
c = colorbar('eastoutside','ticklength',0);
caxis([-1,1]*0.25);
colormap(m_colmap('jet',10));
ax = gca;
axpos = ax.Position;
axpos(1) = axpos(1)-0.01;
c.Position(3) = 0.5*c.Position(3);
ax.Position = axpos;
cbarrow;

set(gca,'fontname','Arial', 'FontSize', 14)

% sig_matrix_relocation = sig_matrix_spring;
% sig_matrix_relocation(find(sig_matrix_relocation>180)) = sig_matrix_relocation(find(sig_matrix_relocation>180))-360;
% 
% m_scatter(sig_matrix_relocation(:,2), sig_matrix_relocation(:,1),0.5,'+','MarkerEdgecolor','k')

values_get_size = size(mask_p_AC_spring);
mask_p_AC_relocation(1:values_get_size(1)/2,:) = mask_p_AC_spring((values_get_size(1)/2+1):values_get_size(1),:); % flip left-right
mask_p_AC_relocation((values_get_size(1)/2+1):values_get_size(1),:) = mask_p_AC_spring(1:values_get_size(1)/2,:);

mask_p_AC_logical = mask_p_AC_relocation==1;

[h, x_return, y_return] = stipple(xx, yy,mask_p_AC_logical,'density',300);

m_scatter(x_return,y_return, 20,'.','MarkerEdgecolor','k')

print(gcf,'-dpng','-r600','Spatial_autocorrelation_difference_fraction_spring')

%% Figure 2b

% plot_value = mu/1e4.*mask_urban_temp;
% 
% values_get_size = size(plot_value);
% var_plot_final_relocation(1:values_get_size(1)/2,:) = plot_value((values_get_size(1)/2+1):values_get_size(1),:); % flip left-right
% var_plot_final_relocation((values_get_size(1)/2+1):values_get_size(1),:) = plot_value(1:values_get_size(1)/2,:);
% 
% lon_relocation(1:values_get_size(1)/2,1) = lon((values_get_size(1)/2+1):values_get_size(1),1)-360;
% lon_relocation((values_get_size(1)/2+1):values_get_size(1),1) = lon(1:values_get_size(1)/2,1);
% 
% [xx,yy] = meshgrid(lon_relocation,lat);
% xx = xx';
% yy = yy';
% 
% figure;
% set(gcf, 'Position', [100, 100, 650, 310]) % [Left Bottom Width Hight]
% m_proj('Equidistant','long',[-180,180],'lat',[-60,90]);
% % m_proj('miller','lon',180,'lat',[-90 90])
% % m_contourf(xx,yy,var_plot,50,'linestyle','none')
% m_pcolor(xx,yy,var_plot_final_relocation)
% % shading interp
% % h=m_coast('patch',[0.8 0.8 0.8],'edgecolor','none');
% hold on;
% % m_gshhs_i('patch',[0.6 0.6 0.6],'edgecolor','k');
% m_coast('color',[0 0 0],'linewidth',1);
% % m_coast('patch',[1 .85 .7]);
% m_grid('ytick',[-60:30:90],'xtick',[-180:60:180],'tickdir','out','linest','none','fontname','Arial','fontsize',12,'linewidth',1.5);
% % title(variable_plot_all{ivar},'fontsize',12);
% c = colorbar('eastoutside','ticklength',0);
% caxis([0,1]);
% colormap(m_colmap('jet',10));
% ax = gca;
% axpos = ax.Position;
% axpos(1) = axpos(1)-0.01;
% c.Position(3) = 0.5*c.Position(3);
% ax.Position = axpos;
% cbarrow;
% 
% set(gca,'fontname','Arial', 'FontSize', 14)
% 
% print(gcf,'-dpng','-r600','Spatial_mu')


%% Figure 2c

% x = mu(:)/1e4;
% y = lambdaminus1_diff_frac_spring(:);
% 
% keep = ~isnan(x) & ~isnan(y);
% x2 = x(keep);
% y2 = y(keep);
% % 
% edges = [0,0.2,0.35,0.45,0.6,0.8];
% 
% 
% 
% for i = 2:length(edges)
% 
%     xselect = x2 > edges(i-1) & x2 < edges(i);
% 
%     x2_mean(i-1) = mean(x2(xselect));
%     x2_std(i-1) = std(x2(xselect));
%     
%     y2_mean(i-1) = mean(y2(xselect));
%     y2_std(i-1) = std(y2(xselect));
%     
% end
% 
% x_sig_temp = mu/1e4.*mask_p_AC_spring;
% y_sig_temp = lambdaminus1_diff_frac_spring.*mask_p_AC_spring;
% 
% x_sig = x_sig_temp(:);
% y_sig = y_sig_temp(:);
% 
% keep_sig = ~isnan(x_sig(:)) & ~isnan(y_sig(:));
% x2_sig = x_sig(keep_sig);
% y2_sig = y_sig(keep_sig);
% 
% for i = 2:length(edges)
% 
%     xselect_sig = x2_sig > edges(i-1) & x2_sig < edges(i);
% 
%     x2_mean_sig(i-1) = mean(x2_sig(xselect_sig));
%     x2_std_sig(i-1) = std(x2_sig(xselect_sig));
%     
%     y2_mean_sig(i-1) = mean(y2_sig(xselect_sig));
%     y2_std_sig(i-1) = std(y2_sig(xselect_sig));
%     
% end
% 
% 
% figure;
% set(gcf, 'Position', [100, 100, 600, 230]) % [Left Bottom Width Hight]
% box on 
% set(gca, 'Position', [0.1, 0.16, 0.74, 0.82])
% 
% hold on
% 
% % plot(x2,y2,'k.')
% % hold on
% % errorbar(x2_mean,y2_mean,y2_std,'ro','MarkerFaceColor','r','markersize',8)
% % hold on
% 
% % plot(x2_sig,y2_sig,'k.')
% % hold on
% errorbar(x2_mean_sig,y2_mean_sig,y2_std_sig,'o','Color',[181 14 0]/255,'MarkerFaceColor',[181 14 0]/255,'markersize',8)
% hold on
% 
% x1 = 0:0.1:0.5;
% x2 = 0.5:0.1:10;
% x3 = 0:0.1:10;
% 
% y1 = x1;
% y2 = zeros(size(x2))+0.5;
% y3 = x3./(x3+2);
% 
% 
% % plot(x1,x1,'k--','linewidth',2)
% % hold on
% % plot(x2,y2,'k--','linewidth',2)
% % hold on
% % plot(x3,y3,'r-','linewidth',2)
% % hold on
% 
% xlabel('\mu','fontname','Arial','fontsize',12)
% ylabel('\delta\Gamma/\Gamma','fontname','Arial','fontsize',12)
% xlim([0 1])
% ylim([0 0.6])
% set(gca,'fontname','Arial', 'FontSize', 12)
% set(gca, 'LineWidth', 1.5)
% print(gcf,'-dpng','-r600','mu_and_gamma_spring')
