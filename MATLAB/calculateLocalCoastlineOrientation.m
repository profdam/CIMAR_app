function angleDegrees = calculateLocalCoastlineOrientation(latitudes, longitudes, windowSize)
    numLocations = length(latitudes);
    angleDegrees = zeros(numLocations, 1);
    
    % Loop through each location
    for i = 1:numLocations
        % Define the range of neighbouring points
        startIdx = max(1, i - windowSize);
        endIdx = min(numLocations, i + windowSize);
        
        % Extract the neighbouring points
        latNeighbours = latitudes(startIdx:endIdx);
        lonNeighbours = longitudes(startIdx:endIdx);
        
        % Perform linear regression on the neighbouring coordinates
        p = polyfit(lonNeighbours, latNeighbours, 1); % Linear fit lat = p(1)*lon + p(2)
        
        % Calculate angle of the fitted line relative to the north (latitude axis)
        angleRadians = atan(p(1));
        angleDegrees(i) = mod(rad2deg(angleRadians), 360); % Convert radians to degrees and normalize to [0, 360)
    end
end

