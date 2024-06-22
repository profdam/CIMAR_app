
% Function to calculate transport
function [TRANSPORT_a, TRANSPORT_s, TRANSPORT_w] = calculateTransport(OMEGA_a, OMEGA_s, OMEGA_w)
    TRANSPORT_a = calculateTransportForSeason(OMEGA_a);
    TRANSPORT_s = calculateTransportForSeason(OMEGA_s);
    TRANSPORT_w = calculateTransportForSeason(OMEGA_w);
end
