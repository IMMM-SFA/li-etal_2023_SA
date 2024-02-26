function qs = qsat(press, temp)

    % Calculate satuated specific humidity

    % temp (K)
    % press (pa)

    Saturation_vapor_pressure = 611 .* exp(17.27.*(temp-273.15)./(temp-273.15+237.3));
    qs = 0.622 .* Saturation_vapor_pressure ./ press;
    
end

