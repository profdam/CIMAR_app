% Function to calculate normal to coastline
function normalToCoastline = calculateNormalToCoastline(coastlineDirection)
    normalToCoastline = zeros(1, 45);
    for i = 1:45
        if i <= 3 || (i >= 5 && i <= 8) || (i >= 9 && i <= 12) || (i >= 18 && i <= 23) || (i >= 35 && i <= 38)
            normalToCoastline(i) = coastlineDirection(i) - 90;
        elseif i == 4 || i == 24 || i > 38
            normalToCoastline(i) = (90 - coastlineDirection(i)) + 90;
        elseif i >= 13 && i <= 17
            normalToCoastline(i) = (90 - coastlineDirection(i)) + 90;
        end
    end
end
