function angleDegrees = calculateCoastlineOrientationLinear(latitudes, longitudes)
    % Convert latitude and longitude to Cartesian coordinates
    R = 6371000; % Radius of Earth in meters
    x = R * cosd(latitudes) .* cosd(longitudes);
    y = R * cosd(latitudes) .* sind(longitudes);
    
    % Perform linear regression on the coordinates
    p = polyfit(x, y, 1); % Linear fit y = p(1)*x + p(2)
    
    % Calculate angle of the fitted line relative to the x-axis
    angleRadians = atan(p(1));
    angleDegrees = mod(rad2deg(angleRadians), 360); % Convert radians to degrees and normalize to [0, 360)
end
