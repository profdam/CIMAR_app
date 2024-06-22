
% Example: Multiple points along a complex coastline
latitudes = [40.7128, 41.8781, 37.7749, 34.0522, 32.7157]; % Example latitudes
longitudes = [-74.0060, -87.6298, -122.4194, -118.2437, -117.1611]; % Example longitudes

% Define the number of neighbours on each side to consider
windowSize = 2; % Number of neighbours on each side

% Calculate coastline orientation for each location using a moving window approach
coastlineOrientation = calculateLocalCoastlineOrientation(latitudes, longitudes, windowSize);

% Display results
disp('Coastline orientation angles:');
disp(coastlineOrientation);
