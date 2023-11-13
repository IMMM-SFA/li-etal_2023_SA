function output = find_summer_data (dates, data)

    summer = ismember(month(dates),6:8);

    output = data(summer);
  
end