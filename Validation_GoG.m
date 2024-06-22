% This is an adaptation of Taylor and Target diagram toolbox available at
% https://de.mathworks.com/matlabcentral/fileexchange/52943-peterrochford-skillmetricstoolbox
% These functions should be added to your MATLAB path

% Taylor diagram with modified axes and data point colours.
% All functions in the Skill Metrics Toolbox are designed to only work with
% one-dimensional arrays, e.g. time series of observations at a selected
% location. The one-dimensional data are read in as data structures via a
% MAT file. The latter are stored in data structures in the format:
% ref.data, pred1.data, pred2.data, and pred3.data. The plot is written to a
% file in Portable Network Graphics (PNG) format.
% Details on the contents of the data structures (once loaded)
% can be obtained by simply entering the data structure variable name at 
% the command prompt, e.g. 
% >> ref
% ref = 
%          data: [57x1 double]
%          date: {57x1 cell}
%         depth: [57x1 double]
%      latitude: [57x1 double]
%     longitude: [57x1 double]
%       station: [57x1 double]
%          time: {57x1 cell}
%         units: 'cell/L'
%          jday: [57x1 double]
% Fuctions Author: Peter A. Rochford
%         Symplectic, LLC
%         www.thesymplectic.com
%         prochford@thesymplectic.com

% Close any previously open graphics windows and clear the workspace
clc; clear; close all;

%% Set the figure properties (optional)
set(gcf,'units','inches','position',[0,10.0,14.0,10.0]);
set(gcf,'DefaultLineLineWidth', 1.5); % Line width for plots
set(gcf,'DefaultAxesFontSize',18);    % Font size of axes text

%% Load observation, unstructured, and structured data

% Load CMEMS data from a .mat file
load('...\Validation_all_data.mat', 'hs_cmems', 'hs_struct', 'hs_unstruct')

%% Assign dataset to ref.data, pred1.data, pred2.data...
pred1.data = hs_struct;
pred2.data = hs_unstruct;
ref.data = hs_cmems;
 
%% Calculate statistics for Taylor diagram
% The first array element corresponds to the reference series,
% while the second is for the predicted series.
taylor_stats1 = taylor_statistics(pred1, ref, 'data');
taylor_stats2 = taylor_statistics(pred2, ref, 'data');

%% Store statistics in arrays
sdev = [taylor_stats1.sdev(1); taylor_stats1.sdev(2); taylor_stats2.sdev(2)];
crmsd = [taylor_stats1.crmsd(1); taylor_stats1.crmsd(2); taylor_stats2.crmsd(2)];
ccoef = [taylor_stats1.ccoef(1); taylor_stats1.ccoef(2); taylor_stats2.ccoef(2)];

%% Specify labels for points in a cell array
% Note that a label needs to be specified for the reference even
% though it is not used.
label = {'Non-Dimensional Observation', 'Structured', 'Unstructured'};

%% Produce the Taylor diagram
%
% Label the points and change the axis options for SDEV, CRMSD, and CCOEF.
% Increase the upper limit for the SDEV axis and rotate the CRMSD contour 
% labels (counter-clockwise from x-axis). Exchange colour and line style
% choices for SDEV, CRMSD, and CCOEF variables to show effect. Increase
% the line width of all lines.
%
% For an exhaustive list of options to customize your diagram, please 
% call the function without arguments:
%   >> taylor_diagram
[hp, ht, axl] = taylor_diagram(sdev, crmsd, ccoef, ...
    'markerLabel', label, 'markerLegend', 'on', 'markerLabelColor', 'k', 'markerColor', 'k', ...
    'rmslabelformat', '%.2f', 'tickRMS', 0.1:0.02:0.2, 'tickRMSangle', -25, 'showlabelsRMS', 'on', ...
    'colRMS', 'r', 'styleRMS', '-', 'widthRMS', 2.0, 'titleRMS', 'on', 'titleRMSDangle', 120, ...
    'tickSTD', 0.1:0.02:0.19, 'limSTD', 0.2, ...
    'colSTD', 'b', 'styleSTD', '-', 'widthSTD', 2.0, 'colOBS', 'k', 'markerObs', 'o', 'widthObs', 2, ...
    'styleOBS', '-', 'colCOR', 'k', 'styleCOR', '--', 'widthCOR', 2.0, ...
    'colormap', 'off', 'titleOBS', 'Observation', 'markerSize', 10, 'alpha', 0.0);

            %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %                                                   %
            % ATTENTION: Target diagram starts here             %
            %                                                   %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                        % Fuctions Author: Peter A. Rochford
                        %         Symplectic, LLC
                        %         www.thesymplectic.com
                        %         prochford@thesymplectic.com

%% All datasets are defined the same way as for the Taylor diagram above

%% Calculate statistics for Target diagram
% The first array element corresponds to the reference series,
% while the second is for the predicted series.
target_stats1 = target_statistics(pred1, ref, 'data');
target_stats2 = target_statistics(pred2, ref, 'data');
 
%% Store statistics in arrays
bias = [target_stats1.bias; target_stats2.bias];
rmsd = [target_stats1.rmsd; target_stats2.rmsd];
crmsd = [target_stats1.crmsd; target_stats2.crmsd];

%% Specify labels for points in a cell array
label = {'Structured', 'Unstructured'};

%% Produce the Target diagram
%
% For an exhaustive list of options to customize your diagram, please 
% call the function without arguments:
%   >> target_diagram
[hp, ht, axl] = target_diagram(bias, crmsd, rmsd, ...
    'markerLabel', label, 'markerLabelColor', 'r', 'markerColor', 'b', ...
    'markerLegend', 'on', ...
    'ticks', -0.01:0.0:0.40, 'limitAxis', 0.50, ...
    'circles', [0.08 0.1 0.2 0.3 0.4 0.50], 'circleLineSpec', '-r', ...
    'circleLineWidth', 2, 'markerSize', 8, 'alpha', 0.0);
