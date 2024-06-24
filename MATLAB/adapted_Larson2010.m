function [Thetab, Hb, hb, R, S, V] = Larson2010(T, H, theta)
% Larson2010.m - Calculate wave parameters based on Larson (2010) model
% 
% Inputs:
% T     - Wave period (s)
% H     - Wave height (m)
% theta - Wave incidence angle (degrees)
%
% Outputs:
% Thetab - Wave incidence angle at breaking (degrees)
% Hb     - Wave height at breaking (m)
% hb     - Water depth at breaking (m)
% R      - Runup (m)
% S      - Setup (m)
% V      - Alongshore current in the surf (m/s)

% Parameters
runup = 3; % Type of runup calculation method
m = 0.08; % Beach slope
g = 9.81; % Gravity (m/s^2)
gamma = 0.78; % Breaking wave parameter

% Filter invalid wave incidence angles
theta0 = theta;
theta0(cosd(theta0) < 0) = NaN;

% Calculate deepwater wave parameters
C = 1.56 * T; % Wave speed (m/s)
L = 1.56 * T^2; % Wavelength (m)
Cg = C / 2; % Group speed (m/s)

% Calculate non-dimensional parameters
alpha = (C / sqrt(g * H))^4 * (C / Cg) * gamma^2;
lambda_a = (cosd(theta0) / alpha).^(2/5);
epsi = lambda_a .* sind(theta0).^2;
epsi = min(max(epsi, 0), 0.5); % Limit epsilon values

% Polynomial approximation for delta
delta = 1 + 0.1649 * epsi + 0.5948 * epsi.^2 - 1.6787 * epsi.^3 + 2.8573 * epsi.^4;
lambda = delta .* lambda_a;

% Compute breaking parameters
hb = lambda .* C.^2 / g; % Water depth at breaking (m)
Hb = gamma * hb; % Wave height at breaking (m)
Thetab = asind(sind(theta) .* sqrt(lambda)); % Wave incidence angle at breaking (degrees)

% Replace NaN values with zeros
hb(isnan(hb)) = 0;
Hb(isnan(Hb)) = 0;

% Calculate alongshore current in the surf (m/s)
kv = 2.9; % Kaczmarek constant
V = 0.25 * kv * sqrt(gamma * g * Hb) .* sind(2 * Thetab);

% Calculate wave-induced runup (Hanson and Larson, 2008 / Hunt's formula)
Hop = abs(sqrt(cosd(theta0)) .* H); % Corrected wave height for incidence angle
beta = 0.08; % Beach slope

% Calculate runup based on different methods
switch runup
    case 1 % Kolman 1998 method for S, Holman and Sallenger 1985
        % Calculate infragravity swash
        Eps = tan(m) ./ sqrt(H ./ L);
        Rig = H * 0.65 .* tanh(3.38 * Eps);
        
        % Calculate swash due to waves
        if Eps >= 0.275
            Rss = H .* (0.69 * Eps - 0.19);
        else
            Rss = 0;
        end
        
        % Calculate total swash height
        etaosc = sqrt(Rig.^2 + Rss.^2);
        Kosc = 1.37; % Swash parameter
        R = Kosc * etaosc / 2;
        R(isnan(R)) = 0;
        
        % Calculate setup
        Gamma = 0.78; % Default value from Ruessink et al. 2003
        Tide = 0; % Tide height (m)
        S = (3 / 8) * Gamma^2 * (hb + Tide) / (1 + (3 / 8) * Gamma^2)^2;
        
    case 2 % Stockdon et al., 2006 (wide range of conditions)
        Ls = (g * T.^2) / (2 * pi); % Wavelength (m)
        R = 0.5 * 1.37 * (0.756 * m^2 * Ls .* H - 0.165 * m .* H .* sqrt(Ls .* H) + 0.0368).^0.5;
        S = 0.45 * m * sqrt(Ls .* H);
        
    case 3 % Stockdon et al., 2006 (dissipative beaches)
        Ls = (g * T.^2) / (2 * pi); % Wavelength (m)
        R = 0.5 * 1.1 * (Ls .* H .* (0.5625 * m^2 + 0.004)).^0.5;
        S = 0.385 * m * sqrt(Ls .* H);
        
    case 4 % Stockdon et al., 2006
        Ls = (g * T.^2) / (2 * pi); % Wavelength (m)
        R = 0.5 * 1.1 * (Ls .* H .* (0.5625 * m^2 + 0.004)).^0.5;
        S = 0.385 * m * sqrt(Ls .* H);
end

end
