function [kPath,kEllipses] = kalmanFilter(path,obstacles)

range = 5;%meters
dt = 1;%second

%Setup for all Kalman filter matrices
A = [1 dt 0 0; 0 1 0 0; 0 0 1 dt; 0 0 0 1];
Q = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
Rk = [1 0; 0 1];
kPath =  [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
kEllipses = zeros(length(path),2);

for i = 1:size(path)
    %Sensor x
    sxp = collision_check_segment(path(i,1),path(i,2),(path(i,1)+range),path(i,2),obstacles);
    sxn = collision_check_segment(path(i,1),path(i,2),(path(i,1)-range),path(i,2),obstacles);
    %Sensor y
    syp = collision_check_segment(path(i,1),path(i,2),path(i,1),(path(i,2)+range),obstacles);
    syn = collision_check_segment(path(i,1),path(i,2),path(i,1),(path(i,2)-range),obstacles);

    Hk = [0 1 0 0; 0 0 0 1];
    if sxp == 1 || sxn == 1 %Sensor x
        Hk(1,4) = 1;
        Hk(2,1) = 1;
        Hk(2,4) = 0;
    end
    if syp == 1 || syn == 1 %Sensor y
        Hk(1,4) = 1;
        Hk(2,3) = 1;
        Hk(2,4) = 0;
    end
    
    kPath = ((A*kPath*A' + Q)^-1 +Hk'*Rk^-1*Hk)^-1; %P equation from slides
    
    kPath1 = kPath^(1/2);

    kEllipses(i,1) = kPath1(1,1);
    kEllipses(i,2) = kPath1(3,3);
end
