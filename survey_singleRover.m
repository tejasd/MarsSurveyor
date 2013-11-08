function  untouched = survey_singleRover(map,initialstate,instructions,varargin, rover)
%SURVEY(map,initialstate,instructions)
%SURVEY(map,initialstate,instructions,slow)
%
% MAP 50 x 50 matrix of 1 and -1:
%       1 unsurveyed region
%      -1 impassable region
% 
% INITIALSTATE 5 x 3 matrix
%       5 surveyors
%       for each surveyor
%         row, column, direction
%
%   row and column give the surveyor's position on the map 
%   direction gives the surveyor's starting direction
%       1 north
%       2 east
%       3 south
%       4 west
%
% INSTRUCTIONS 500 x 5 matrix of instructions
%     500 timesteps
%       5 surveyors
%   Each value can be one of the following
%       1 move forward
%       2 rotate left
%       3 rotate right
%       4 wait
%
% SLOW 
%    If the fourth argument is specified as 1, then the plotting is
%    delayed so that it is easier to visualize the results.  Default
%    value is 0, undelayed visualization.
%
% UNTOUCHED
%    It returns the number of unsurveyed squares.

if nargin==4
   slow=varargin{1};
else
   slow=0;
end

r=initialstate(rover,1);
c=initialstate(rover,2);
d=initialstate(rover,3);

numberoftimesteps = size(instructions);



      
   % mark the initial location as visited
   map(r,c) = 0;
   thumb(r,c)=rover+1;


% Algorithm debugging information
illegalregion=0;
outofarea=0;


% Iterate over each timestep
for timestep = 1:numberoftimesteps
   % Iterate over each rover
   
      
      action = instructions(timestep);
      
      row=r;
      col=c;
      
      % update state
      switch action
      case 1 % move forward
         switch d
         case 1
            if row~=1, row=row-1;
            else outofarea=outofarea+1;
            end
         case 2
            if col~=50, col=col+1;
            else outofarea=outofarea+1;
            end
         case 3
            if row~=50, row=row+1;
            else outofarea=outofarea+1;
            end
         case 4
            if col~=1, col=col-1;
            else outofarea=outofarea+1;
            end
         otherwise 
            error('Direction can only be 1-4.');
         end
         
      case 2 % turn left
         d = d-1;
         if d == 0, d=4; end;
         
      case 3 % turn right
         d = d+1;
         if d == 5,  d=1; end;
         
      case 4 % wait
         
      otherwise
         error('Invalid instruction.');
         
      end
      
      % If it is a vaild region, update the state.
      if map(row,col) == -1
         illegalregion=illegalregion+1;
      else
         % update this rover's state
         r=row;
         c=col;
         
         % mark this square as visited
         map(row,col) = 0;
         thumb(r,c)=rover+1;
         
        
      end
   
   if slow
      pause(0.1)
   end

end

% Algorithm debugging information
%if outofarea
 %  warning(['The rovers tried to move out of the area ' num2str(outofarea) ' times.']);
%end
%if illegalregion
 %  warning(['The rovers tried to move into an illegal region ' num2str(illegalregion) ' times.']);
%end

% Find out how many zones were missed
untouched = sum(sum(map==1));


