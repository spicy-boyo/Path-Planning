function [path, path_length] = RRT(start_state,goal_region,obstacles)

x = start_state;
e = 2;
neighbors = zeros(1,2);

while x(:,1) < goal_region(1)

    new_node = randi([0,100],1,2); %Generate random node within the bounds
    neighbor = nearestNeighbor(new_node,x); %Find nearest neighbor function
    branch_vector = new_node - neighbor; %Subtract points to find the vector between
    branch_mag = norm(branch_vector);
    branch_scaled = e*(branch_vector/(norm(branch_vector))); %Scale the new found vector

    if branch_mag > e %Move the node closer if it's too far away
        new_node = neighbor + branch_scaled; 
    end

    %Collision check
    check1 = collision_check_point(new_node(1),new_node(2),obstacles);
    check2 = collision_check_segment(neighbor(1),neighbor(2),new_node(1),new_node(2),obstacles);

    %Tree extension
    if check1 == 0 && check2 == 0
        x = [x(:,:); new_node]; %adds new node to end of list
        neighbors = [neighbors(:,:); neighbor]; %adds its neighbor alongside it
    end
end


path = x(end,:); %Initialize the path
i = 1; %Counter

while path(i,1) ~= start_state(1) && path(i,2) ~= start_state(2)   %Walk the path back to the start
    if i == 1
        next_node = neighbors(end,:); %Initialize next node
        
    else
    [~,ind] = ismember(next_node,x,"rows");
    next_node = neighbors(ind,:);
    end
    path(i+1,:) = next_node;
    i = i+1;
end

path_length = 0;%initialize the length
for j = 1:size(path)-1
    segment = path(j+1,:)-path(j,:);%vector segment
    path_length = path_length + norm(segment);%summing the segments
end

if path(end,1) ~= 5
    [path, path_length] = RRT(start_state,goal_region,obstacles);
end

path = flip(path);