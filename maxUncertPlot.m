function maxUncertPlot(kPaths,paths,kEllipses)
generate_obstacles(3)

[~,ind] = max(sum(kPaths'));
maxPath = paths(:,:,ind);
maxEllipse = kEllipses(:,:,ind);

[row,~] = find(maxPath,1,"last");
maxPath = maxPath(1:row,:);
maxEllipse = maxEllipse(1:row,:);

plot(maxPath(:,1),maxPath(:,2),"Color","b","LineWidth",1);
for ii = 1:length(maxPath)
    ellipse(maxEllipse(ii,1),maxEllipse(ii,2),0,maxPath(ii,1),maxPath(ii,2),'r');
end