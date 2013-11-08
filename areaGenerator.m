function area=areaGenerator(columns,rows,obstaclesPercentage)
%=========================================================================
% areaGenerator
% Generates an area of size 'columns' columns and 'rows' rows with
% obstacles that fill 'obstaclesPercentage' of the area. The area is 
% represented by a grid. Every grid cell can either be occupied by an 
% obstacle or not. An obstacle is represented by a "-1", while a
% grid-cell that doesn't have an obstacle is represented by a "1".
% 
% Input
% columns: number of columns to be in the area
% rows: number of rows to be in the area
% obstaclesPercentage: percentage of the area to be covered by obstacles
% Output
% area: a 2d grid that represents a discretized area. 
%=========================================================================
global ObstacleCost
ObstacleCost=-1; %the cost of an obstacle grid. Constant.
area=ones(columns,rows); %generate the whole area
numOfObstacleCells=floor(obstaclesPercentage*(columns-2)*(rows-2)/100);
if numOfObstacleCells>(columns-2)*(rows-2) %This makes sure we don't end up with too many obstacles
    disp('Cannot have too many obstacles. Switching to maximum number of obstacles')
    numOfObstacleCells=(columns-2)*(rows-2);
end
for i=1:numOfObstacleCells
    area=generateObstacle(area);
end
