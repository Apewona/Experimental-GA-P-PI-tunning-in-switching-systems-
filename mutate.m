function genotyp_mut = mutate(genotyp, prawdopodobienstwo_mutacji)
% The function randomizes the indexes of the elements that are to be mutated,
% and then mutates by adding a random value from the range
% from -1 to 1. You can call this function

    % Creating a copy of the genotype
    genotyp_mut = genotyp;

    % Randomizing the indexes of elements to be mutated
    indeksy_mut = rand(size(genotyp)) < prawdopodobienstwo_mutacji;
    
    % Making mutations in selected elements
    genotyp_mut(indeksy_mut) = genotyp_mut(indeksy_mut)*0.9;
end
