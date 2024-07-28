function [P_new] = selection(P, E, p)
    % P = population
    % E = evaluation of each chromosome in the population
    % p = population size

    [~, y] = size(P);
    Y1 = zeros(p, y); % Initialize the new population array

    % Elite selection: Select top 'e' chromosomes based on evaluation
    e = 3; % Number of elite chromosomes to be selected
    for i = 1:e
        [~, c1] = find(E == min(E)); % Find the index of the best chromosome
        Y1(i, :) = P(min(c1), :); % Add the best chromosome to the new population
        P(min(c1), :) = []; % Remove the selected chromosome from the old population
        E(:, min(c1)) = []; % Remove its evaluation value
    end

    D = E / sum(E); % Normalize evaluation values
    E1 = cumsum(D); % Cumulative sum for roulette wheel selection
    N = rand(1); % Random number for selection

    d1 = 1;
    d2 = e;
    while d2 <= p - e
        if N <= E1(d1)
            Y1(d2 + 1, :) = P(d1, :); % Select chromosome based on roulette wheel selection
            N = rand(1); % Generate a new random number
            d2 = d2 + 1; % Move to the next position in the new population
            d1 = 1; % Reset the index for evaluation comparison
        else
            d1 = d1 + 1; % Move to the next chromosome in evaluation comparison
        end
    end

    P_new = Y1; % Return the new population
end
