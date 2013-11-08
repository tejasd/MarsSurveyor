function area=generateObstacle(area,x,y)
%=========================================================================
% generateObstacle
% Generates a single grid-cell with an obstacle and updates area. 
% The idea is to locate an obstacle at a random place. If place already has
% an obstacle, then the obstacle moves one cell in a randomized direction,
% provided that it's not the walls or the corridors we leave next to the
% walls. This is done in a recursion until we find a location.
%
% Input
% area: a 2d grid that represents a discretized area. 
%
% Output
% area: an updated 2d grid with the obstacle located at one of the cells
%=========================================================================
global ObstacleCost

[columns,rows]=size(area);
if nargin<3 % 3 arguments are when we use recursion
    x=random('unid',columns-4)+2;
    y=random('unid',rows-4)+2;
end

if area(x,y)~=ObstacleCost %this happens if the area cell is not already taken
    area(x,y)=ObstacleCost;
else
    direction=random('unid',4);
    switch direction
        case 1 %up
            if y>3
                y=y-1;
            else 
                y=y+1;
            end
            area=generateObstacle(area,x,y);            
        case 2 %down
            if y<rows-2
                y=y+1;
            else
                y=y-1;
            end
            area=generateObstacle(area,x,y);            
        case 3 %left
            if x>3
                x=x-1;
            else
                x=x+1;
            end
            area=generateObstacle(area,x,y);            
        case 4 %right
            if x<columns-2
                x=x+1;
            else
                x=x-1;
            end            
            area=generateObstacle(area,x,y);            
    end
end