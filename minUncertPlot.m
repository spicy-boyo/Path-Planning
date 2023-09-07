function minUncertPlot(kPaths,paths,kEllipses)
generate_obstacles(2)

[~,ind] = min(sum(kPaths'));
minPath = paths(:,:,ind);
minEllipse = kEllipses(:,:,ind);

[row,~] = find(minPath,1,"last");
minPath = minPath(1:row,:);
minEllipse = minEllipse(1:row,:);

plot(minPath(:,1),minPath(:,2),"Color","b","LineWidth",1);
for ii = 1:length(minPath)
    ellipse(minEllipse(ii,1),minEllipse(ii,2),0,minPath(ii,1),minPath(ii,2),'r');
end