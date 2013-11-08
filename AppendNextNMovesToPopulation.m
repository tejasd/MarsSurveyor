function Population = AppendNextNMoves(InitialSize, ToAdd, noOfRovers, PopulationSize, CurrPopulation)

Population = ones(InitialSize+ToAdd, noOfRovers, PopulationSize);

Population(1:InitialSize,:, :) = CurrPopulation;

PopulationType = 1;

for i = 1:PopulationSize
    Population(InitialSize+1:InitialSize+ToAdd,:,i) = GenerateInstrSet(noOfRovers, ToAdd, PopulationType);
    if (i > 0.2*PopulationType*PopulationSize)
        PopulationType = PopulationType + 1;
    end
      
         
end


