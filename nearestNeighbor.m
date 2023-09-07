function [neighbor] = nearestNeighbor(new_node,x)

diff1 = new_node(1)-x(:,1); %Takes difference between node and all values in x & y
diff2 = new_node(2)-x(:,2);
hyp = sqrt(diff1.^2+diff2.^2); %Finds the hypotenuse generated from each new vector
[~ ,neighbor_ind] = min(hyp); %Finds the index for min distance 
neighbor = x(neighbor_ind,:); %Assigns node as neighbor

end