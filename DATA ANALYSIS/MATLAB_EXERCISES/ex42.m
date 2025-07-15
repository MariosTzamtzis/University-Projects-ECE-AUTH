clc;
clear;

sigma = 5;

l = 500;
w = 300;
surfaceSigma = sqrt(w^2*sigma^2 + l^2*sigma^2);
fprintf("Uncertainty in area = %.4f\n", surfaceSigma);

l = 10:1000;
w = sqrt(surfaceSigma^2 - l.^2*sigma^2)/sigma;
figure();
plot(l,w);


w = 10:1000;
surfaceSigma = NaN(length(w));
for i=1:length(w)
    surfaceSigma(:, i) = sqrt(w.^2.*sigma^2 + l(i)^2*sigma^2);
end
figure();
surf(l, w, surfaceSigma);