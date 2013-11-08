function Instr_Set = GenerateInstrSet(n,noOfMoves, PopulationType)
%Generate instructions for n rovers

a = ones(noOfMoves, n);

a = GenerateInstForOneRover(noOfMoves, PopulationType);

for i = 2:n
    a(:, i) = GenerateInstForOneRover(noOfMoves, PopulationType);
end

Instr_Set = a;