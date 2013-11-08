%   TESTSOLN.M
%   a simple script for testing and visualizing a contest solution

%   create two cell arrays, maps and states
theplanet
%maps{9}=areaGenerator(50,50,50);
%   test the look-around solution on the second sample
%inst = lookmove(maps{9},states{8});  
%map1 = areaGenerator(50,50,0);
 %inst = SneakyClearSoup8(map1, states{1})
%   visualize and validate the results
%a = survey_cl(maps{2},states{1},inst(:,:,i),0, 500, 2); %i indicates rover number, inst indicates instruction number
for k = 3:8
    fprintf('----------For k = %d--------------\n', k);
    
    tic
    RunGAonMap(maps{k}, states{k}, 5, 200, 100, 100);
    toc
    tic
    RunGAonMap(maps{k}, states{k}, 5, 200, 100, 250);
    toc
       
    fprintf('----------------------------------\n');
end
