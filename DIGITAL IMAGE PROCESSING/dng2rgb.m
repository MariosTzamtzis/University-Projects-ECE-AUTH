function [Csrgb, Clinear, Cxyz, Ccam] = dng2rgb(rawim, XYZ2Cam, wbcoeffs, bayertype, method, M, N)

%White Balancing
mask = wbmask(M,N,wbcoeffs, bayertype);
rawim = rawim .* mask;

%Demosaicing
switch method
    case 'nearest'
        Ccam = demosaicNN(rawim);
    case 'linear'
        Ccam = demosaicLinear(rawim);
end

figure();
imshow(Ccam);
title('Ccam')

rgb2xyz = [0.4124564 0.3575761 0.1804375; 0.2126729 0.7151522 0.0721750; 0.0193339 0.1191920 0.9503041];
rgb2cam = XYZ2Cam * rgb2xyz; % Assuming previously defined matrices
rgb2cam = rgb2cam ./ repmat(sum(rgb2cam,2),1,3); % Normalize rows to 1
cam2rgb = rgb2cam^-1;
Clinear = apply_cmatrix(Ccam, cam2rgb);
Clinear = max(0,min(Clinear,1)); % Always keep image clipped b/w 0-1
figure();
imshow(Clinear);
title('Clinear');

grayim = rgb2gray(Ccam);
grayscale = 0.25/mean(grayim(:));
bright_srgb = min(1,Ccam*grayscale);
figure();
Csrgb= bright_srgb.^(1/2.2);
imshow(Csrgb);
title('Csrgb');

Cxyz = apply_cmatrix(Ccam, XYZ2Cam^-1);
figure();
imshow(Cxyz);
title('Cxyz');

end


function output = demosaicNN(im)

[imageWidth,imageHeight]=size(im);

%creating masks for the bayer pattern
bayer_red = repmat([1 0; 0 0], ceil(imageWidth/2),ceil(imageHeight/2));
bayer_blue = repmat([0 0; 0 1], ceil(imageWidth/2),ceil(imageHeight/2));
bayer_green = repmat([0 1; 1 0], ceil(imageWidth/2),ceil(imageHeight/2));

%truncating the extra pixels at the edges
if(mod(imageWidth,2))==1
   bayer_red(size(bayer_red,1),:)=[];
   bayer_blue(size(bayer_blue,1),:)=[];
   bayer_green(size(bayer_green,1),:)=[];
end
if(mod(imageHeight,2)==1)
   bayer_red(:,size(bayer_red,2))=[];
   bayer_blue(:,size(bayer_blue,2))=[];
   bayer_green(:,size(bayer_green,2))=[];
end
    
%extracting the red, green and blue components of the image using the mask

red_image = im.*bayer_red;
blue_image = im.*bayer_blue;
green_image = im.*bayer_green;

%deducing the green pixels at missing points
green = green_image+imfilter(green_image,[0 1]);

%deducing the red pixels at missing points
redValue=im(1:2:imageWidth,1:2:imageHeight);
meanRed = mean(mean(redValue));
%red@blue
red_1 = imfilter(red_image, [0 0;0 1], meanRed);
%red@green
red_2 = imfilter(red_image, [0 1;1 0], meanRed);
%combine
red = red_image + red_1 +red_2;

%deducing the blue pixels at missing points
blueValue=im(1:2:imageWidth,1:2:imageHeight);
meanBlue = mean(mean(blueValue));
%blue@red
blue_1 = imfilter(blue_image, [0 0;0 1], meanBlue);
%blue@green
blue_2 = imfilter(blue_image, [0 1;1 0], meanBlue);
%combine
blue = blue_image + blue_1 +blue_2;

output(:,:,1) = red;
output(:,:,2) = green;
output(:,:,3) = blue;

end

function output = demosaicLinear(im)

[imageWidth,imageHeight]=size(im);

