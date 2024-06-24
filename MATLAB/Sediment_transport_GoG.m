clc; clear; close all;

% Load selected ensemble wave data
load('...\ensemble.mat');
addpath('...\needed_fucntions\'); %addpath to needed functions

% Load uniform coastline direction
load('coastline_direction_uniform.mat', 'True_coastline_direction');
coastlineDirection = True_coastline_direction;

% Estimate normal to coastline
normalToCoastline = calculateNormalToCoastline(coastlineDirection);

% Calculate directions relative to the north for wave direction (annual average)
[waveDirRelToNorth_a, waveDirRelToNorth_s, waveDirRelToNorth_w] = calculateWaveDirections(normalToCoastline, dm_a, dm_s, dm_w);

% Calculate longshore sediment transport (annual average)
[Thetab_a, Hb_a, hb_a, R_a, S_a, V_a] = calculateSedimentTransport(tm_a, hs_a, waveDirRelToNorth_a);
[Thetab_s, Hb_s, hb_s, R_s, S_s, V_s] = calculateSedimentTransport(tm_s, hs_s, waveDirRelToNorth_s);
[Thetab_w, Hb_w, hb_w, R_w, S_w, V_w] = calculateSedimentTransport(tm_w, hs_w, waveDirRelToNorth_w);

% Calculate omega and transport
[OMEGA_a, OMEGA_s, OMEGA_w] = calculateOmega(Hb_a, V_a, Hb_s, V_s, Hb_w, V_w);
[TRANSPORT_a, TRANSPORT_s, TRANSPORT_w] = calculateTransport(OMEGA_a, OMEGA_s, OMEGA_w);

% Convert transport to per year
conversionFactor = 1 / 31536000;
Q_hist_a = TRANSPORT_a / conversionFactor;
Q_hist_s = TRANSPORT_s / conversionFactor;
Q_hist_w = TRANSPORT_w / conversionFactor;

% Longshore Velocity
V_hist_a = V_a;
V_hist_s = V_s;
V_hist_w = V_w;

clearvars -except Q_hist_a Q_hist_s Q_hist_w lon_f lat_f coastlineDirection V_hist_a V_hist_s V_hist_w;

