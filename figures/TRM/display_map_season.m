function display_map_season(Values_input_annual_north, Values_input_annual_south, average_period_value, value_limit)

values_get = Values_input_annual_north;

values_get_size = size(values_get);
values = zeros (size(values_get)) + NaN;

values(1:values_get_size(1)/2,:) = values_get((values_get_size(1)/2+1):end,:); % flip left-right
values((values_get_size(1)/2+1):end,:) = values_get(1:values_get_size(1)/2,:);


figure;
set(gcf, 'Position', [100, 100, 650, 310]) % [Left Bottom Width Hight]

%% upper figure
subplot('Position', [0.1, 0.47, 0.74, 0.49]) % [Left Bottom Width Hight]
set(gca, 'LineWidth', 0.3)
box on 
hold on 

% axis equal
lon1 = -180; lon2 = 180; lat1 = -90; lat2 = 90;
set(gca,'XLim',[lon1 lon2],'YLim',[0 lat2]);
set(gca,'XTick',lon1:30:lon2);
% set(gca,'XTickLabel',{'180^o','','120^oW','','60^oW','','0^o','','60^oE','','120^oE','','180^o'});
set(gca,'XTickLabel',{''});
set(gca,'YTick',-60:15:lat2);
set(gca,'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
set(gca,'fontname','Arial', 'FontSize', 20)
set(gca,'TickLength', [0.008 0.008])
% set(gca,'Tickdir','out')
% xlabel('longitude','fontsize',14)
% ylabel('latitude','fontsize',14)

% cmap_temp = [8 82 156;
%     33 113 181;
%     66 146 199;
%     90 160 205;
%     120 191 214;
%     170 220 230;
%     219 245 255;
%     255 255 255;
%     255 224 224;
%     252 187 170;
%     252 146 114;
%     251 106 74;
%     240 60 43;
%     204 24 30;
%     166 15 20;] / 255;

% cmap_temp = [8 82 156;
%     33 113 181;
%     66 146 199;
%     90 160 205;
%     120 191 214;
%     170 220 230;
%     219 245 255;
%     255 224 224;
%     252 187 170;
%     252 146 114;
%     251 106 74;
%     240 60 43;
%     204 24 30;
%     166 15 20] / 255;

cmap_temp = [8 82 156;
    33 113 181;
    66 146 199;
    90 160 205;
    120 191 214;
    170 220 230;
    219 245 255;
    255 255 255;
    255 224 224;
    252 187 170;
    252 146 114;
    251 106 74;
    240 60 43;
    204 24 30;
    166 15 20;] / 255;

% min(values(:))
% max(values(:))
% figure; hist(reshape(values, [144*90,1]),50)

% Color_value = [-2.5, -2, -1.5, -1, -0.5, -0.2, -0.1,...
%     0.1, 0.2, 0.5, 1, 1.5, 2, 2.5];

% Color_value = [-2, -1.5, -1, -0.5, -0.2, -0.1, 0,...
%     0.1, 0.2, 0.5, 1, 1.5, 2]/2*value_limit;
% 
% 
% out_mat = nan(size(values));
% out_mat(values<Color_value(1)) = 1-0.5;
% out_mat(values>=Color_value(end)) = length(Color_value)+1-0.5;
% for i = 1:length(Color_value)-1
%     out_mat(values>=Color_value(i) & values<Color_value(i+1)) = i+1-0.5;
% end

Color_value = [-2, -1.5, -1, -0.5, -0.2, -0.1, -0.05,...
    0.05, 0.1, 0.2, 0.5, 1, 1.5, 2]/2*value_limit;

out_mat = nan(size(values));
out_mat(values<Color_value(1)) = 1;
out_mat(values>=Color_value(end)) = length(Color_value)+1;
for i = 1:length(Color_value)-1
    out_mat(values>=Color_value(i) & values<Color_value(i+1)) = i+1;
end

% out_mat = nan(size(values));
% out_mat(values<=Color_value(1)) = 1-0.5;
% out_mat(values>Color_value(end)) = length(Color_value)+1-0.5;
% for i = 1:length(Color_value)-1
%     out_mat(values>Color_value(i) & values<=Color_value(i+1)) = i+1-0.5;
% end

R = georasterref('RasterSize',[values_get_size(2) values_get_size(1)],'Latlim',[lat1 lat2],'Lonlim',[lon1 lon2]);
geoimg = geoshow(flipud(rot90(out_mat)), R, 'DisplayType', 'texturemap');
geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
geoimg.FaceAlpha = 'texturemap'; % Indicate that the transparency can be different each pixel
alpha(geoimg,double(~isnan(flipud(rot90(out_mat))))) % Change transparency to matrix where if data==NaN --> transparency = 1, else 0.
    
colormap(cmap_temp)
caxis([0 length(Color_value)+1])

% plot worldmap
coast = load('coast');
geoshow(coast.lat, coast.long, 'Color', 'black', 'Linewidth', 0.2)

if average_period_value == 2
    text(-175,10,'JJA','fontname','Arial', 'FontSize', 20)
elseif average_period_value == 3
    text(-175,10,'DJF','fontname','Arial', 'FontSize', 20)
end

%% bottom figure
values_get = Values_input_annual_south;

values_get_size = size(values_get);
values = zeros (size(values_get)) + NaN;

values(1:values_get_size(1)/2,:) = values_get((values_get_size(1)/2+1):end,:); % flip left-right
values((values_get_size(1)/2+1):end,:) = values_get(1:values_get_size(1)/2,:);

subplot('Position', [0.1, 0.1, 0.74, 0.32]) % [Left Bottom Width Hight]

set(gca, 'LineWidth', 0.3)
box on 
hold on 

% axis equal
% lon1 = -180; lon2 = 180; lat1 = -90; lat2 = 90;
set(gca,'XLim',[lon1 lon2],'YLim',[-60 0]);
set(gca,'XTick',lon1:30:lon2);
set(gca,'XTickLabel',{'180^o','','120^oW','','60^oW','','0^o','','60^oE','','120^oE','','180^o'});
% set(gca,'XTickLabel',{''});
set(gca,'YTick',-60:15:lat2);
set(gca,'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
set(gca,'fontname','Arial', 'FontSize', 20)
set(gca,'TickLength', [0.008 0.008])
% set(gca,'Tickdir','out')
% xlabel('longitude','fontsize',14)
% ylabel('latitude','fontsize',14)


out_mat = nan(size(values));
out_mat(values<Color_value(1)) = 1-0.5;
out_mat(values>=Color_value(end)) = length(Color_value)+1-0.5;
for i = 1:length(Color_value)-1
    out_mat(values>=Color_value(i) & values<Color_value(i+1)) = i+1-0.5;
end

R = georasterref('RasterSize',[values_get_size(2) values_get_size(1)],'Latlim',[lat1 lat2],'Lonlim',[lon1 lon2]);
geoimg = geoshow(flipud(rot90(out_mat)), R, 'DisplayType', 'texturemap');
geoimg.AlphaDataMapping = 'none'; % interpet alpha values as transparency values
geoimg.FaceAlpha = 'texturemap'; % Indicate that the transparency can be different each pixel
alpha(geoimg,double(~isnan(flipud(rot90(out_mat))))) % Change transparency to matrix where if data==NaN --> transparency = 1, else 0.
    
colormap(cmap_temp)
caxis([0 length(Color_value)+1])

% plot worldmap
coast = load('coast');
geoshow(coast.lat, coast.long, 'Color', 'black', 'Linewidth', 0.2)

if average_period_value == 2
    text(-175,-50,'DJF','fontname','Arial', 'FontSize', 20)
elseif average_period_value == 3
    text(-175,-50,'JJA','fontname','Arial', 'FontSize', 20)
end

% clolrbar
h = colorbar('Eastoutside');
set(h,'position',[0.86, 0.1, 0.02, 0.86])
set(h,'Ticks', 0:1:15)
set(h,'TickLabels', {'',num2str(Color_value(1)),num2str(Color_value(2)),num2str(Color_value(3)),num2str(Color_value(4)),...
    num2str(Color_value(5)),num2str(Color_value(6)),num2str(Color_value(7)),num2str(Color_value(8)),num2str(Color_value(9)),...
    num2str(Color_value(10)),num2str(Color_value(11)),num2str(Color_value(12)),num2str(Color_value(13)),num2str(Color_value(14)),''})
set(h,'fontname','Arial', 'FontSize', 18)
set(h,'ticklength',0.046)
set(h,'LineWidth', 0.05)