%creating masks for the bayer pattern
bayer_red = repmat([1 0; 0 0], ceil(imageWidth/2),ceil(imageHeight/2));
bayer_blue = repmat([0 0; 0 1], ceil(imageWidth/2),ceil(imageHeight/2));
bayer_green = repmat([0 1; 1 0], ceil(imageWidth/2),ceil(imageHeight/2));

%truncating the extra pixels at the edges
if(mod(imageWidth,2))==1
   bayer_red(size(bayer_red,1),:)=[];
   bayer_blue(size(bayer_blue,1),:)=[];
   bayer_green(size(bayer_green,1),:)=[];
end
if(mod(imageHeight,2)==1)
   bayer_red(:,size(bayer_red,2))=[];
   bayer_blue(:,size(bayer_blue,2))=[];
   bayer_green(:,size(bayer_green,2))=[];
end
    
%extracting the red, green and blue components of the image using the mask
red_image = im.*bayer_red;
blue_image = im.*bayer_blue;
green_image = im.*bayer_green;

%deducing the green pixels at missing points
green = green_image + imfilter(green_image, [0 1 0;1 0 1; 0 1 0]/4);

%deducing the red pixels at missing points
red_1 = imfilter(red_image, [1 0 1;0 0 0;1 0 1]/4);
red_2 = imfilter(red_image, [0 1 0;1 0 1;0 1 0]/2);
red = red_image+red_1+red_2;

%deducing the blue pixels at missing points
blue_1 = imfilter(blue_image, [1 0 1;0 0 0;1 0 1]/4);
blue_2 = imfilter(blue_image, [0 1 0;1 0 1;0 1 0]/2);
blue = blue_image+blue_1+blue_2;

output(:,:,1) = red;
output(:,:,2) = green;
output(:,:,3) = blue;

end

function corrected = apply_cmatrix(im,cmatrix)
% CORRECTED = apply_cmatrix(IM,CMATRIX)
%
% Applies CMATRIX to RGB input IM. Finds the appropriate weighting of the
% old color planes to form the new color planes, equivalent to but much
% more efficient than applying a matrix transformation to each pixel.
    if size(im,3)~=3
        error('Apply cmatrix to RGB image only.')
    end
    r = cmatrix(1,1)*im(:,:,1)+cmatrix(1,2)*im(:,:,2)+cmatrix(1,3)*im(:,:,3);
    g = cmatrix(2,1)*im(:,:,1)+cmatrix(2,2)*im(:,:,2)+cmatrix(2,3)*im(:,:,3);
    b = cmatrix(3,1)*im(:,:,1)+cmatrix(3,2)*im(:,:,2)+cmatrix(3,3)*im(:,:,3);
    corrected = cat(3,r,g,b);
end

function colormask = wbmask(m,n,wbmults,align)
    % COLORMASK = wbmask(M,N,WBMULTS,ALIGN)
    %
    % Makes a white-balance multiplicative mask for an image of size m-by-n
    % with RGB while balance multipliers WBMULTS = [R_scale G_scale B_scale].
    % ALIGN is string indicating Bayer arrangement: ’rggb’,’gbrg’,’grbg’,’bggr’
    colormask = wbmults(2)*ones(m,n); %Initialize to all green values
    switch align
        case 'rggb'
        colormask(1:2:end,1:2:end) = wbmults(1); %r
        colormask(2:2:end,2:2:end) = wbmults(3); %b
        case 'bggr'
        colormask(2:2:end,2:2:end) = wbmults(1); %r
        colormask(1:2:end,1:2:end) = wbmults(3); %b
        case 'grbg'
        colormask(1:2:end,2:2:end) = wbmults(1); %r
        colormask(2:2:end,1:2:end) = wbmults(3); %b
        case 'gbrg'
        colormask(2:2:end,1:2:end) = wbmults(1); %r
        colormask(1:2:end,2:2:end) = wbmults(3); %b
    end
end
