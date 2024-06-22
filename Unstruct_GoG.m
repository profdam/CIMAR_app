% This code is adapted for the Gulf of Guinea (GoG) from the OceanMesh2D MATLAB utilities 
% for generating unstructured grids

% Clear and prepare environment
clearvars; clc; clear;

% Make sure the needed functions are added to MATLAB paths:
%   1. OceanMesh2D available at https://github.com/CHLNDDEV/OceanMesh2D/blob/Projection/README.md
%   2. m_map toolbox available at https://www.eoas.ubc.ca/~rich/map.html
addpath(genpath('.../utilities/'))
addpath(genpath('.../datasets/'))
addpath(genpath('.../m_map/'))

%% STEP 1: Set mesh extents and set parameters for mesh.
bbox = [-8.5 15.5;          % [minimum_longitude maximum_longitude;
        -2.5 15.5];         % minimum_latitude maximum_latitude];

min_el    = 1e3;            % Minimum resolution in meters.
max_el    = 100e3;          % Maximum resolution in meters. 
max_el_ns = 5e3;            % Maximum resolution nearshore in meters.
dt        = 2;              % Encourage mesh to be stable at a 2 s timestep.
grade     = 0.35;           % Mesh grade in decimal percent.
R         = 3;              % Number of elements to resolve feature width.

%% STEP 2: Specify geographical datasets and process the geographical data 
% to be used later with other OceanMesh classes.
% coastline: The Global Self-consistent, Hierarchical, High-resolution Geography Database
% available at https://www.soest.hawaii.edu/pwessel/gshhg/
% dem: The General Bathymetric Chart of the Oceans (GEBCO) available at https://download.gebco.net/
coastline = '...\gshhg-shp-2.3.7\GSHHS_shp\f/GSHHS_f_L1';
dem       = '...\GEBCO.nc';

% Create geodata object with specified parameters.
gdat = geodata('shp',coastline, ...
               'dem',dem, ...
               'bbox',bbox, ...
               'h0',min_el); 

%% STEP 3: Create an edge function class.
fh = edgefx('geodata',gdat, ...
            'fs',R, 'max_el_ns',max_el_ns, ...
            'max_el',max_el, 'dt',dt, 'g',grade);

%% STEP 4: Pass your edgefx class object along with some meshing options and
% build the mesh.
mshopts = meshgen('ef',fh, 'bou',gdat, 'proj','utm', 'plot_on',1);
mshopts = mshopts.build; 

%% STEP 5: Plot it and write a triangulation fort.14 compliant file to disk.
% Get out the msh class and put on bathy and nodestrings.
m = mshopts.grd;
m = interp(m,gdat,'mindepth',1); % Interpolate bathy to the mesh with minimum depth of 1 m.
m = make_bc(m,'auto',gdat,'depth',5); % Make the nodestring boundary conditions 
                                      % with min depth of 5 m on open boundary.
plot(m,'bd'); plot(m,'blog'); % Plot triangulation, and bathy on log scale.

%% Plot unstructured grids on projected maps

% Read the coordinates and nodes of unstructured grids.
T = m.t; % This must be Nx3 dimension corresponding to each node of the triangles.
lon = m.p(:,1); % Longitude.
lat = m.p(:,2); % Latitude.

% Plot the mesh with coastline data.
figure
m_proj('Mercator','longitude',[-8.5 15.5],'latitude',[-2.5 15.5]);
m_gshhs_h('patch',[0.9 0.9 0.9],'linewidth',2,'edgecolor','c');
m_usercoast('coast_name','color','b','linewidth',3);
hold on
m_triplot(lon, lat, T)
m_grid('box','fancy','tickdir','in','xtick',(-15:5:20),'ytick',(-15:5:20),'fontsize',12,'fontweight','bold');
m_northarrow(-5,2,2,'type',4,'linewi',2.0);

% Annotate the map with city names and countries.
m_text(2.3,6.7,'Cotonou','Rotation', 90,'color','k','fontw','bold') 
m_text(1.83,10,'Benin','FontSize',10,'Rotation', 0,'color','k','fontw','bold') 
m_text(3.37,6.7,'Lagos','Rotation', 90,'color','k','fontw','bold') 
m_text(7,10,'Nigeria','FontSize',10,'Rotation', 0,'color','k','fontw','bold') 
m_text(1.25,6.5,'Lome','Rotation', 90,'color','k','fontw','bold') 
m_text(0.5,9,'Togo','FontSize',10,'Rotation', 0,'color','k','fontw','bold') 
m_text(-0.25,5.7,'Accra','Rotation', 95,'color','k','fontw','bold') 
m_text(-2,10,'Ghana','FontSize',10,'Rotation', 0,'color','k','fontw','bold') 
m_text(-7,9,'C\^ote d''Ivoire','interpreter','latex','FontSize',13,'Rotation', 0,'color','k','fontw','bold') 
m_text(-3.1,5.2,'Abidjan','Rotation',135,'color','k','fontw','bold')
m_text(9.9,4,'Douala','Rotation',-60,'color','k','fontw','bold')
m_text(10,5,'Cameroon','FontSize',10,'Rotation', 0,'color','k','fontw','bold') 
m_text(10,0,'Gabon','FontSize',10,'Rotation', 0,'color','k','fontw','bold') 
m_text(9.4,0.5,'Libreville','Rotation', 0,'color','k','fontw','bold') 

% Add labels and title to the map.
title('Unstructured Grids in the GoG','FontSize',12,'FontName','Times News Roman','FontWeight','Bold');
xlabel('Longitude','FontSize',12,'FontName','Times News Roman','FontWeight','Bold');
ylabel('Latitude','FontSize',12,'FontName','Times News Roman','FontWeight','Bold');
axis equal tight
