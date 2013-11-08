%Generate Initial population
function Population = GeneratePopulation(sizeOfPopulation, NumberOfRovers,noOfMoves)

Population = zeros(NumberOfRovers, noOfMoves, sizeOfPopulation);

PopulationType = 1;
Population = GenerateInstrSet(NumberOfRovers,noOfMoves, PopulationType);

for i = 2:sizeOfPopulation
    
    Population(:,:,i) = GenerateInstrSet(NumberOfRovers,noOfMoves, PopulationType);
    
    if (i > 0.2*PopulationType*sizeOfPopulation)
        PopulationType = PopulationType + 1;
    end
end
    