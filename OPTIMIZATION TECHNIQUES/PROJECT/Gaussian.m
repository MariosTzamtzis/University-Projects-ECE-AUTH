function [G] = Gaussian(u1, u2, c1, c2, s1, s2)
    % Calculate the exponent of the Gaussian function
    temp = ((u1 - c1)^2) / (2 * s1^2) + ((u2 - c2)^2) / (2 * s2^2);
    
    % Compute the Gaussian value using the exponent
    G = exp(-temp);
end
