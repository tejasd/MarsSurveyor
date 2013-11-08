%Actual Script to Execute Genetic Algorithm
function Fitness = RunGAonMap(map, roverState, noOfRovers, PopulationSize, noOfIterations, noOfMovesIncrement)

counter = 1;
%stats = ones(noOfIterations, 2); %column 1 is iteration number, column 2 fitness

Population = GeneratePopulation(PopulationSize, noOfRovers, noOfMovesIncrement);
for k = noOfMovesIncrement:noOfMovesIncrement:500

    %size(Population)
    

    for i = 1:noOfIterations
        %{
        if noOfIterations >= 20
            if i >= 100 && mod(i,100) == 0
                fprintf('Currently at iteration %d and the fitness at this point is %i\n', i, Fitness(1,2));
            end
        end
        %}
        Fitness = ones(PopulationSize, 2); %1 is fitness, 2 is index
        for j = 1:PopulationSize
            Fitness(j, 1) = j;
            Fitness(j,2) = survey_cl(map, roverState, Population(:,:,j), k, noOfRovers);
        end





        %Selection Procedure
        Fitness = sortrows(Fitness, [2]); %If using a different selection approach, just return a matrix population with new population in same format

        %stats(counter, 1) = counter;
        %stats(counter, 2) = Fitness(1, 2);
        %counter = counter + 1;
        %disp(counter);
        %disp(stats(counter, :));
        

        %Crossover Procedure
        for j = 1:floor(PopulationSize/2)
            a = Population(:,:,Fitness(j, 1));
            b = Population(:,:,Fitness(j+1, 1));
            Population(:,:,Fitness((PopulationSize/2) + j),1) = ThreePointCrossover(a ,b ,k , noOfMovesIncrement);
        end 


        %fprintf('Generation %d\n', i);
        %size(Population);

        %Mutation Procedure
        populationMember = randi(PopulationSize-1,1) + 1 ;
        instr = randi(k,1);
        rover = randi(noOfRovers, 1);
        
        %disp(Population(instr, rover, Fitness(populationMember,1)))
        if Population(instr, rover, Fitness(populationMember,1)) == 3
            Population(instr, rover, Fitness(populationMember,1)) = 1;
        else
            Population(instr, rover, Fitness(populationMember,1)) = Population(instr, rover, Fitness(populationMember,1)) + 1;
        end



    end
    
    
    
    for i = 1:PopulationSize
        Population(:,:,i) = Population(:,:,Fitness(1,1));
    end
    Population = AppendNextNMovesToPopulation(k,min(noOfMovesIncrement, 500-noOfMovesIncrement), noOfRovers, PopulationSize, Population);
    
end

filename = 'RoverInstr0.mat';
BestInstruction = Population(:,:,Fitness(1,1));

save(filename, 'BestInstruction');


survey_orig(map, roverState, Population(:,:,Fitness(1,1)), 0);

fprintf('The Winner is %d\n', Fitness(1,2));





   

