%Implement Two Point Crossover
function child = TwoPointCrossover(Parent1, Parent2, i, noOfMovesIncrement)
[rows cols] = size(Parent1);
child = Parent1;


number = round(rand(1)*(rows-1)) + 1 + i-noOfMovesIncrement; %Generate a random number between 1 and NoOfRows(Instructions)
for i = number:rows
    child(i, :) = Parent2(i, :); 
end
    
    
