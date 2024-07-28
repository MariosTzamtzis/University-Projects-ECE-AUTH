function Y = evaluation(P, u_test, y_test)
    % P = population
    % u_test = test input data
    % y_test = expected output data

    [x1, ~] = size(P);
    H = zeros(1, x1); % Initialize array for storing fitness values

    for i = 1:x1
        % Initialize arrays for parameters
        a = zeros(15, 1);
        c1 = zeros(15, 1);
        c2 = zeros(15, 1);
        s1 = zeros(15, 1);
        s2 = zeros(15, 1);
        b = 0;
        temp1 = 1;
        temp2 = 1;

        % Decoding and scaling the binary chromosomes to real values
        for j = 1:15
            % Decoding binary strings to decimal values
            a(j) = bi2de(P(i, temp1:(temp1 + 4)), 'left-msb');
            c1(j) = bi2de(P(i, (temp1 + 75):(temp1 + 75 + 4)), 'left-msb');
            c2(j) = bi2de(P(i, (temp1 + 150):(temp1 + 150 + 4)), 'left-msb');
            s1(j) = bi2de(P(i, (temp2 + 225):(temp2 + 225 + 2)), 'left-msb');
            s2(j) = bi2de(P(i, (temp2 + 270):(temp2 + 270 + 2)), 'left-msb');
            temp1 = temp1 + 5;
            temp2 = temp2 + 3;

            % Scaling decoded values to the required range
            a(j) = (a(j) / 10) - 1.5;
            c1(j) = (c1(j) / 10) - 1;
            c2(j) = (c2(j) / 10) - 2;
            s1(j) = (s1(j) / 10) + 0.1;
            s2(j) = (s2(j) / 10) + 0.1;
        end

        % Decoding and scaling parameter 'b'
        b = bi2de(P(i, 316:320), 'left-msb');
        b = (b / 10) - 1.5;

        const = [c1 c2 s1 s2]; % Create parameter constants for function evaluation

        % Evaluation of the fitness function using the parameters obtained
        y_hat = zeros(length(y_test), 1);
        for k = 1:length(y_test)
            y_hat(k) = f_hat(a, b, const, u_test(k, 1), u_test(k, 2));
        end

        % Calculate mean squared error as the fitness value for the chromosome
        H(1, i) = immse(y_test, y_hat);
    end

    Y = H; % Return the fitness values
end
