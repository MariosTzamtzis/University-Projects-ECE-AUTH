function Y = mutation(P, n)
    % P = population
    % n = number of chromosomes to be mutated
    % Y = n x 320 array

    [x1, y1] = size(P);
    Z = zeros(n, y1); % Initialize an array for mutated chromosomes

    for i = 1:n
        r1 = randi(x1); % Randomly select a parent chromosome
        A1 = P(r1, :); % Retrieve the selected parent chromosome

        r2 = randi(y1); % Randomly select a bit to mutate
        % Perform bit flip mutation: If the selected bit is 1, change it to 0; otherwise, change it to 1
        if A1(1, r2) == 1
            A1(1, r2) = 0;
        else
            A1(1, r2) = 1;
        end

        Z(i, :) = A1; % Store the mutated chromosome in the result array
    end

    Y = Z; % Return the array containing mutated chromosomes
end
