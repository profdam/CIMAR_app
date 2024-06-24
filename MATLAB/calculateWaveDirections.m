
% Function to calculate wave directions relative to north
function [waveDirRelToNorth_a, waveDirRelToNorth_s, waveDirRelToNorth_w] = calculateWaveDirections(normalToCoastline, dm_a, dm_s, dm_w)
    waveDirRelToNorth_a = adjustWaveDirection(normalToCoastline, dm_a);
    waveDirRelToNorth_s = adjustWaveDirection(normalToCoastline, dm_s);
    waveDirRelToNorth_w = adjustWaveDirection(normalToCoastline, dm_w);
end
