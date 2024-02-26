function plot_latitudinal_dependence_daily(values_input, mask_input, lat_input, x_limit)

values_input_average = nanmean(values_input.*mask_input, 3);
display_latitudinal_dependence(values_input_average, lat_input, x_limit)

end