% Function to adjust wave direction relative to the normal of the coastline
function adjustedDirection = adjustWaveDirection(normalToCoastline, waveDirection)
    numLocations = size(waveDirection, 1);
    adjustedDirection = zeros(size(waveDirection));
    
    for i = 1:numLocations
        if normalToCoastline(i) < 0
            adjustedDirection(i, :) = abs(normalToCoastline(i)) - waveDirection(i, :);
        else
            adjustedDirection(i, :) = waveDirection(i, :) - normalToCoastline(i);
        end
    end
end
