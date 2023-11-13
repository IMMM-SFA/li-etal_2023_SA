function output = find_autumn_data (dates, data)

    autumn = ismember(month(dates),9:11);

    output = data(autumn);
  
end