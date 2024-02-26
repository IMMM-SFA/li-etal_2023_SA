function display_latitudinal_dependence_annual(Values_input_annual, lat_input, x_limit)

figure;
set(gcf, 'Position', [100, 100, 200, 310]) % [Left Bottom Width Hight]

%% upper figure

values_latitudinal_mean = nanmean(Values_input_annual,1)';
values_latitudinal_std = nanstd(Values_input_annual,1)';

subplot('Position', [0.1, 0.1, 0.53, 0.86]) % [Left Bottom Width Hight]
% subplot('Position', [0.11, 0.47, 0.53, 0.49]) % for dTs_drs
set(gca, 'LineWidth', 0.3)
box on 
hold on 

value_x = values_latitudinal_mean;
value_y = lat_input;
up_value_x = values_latitudinal_mean + values_latitudinal_std;
down_value_x = values_latitudinal_mean - values_latitudinal_std;
value_x_nan = find(isnan(value_x));
value_x(value_x_nan) = [];
value_y(value_x_nan) = [];
up_value_x(value_x_nan) = [];
down_value_x(value_x_nan) = [];

plot([0 0],[-60 90],'k-','linewidth',0.2)

plot(value_x,value_y,'k-','linewidth',1.4)

x = [up_value_x' fliplr(down_value_x')];
y = [value_y' fliplr(value_y')];
h = fill(x,y,'k');
% Choose a number between 0 (invisible) and 1 (opaque) for facealpha.  
set(h,'facealpha',0.2)
set(h,'EdgeColor','none')

set(gca,'XLim',x_limit);
% set(gca,'XTick',[x_limit(1) x_limit(1)/2 0 x_limit(2)/2 x_limit(2)]);
set(gca,'XTick',[x_limit(1) 0 x_limit(2)]);
set(gca,'YLim',[-60 90]);
set(gca,'YTick',-60:15:90);
set(gca,'YAxisLocation','right')
set(gca,'YTickLabel',{'60^oS','','30^oS','','0^o','','30^oN','','60^oN','','90^oN'});
set(gca,'fontname','Arial', 'FontSize', 20)


