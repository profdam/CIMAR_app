
function OMEGA = calculateOmegaForSeason(Hb, V)
    OMEGA = [];
    for j = 1:27
        omega = Hb(j, :).^2 .* V(j, :);
        OMEGA = [OMEGA; omega];
    end
end

