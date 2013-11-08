function  untouched = survey(map,initialstate,instructions,rover, varagrin)
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

numberofrovers = 1; %modify this on final

if nargin==4
   slow=varargin{1};
else
   slow=0;
end

r=initialstate(rover,1);
c=initialstate(rover,2);
d=initialstate(rover,3);

[numberoftimesteps] = size(instructions);

figure(gcf); clf;
set(gcf,'DefaultPatchCDataMapping','direct','Position',[10 10 600 600], ...
   'Menu','none','Name','Mars','DoubleBuffer','on','Color','white');

% set the background image
try
   load ground;
   image(ground)
catch
   %warning('Background not found.');   
end
set(gca,'units','normalized','position',[0 0 1 1],'visible','off');

% create a new axes to sit on top of the image
newax=axes('clim',[0.5 6.5], 'units','normalized','position', ...
   [0 0 1 1],'visible','off','xlim',[0 50],'ylim',[0 50]);
axes(newax)
axis ij

% set some basic color.
a = prism(6); b = a(4,:); a(4,:) = a(6,:); a(6,:) = b; colormap(a);

% set mower shape
A = [-0.5 0 0.5 -0.5; -0.5 0.5 -0.5 -0.5]'; % mower shape

% draw the invalid regions
blacksquare = patch('EraseMode','none','xdata',[],'ydata',[]);
[is,js]=find(map==-1);
for i=1:length(is)
   qx = [js(i) js(i) js(i)-1 js(i)-1]; 
   qy = [is(i)-1 is(i) is(i) is(i)-1];
   set(blacksquare, 'Xdata', qx, 'Ydata', qy);
   drawnow
end


for rover = 1:numberofrovers
   % Create the rover patches at the starting positions
   dp = pi*(d-1)/2;
   PA = A*[cos(dp) sin(dp); sin(dp) -cos(dp)];
   qx = PA(:,1) + c-0.5; qy = PA(:,2) + r-0.5;
   arrow(rover) = patch(qx,qy,rover,'EraseMode','none');
   
   % mark the initial location as visited
   map(r,c) = 0;
   thumb(r,c)=rover+1;
end
drawnow

% Algorithm debugging information
illegalregion=0;
outofarea=0;


% Iterate over each timestep
for timestep = 1:numberoftimesteps
   % Iterate over each rover
   
      
      action = instructions(timestep,rover);
      
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
         
         % move the picture of the mower
         dp = pi*(d-1)/2;
         PA = A*[cos(dp) sin(dp); sin(dp) -cos(dp)];
         qx = PA(:,1) + col-0.5; qy = PA(:,2) + row-0.5;
         set(arrow(rover), 'Xdata', qx, 'Ydata', qy);
         drawnow;
      end
   
   if slow
      pause(0.1)
   end
   
end

% Algorithm debugging information
if outofarea
   warning(['The rovers tried to move out of the area ' num2str(outofarea) ' times.']);
end
if illegalregion
   warning(['The rovers tried to move into an illegal region ' num2str(illegalregion) ' times.']);
end

% Find out how many zones were missed
untouched = sum(sum(map==1));

% Lock down the current image
%im=getframe(gcf);
%clf;
%image(im.cdata);
%[m,n]=size(im.cdata);
%set(gca,'position',[0 0 1 1])
