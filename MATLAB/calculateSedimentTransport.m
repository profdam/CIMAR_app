% Function to calculate sediment transport
function [Thetab_f, Hb_f, hb_f, R_f, S_f, V_f] = calculateSedimentTransport(tm, hs, adjustedDirection)
    numLocations = size(tm, 1);
    numTimeSteps = size(tm, 2);

    % Preallocate output matrices
    Thetab_f = zeros(numTimeSteps, numLocations);
    Hb_f = zeros(numTimeSteps, numLocations);
    hb_f = zeros(numTimeSteps, numLocations);
    R_f = zeros(numTimeSteps, numLocations);
    S_f = zeros(numTimeSteps, numLocations);
    V_f = zeros(numTimeSteps, numLocations);
    
    for j = 1:numTimeSteps
        tm_f = tm(:, j);
        hs_f = hs(:, j);
        dir_f = adjustedDirection(:, j);
        
        % Preallocate temporary arrays for each location
        Thetab = zeros(numLocations, 1);
        Hb = zeros(numLocations, 1);
        hb = zeros(numLocations, 1);
        R = zeros(numLocations, 1);
        S = zeros(numLocations, 1);
        V = zeros(numLocations, 1);
        
        for i = 1:numLocations
            [Thetab(i), Hb(i), hb(i), R(i), S(i), V(i)] = adapted_Larson2010(tm_f(i), hs_f(i), dir_f(i));
        end
        
        Thetab_f(j, :) = Thetab';
        Hb_f(j, :) = Hb';
        hb_f(j, :) = hb';
        R_f(j, :) = R';
        S_f(j, :) = S';
        V_f(j, :) = V';
    end
end
