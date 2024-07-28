function P = population(n)
    % P = population
    % n = size of population (number of chromosomes)
    % 320 = number of bits per chromosome

    P = round(rand(n, 320)); % Create a random population of size n with 320 bits per chromosome
end
