function output = find_winter_data (dates, data)

    winter = ismember(month(dates),[1,2,12]);

    output = data(winter);
  
end