close all
clear all
clc

%% 
addpath('./TRM')
addpath('./m_map/')

load('mask_urban_and_rural.mat')
load('gamma.mat');
load('To.mat')
load('data1.mat','lon','lat')

%%

plot_value = To_diff_frac;

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

% sig_matrix_relocation = sig_matrix;
% sig_matrix_relocation(find(sig_matrix_relocation>180)) = sig_matrix_relocation(find(sig_matrix_relocation>180))-360;
% 
% m_scatter(sig_matrix_relocation(:,2), sig_matrix_relocation(:,1),0.5,'+','MarkerEdgecolor','k')

values_get_size = size(mask_p_AC);
mask_p_AC_relocation(1:values_get_size(1)/2,:) = mask_p_AC((values_get_size(1)/2+1):values_get_size(1),:); % flip left-right
mask_p_AC_relocation((values_get_size(1)/2+1):values_get_size(1),:) = mask_p_AC(1:values_get_size(1)/2,:);

mask_p_AC_logical = mask_p_AC_relocation==1;

[h, x_return, y_return] = stipple(xx, yy,mask_p_AC_logical,'density',150);

m_scatter(x_return,y_return, 20,'.','MarkerEdgecolor','k')

print(gcf,'-dpng','-r600','Spatial_autocorrelation_difference_fraction_To')

%%

% plot_value = To_AR1_diff_frac;
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
% caxis([-1,1]*0.25);
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
% sig_matrix_relocation = sig_matrix;
% sig_matrix_relocation(find(sig_matrix_relocation>180)) = sig_matrix_relocation(find(sig_matrix_relocation>180))-360;
% 
% m_scatter(sig_matrix_relocation(:,2), sig_matrix_relocation(:,1),0.5,'+','MarkerEdgecolor','k')
% 
% print(gcf,'-dpng','-r600','Spatial_autocorrelation_difference_fraction_To_AR1')






