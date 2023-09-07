function minPathPlot(pathLengths,paths,kEllipses)

[~,ind] = min(pathLengths); %Grabs the row of the min length
sPath = paths(:,:,ind); %Takes the matrix of the same min length
sEllipse = kEllipses(:,:,ind);

[row,~] = find(sPath,1,"last"); %Code for removing excess zeros
sPath = sPath(1:row,:);
sEllipse = sEllipse(1:row,:);

plot(sPath(:,1),sPath(:,2),"Color","b","LineWidth",1); %Plotting the line
for ii = 1:length(sPath)
    ellipse(sEllipse(ii,1),sEllipse(ii,2),0,sPath(ii,1),sPath(ii,2),'r');
end