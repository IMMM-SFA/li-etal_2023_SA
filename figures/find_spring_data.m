function output = find_spring_data (dates, data)

    spring = ismember(month(dates),3:5);

    output = data(spring);
  
end