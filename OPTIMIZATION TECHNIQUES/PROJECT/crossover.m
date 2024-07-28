function Y = crossover(P, n)
    % P = population
    % n = number of pairs of chromosomes to be crossed over
    % Y = 2n x 320 array

    [x1, y1] = size(P);
    Z = zeros(2 * n, y1); % Preallocate memory for the new array

    % Loop for the specified number of pairs
    for i = 1:n
        r1 = randi(x1, 1, 2); % Randomly select two different rows
        while r1(1) == r1(2) % Ensure the rows are different
            r1 = randi(x1, 1, 2);
        end

        A1 = P(r1(1), :); % Retrieve the chromosomes for crossover
        A2 = P(r1(2), :);

        r2 = 1 + randi(y1 - 1); % Randomly select crossover point

        B1 = A1(1, r2:y1); % Store section after crossover point

        % Swap sections between two chromosomes at the crossover point
        A1(1, r2:y1) = A2(1, r2:320);
        A2(1, r2:320) = B1;

        % Store the modified chromosomes in the new array
        Z(2 * i - 1, :) = A1;
        Z(2 * i, :) = A2;
    end

    Y = Z; % Return the resulting array
end
