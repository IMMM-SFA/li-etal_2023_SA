function [data_annual_average] = annual_average(data_monthly, average_period, yr_Num)
% average_period:
% summer: average_period = [6 7 8];
% winter: average_period = [1 2 12];
% whole year: average_period = 1:12;


Index_day = 0;
for iYrInd = 1:yr_Num
    
    data_selected = data_monthly(:, :, Index_day+1:Index_day+12);
    
    data_annual_average(:, :, iYrInd) = nanmean(data_selected(:, :, average_period),3);
    
    Index_day = Index_day + 12;
    
end