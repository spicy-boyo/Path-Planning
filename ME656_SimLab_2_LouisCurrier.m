%% ME 656 - SimLab 2 - Louis Currier
clc
clear
close all
%% Setup

[goal_region, goal_x,goal_y, i_obs, num_obstacles, obs_x, obs_y, obstacles, start_state] = generate_obstacles(1);
paths = zeros(100,2,60);
pathLengths = zeros(100,1);
kPaths = zeros(100,2);
kEllipses = zeros(100,2,60);
%% Main Loop 
for i = 1:100
    %Path Generation
    [path, pathLength] =  RRT(start_state,goal_region,obstacles);
    paths(1:length(path),:,i) = path; 
    pathLengths(i) = pathLength;
    
    %Kalman Filtering
    [kPath, kEllipse] = kalmanFilter(path,obstacles);
    kPaths(i,:) = [kPath(1,1),kPath(3,3)];
    kEllipses(1:length(path),:,i) = kEllipse;
    
end


%% Plotting

%Shortest Path
minPathPlot(pathLengths,paths,kEllipses)

%Min Uncertainty
minUncertPlot(kPaths,paths,kEllipses)

%Max Uncertainty
maxUncertPlot(kPaths,paths,kEllipses)