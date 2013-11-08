%Implements 3 point crossover

function child = ThreePointCrossover(Parent1, Parent2, i, noOfMovesIncrement)
[rows cols] = size(Parent1);
child = Parent1;


number1 = randi([i-noOfMovesIncrement+1 i]); %Generate a random number between 1 and NoOfRows(Instructions)
number2 = randi([i-number1+1 i]);
for i = number1:number2
    child(i, :) = Parent2(i, :); 
end
    