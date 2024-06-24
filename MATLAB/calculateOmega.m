
% Function to calculate omega
function [OMEGA_a, OMEGA_s, OMEGA_w] = calculateOmega(Hb_a, V_a, Hb_s, V_s, Hb_w, V_w)
    OMEGA_a = calculateOmegaForSeason(Hb_a, V_a);
    OMEGA_s = calculateOmegaForSeason(Hb_s, V_s);
    OMEGA_w = calculateOmegaForSeason(Hb_w, V_w);
end
