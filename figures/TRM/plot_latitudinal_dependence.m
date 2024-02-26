function plot_latitudinal_dependence(Values_input, mask, average_period_value, lat_input, x_limit, yr_Num)

% The size of each variable
% Values_input: 144*72*?
% mask: 144*72*?
% average_year_start: start from ?
% average_year_end: end at ?
% average_period_value = 1 (annual), 2(summer), 3(winter)

if average_period_value == 1
    
    average_period = 1:12;
    Values_input_average = annual_average(Values_input.*mask, average_period, yr_Num);
    Values_input_annual = nanmean(Values_input_average,3);
    
    display_latitudinal_dependence_annual(Values_input_annual, lat_input, x_limit)
    
elseif average_period_value == 2

    average_period_north = [6 7 8];
    average_period_south = [1 2 12];
    
    Values_input_average_north = annual_average(Values_input.*mask, average_period_north, yr_Num);
    Values_input_annual_north = nanmean(Values_input_average_north,3);
    Values_input_average_south = annual_average(Values_input.*mask, average_period_south, yr_Num);
    Values_input_annual_south = nanmean(Values_input_average_south,3);
    
    display_latitudinal_dependence_season(Values_input_annual_north, Values_input_annual_south, lat_input, x_limit)

elseif average_period_value == 3
    
    average_period_north = [1 2 12];
    average_period_south = [6 7 8];
    
    Values_input_average_north = annual_average(Values_input.*mask, average_period_north, yr_Num);
    Values_input_annual_north = nanmean(Values_input_average_north,3);
    Values_input_average_south = annual_average(Values_input.*mask, average_period_south, yr_Num);
    Values_input_annual_south = nanmean(Values_input_average_south,3);
    
    display_latitudinal_dependence_season(Values_input_annual_north, Values_input_annual_south, lat_input, x_limit)
    
end