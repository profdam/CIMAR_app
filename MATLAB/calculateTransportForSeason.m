
function TRANSPORT = calculateTransportForSeason(OMEGA)
    TRANSPORT = [];
    for j = 1:27
        omega = OMEGA(j, :);
        transport = arrayfun(@calculateTransportValue, omega);
        TRANSPORT = [TRANSPORT; transport];
    end
end
