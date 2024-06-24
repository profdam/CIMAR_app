
function transportValue = calculateTransportValue(omega)
    if omega < 0.15
        transportValue = 0.023 * omega;  % Calm periods
    else
        transportValue = 0.00225 + 0.008 * omega;  % Storm periods
    end
end
