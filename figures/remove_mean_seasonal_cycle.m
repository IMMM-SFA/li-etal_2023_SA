function output = remove_mean_seasonal_cycle (dates, data)

%     % detrend 
% 
%     data_detrend = detrend(data,'linear');
% 
%     data = data_detrend;

    % remove the mean seasonal cycle

%     T=timetable(dates,data);
% 
%     clear T_new T_final
%     T_new = T;
%     T2 = groupsummary(T_new,"dates","monthname","mean");
%     %take out the mean monthly values
%     Month = ["Jan";"Feb";"Mar";"Apr";"May";"Jun";"Jul";"Aug";"Sep";"Oct";"Nov";"Dec"];
%     T21 = table(Month,T2.mean_data);
%     T22 = renamevars(T21,"Var2","seasonalmean");
%     T_new.Month = month(dates,"shortname");
%     T_final = join(T_new,T22,"Key","Month");
%     T_final.anomaly = T_final.data-T_final.seasonalmean;
%     output = T_final.anomaly;

    T=timetable(dates,data);

    clear T_new T_final
    T_new = T;
    T_new.DoY = day(T_new.dates,'dayofyear');
    T_new.HoD = hour(T_new.dates);
    T4 = varfun(@nanmean,T_new,'GroupingVariables',{'DoY'},'OutputFormat','table');
    T_final = join(T_new,T4,"Key",{'DoY'});
    T_final.anomaly = T_final.data-T_final.nanmean_data;
    output = T_final.anomaly;
  
end