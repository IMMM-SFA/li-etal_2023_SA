function plot_map_daily(values_input, mask_input, value_limit)

values_input_average = nanmean(values_input.*mask_input, 3);
display_map(values_input_average, value_limit)

end