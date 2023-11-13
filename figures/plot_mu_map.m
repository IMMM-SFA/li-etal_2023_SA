close all
clear all
clc

%% 
addpath('./TRM')
addpath('./m_map/')


load('mu_data.mat')
load('mask_urban_and_rural.mat')
load('data1.mat','lon','lat')



%% 

plot_value = mu/1e4.*mask_urban_temp;

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
caxis([0,0.5]);
colormap(flipud(m_colmap('Blue'))); % jet; diverging; BOD; Blue
ax = gca;
axpos = ax.Position;
axpos(1) = axpos(1)-0.01;
c.Position(3) = 0.5*c.Position(3);
ax.Position = axpos;
cbarrow;

set(gca,'fontname','Arial', 'FontSize', 14)

print(gcf,'-dpng','-r600','Spatial_mu')


%%
plot_value = mu_roof/1e4.*mask_urban_temp;

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
caxis([0,0.5]);
colormap(flipud(m_colmap('Blue'))); % jet; diverging; BOD; Blue
ax = gca;
axpos = ax.Position;
axpos(1) = axpos(1)-0.01;
c.Position(3) = 0.5*c.Position(3);
ax.Position = axpos;
cbarrow;

set(gca,'fontname','Arial', 'FontSize', 14)

print(gcf,'-dpng','-r600','Spatial_mu_roof')


%%
plot_value = mu_wall/1e4.*mask_urban_temp;

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
caxis([0,0.5]);
colormap(flipud(m_colmap('Blue'))); % jet; diverging; BOD; Blue
ax = gca;
axpos = ax.Position;
axpos(1) = axpos(1)-0.01;
c.Position(3) = 0.5*c.Position(3);
ax.Position = axpos;
cbarrow;

set(gca,'fontname','Arial', 'FontSize', 14)

print(gcf,'-dpng','-r600','Spatial_mu_wall')


%%
plot_value = mu_imp/1e4.*mask_urban_temp;

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
caxis([0,0.5]);
colormap(flipud(m_colmap('Blue'))); % jet; diverging; BOD; Blue
ax = gca;
axpos = ax.Position;
axpos(1) = axpos(1)-0.01;
c.Position(3) = 0.5*c.Position(3);
ax.Position = axpos;
cbarrow;

set(gca,'fontname','Arial', 'FontSize', 14)

print(gcf,'-dpng','-r600','Spatial_mu_imp')