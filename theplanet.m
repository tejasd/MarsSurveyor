function theplanet(varargin)
% THEPLANET with no input arguments 
%   puts all maps and states in the workspace as two cell arrays
% 
% THEPLANET(n)
%   puts the map and state n in the workspace as two arrays
%


% blank with "random" starts
maps{1}=ones(50,50);
states{1} = [29 46  3;
             1 41  2;
            25 39  1;
            14 38  2;
            35 23  3];

% L-shaped lawn with starts in the corner
map=ones(50,50);
map(1:25,25:50)=-1;
state=[ 1  1  1;
        2  2  2;
        3  3  3;
        1  2  4;
        1  3  1];

maps{2}=map;
states{2}=state;

% the comb
map=ones(50,50);
map(18:50,3:3:50)=-1;
state=[50  1  4;
        1  1  3;
       40  2  3;
       40  20 1;
       10  41 2];

maps{3}=map;
states{3}=state;

% the lake
[x,y]=meshgrid(1:25,1:25);
part=(x.^2+y.^2)>11^2;
part(part==0)=-1;
map=[fliplr(flipud(part)) flipud(part);fliplr(part) part];
state=[ 1  1  1;
        1 50  1;
       50  1  1;
       50 50  1;
       50 25  1];

maps{4}=map;
states{4}=state;


% the +
map=ones(50,50);
map(5:45,24:27)=-1;
map(24:27,5:45)=-1;
state=[ 1  2  3;
        2  1  3;
        2  2  3;
        1  3  3;
        1  4  3];

maps{5}=map;
states{5}=state;


% magical
map=((magic(50)<400)+fliplr(magic(50)<400));
map(map==1)=-1;
map(map==0)=1;
state=[ 1  2  3;
        2  1  3;
        2  2  3;
        1  3  3;
        1  4  3];

maps{6}=map;
states{6}=state;


% the concentric
map=ones(50,50);

map(5:45,5)=-1;
map(5:45,45)=-1;
map(5,5:45)=-1;

map(10:40,10)=-1;
map(10:40,40)=-1;
map(40,10:40)=-1;

map(15:35,15)=-1;
map(15:35,35)=-1;
map(15,15:35)=-1;

state=[ 1  2  3;
        2  1  3;
        2  2  3;
        1  3  3;
        1  4  3];

maps{7}=map;
states{7}=state;

% who put the l in the lu?
[l,u]=lu(magic(50));
map=sign(l);
map(map==0)=1;
state=[ 1  2  3;
        2  1  3;
        2  2  3;
        1  3  3;
        1  4  3];


maps{8}=map;
states{8}=state;

if nargin==0
   assignin('base','states',states);
   assignin('base','maps',maps);
else
   n=varargin{1};
   assignin('base','state',states{n});
   assignin('base','map',maps{n});
end


