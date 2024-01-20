function populacja_potomkow = crossing(populacja,N)
% CROSSING - A function that crosses individuals
%
% Entry:
% population - population matrix of individuals
% selection - vector of indexes of selected individuals
%
% Exit:
% descendant_population - descendant population matrix
%

% Initialize the descendant population matrix
populacja_potomkow = zeros(size(populacja));

% Crossbreeding of individuals
for i = 1:2:N
    osobnik1 = populacja(i,:);
    osobnik2 = populacja(i+1,:);
    
    % Drawing of the place of division
    miejsce_podzialu = randi([1, length(osobnik1) - 1]);
    
    % Crossbreeding of individuals
    potomek1 = [osobnik1(1:miejsce_podzialu), osobnik2(miejsce_podzialu+1:end)];
    potomek2 = [osobnik2(1:miejsce_podzialu), osobnik1(miejsce_podzialu+1:end)];
    
    % Adding descendants to the descendant population matrix
    populacja_potomkow(i,:) = potomek1;
    populacja_potomkow(i+1,:) = potomek2;
end

end