function row = GenerateInstForOneRover(AddInstructions, type)

%Generate the initial generation of random moves.

%{

%setting probability of 1 to 90percent and that of 2 and 3 to 5percent each
random_array = ones(100,1);
for i = 90:95
    random_array(i) = 2;
end

for i = 95:100
    random_array(i) = 3;
end


%probability section ended

%}

a = ones(AddInstructions, 1);
for i = 1:AddInstructions
    probability = 1-type*0.1;
    %number = round(rand(1)*99) + 1; %Generate a random number between 1 and 100
    %a(i) = random_array(number); 
    a(i) = randsample([1 2 3], 1, true, [probability (1-probability)/2 (1-probability)/2]);    
    
end

row = a;

