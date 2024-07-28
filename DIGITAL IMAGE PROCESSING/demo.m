clear;
clc;
close all;

% Load a sample .dng file
filename = 'RawImage.dng';

% Read the .dng file using the readdng function
[rawim, XYZ2Cam, wbcoeffs] = readdng(filename);

M = size(rawim,1);
N = size(rawim,2);

% Set the Bayer pattern type (in this case, RGGB)
bayertype = 'gbrg';

% Set the interpolation method to nearest neighbourhood
method = 'nearest';

% Convert the raw image to RGB using the dng2rgb function
[Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, bayertype, method,M,N);

% Display the resulting RGB image and its histograms for each channel
figure;
subplot(2,2,1);
imshow(Csrgb);
title('RGB image');
subplot(2,2,2);
imhist(Csrgb(:,:,1));
title('Red channel histogram');
subplot(2,2,3);
imhist(Csrgb(:,:,2));
title('Green channel histogram');
subplot(2,2,4);
imhist(Csrgb(:,:,3));
title('Blue channel histogram');

% Display the resulting Clinear image and its histograms for each channel
figure;
subplot(2,2,1);
imshow(Clinear);
title('Clinear image');
subplot(2,2,2);
imhist(Clinear(:,:,1));
title('Red channel histogram');
subplot(2,2,3);
imhist(Clinear(:,:,2));
title('Green channel histogram');
subplot(2,2,4);
imhist(Clinear(:,:,3));
title('Blue channel histogram');

% Display the resulting Ccam image and its histograms for each channel
figure;
subplot(2,2,1);
imshow(Ccam);
title('Ccam image');
subplot(2,2,2);
imhist(Ccam(:,:,1));
title('Red channel histogram');
subplot(2,2,3);
imhist(Ccam(:,:,2));
title('Green channel histogram');
subplot(2,2,4);
imhist(Ccam(:,:,3));
title('Blue channel histogram');

% Display the resulting Cxyz image and its histograms for each channel
figure;
subplot(2,2,1);
imshow(Cxyz);
title('Cxyz image');
subplot(2,2,2);
imhist(Cxyz(:,:,1));
title('Red channel histogram');
subplot(2,2,3);
imhist(Cxyz(:,:,2));
title('Green channel histogram');
subplot(2,2,4);
imhist(Cxyz(:,:,3));
title('Blue channel histogram');
