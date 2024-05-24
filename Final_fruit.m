% Clear workspace, close figures, and clear command window
close all;
clear all;
clc;

% Read the input image
im_IN = imread('fruits.jpg');

% Conversion from RGB to HSV color space
im_HSV = rgb2hsv(im_IN);

% Divide the image into three channels for HSV: Hue, Saturation, and Value
im_H = im_HSV(:,:,1); % Hue channel
im_S = im_HSV(:,:,2); % Saturation channel
im_V = im_HSV(:,:,3); % Value channel

% Divide the image into three channels for RGB: Red, Green, and Blue
im_R = im_IN(:,:,1); % Red channel
im_G = im_IN(:,:,2); % Green channel
im_B = im_IN(:,:,3); % Blue channel

%-------------------------------------------------
% Segmentation for apple and banana
% Define thresholds for hue, saturation, and value for banana
h_inf=0.100;
h_sup=0.193;
s_inf=0.155;
s_sup=1.000;
v_inf=0.412;
v_sup=1.000;

% Perform color segmentation in HSV space for banana
im_H_BIN = roicolor(im_H, h_inf, h_sup);
im_S_BIN = roicolor(im_S, s_inf, s_sup);
im_V_BIN = roicolor(im_V, v_inf, v_sup);

% Combine binary masks for banana using AND operation
im_BIN1 = im_H_BIN .* im_S_BIN .* im_V_BIN;

% Crop segmented regions for banana and apple
banana_BIN = imcrop(im_BIN1, [1 7 710 487]);
apple_BIN = imcrop(im_BIN1, [1 495 710 955]);

% Perform color segmentation in HSV space for orange
h_inf=0.042;
h_sup=0.094;
s_inf=0.395;
s_sup=1.000;
v_inf=0.695;
v_sup=1.000;

% Perform color segmentation in HSV space for orange
im_H_BIN = roicolor(im_H, h_inf, h_sup);
im_S_BIN = roicolor(im_S, s_inf, s_sup);
im_V_BIN = roicolor(im_V, v_inf, v_sup);

% Combine binary masks for orange using AND operation
orange_BIN = im_H_BIN .* im_S_BIN .* im_V_BIN;

% Crop segmented region for orange
orange_BIN = imcrop(orange_BIN, [1 495 710 955]);

% Perform color segmentation in HSV space for kiwi
h_inf=0.061;
h_sup=0.082;
s_inf=0.227;
s_sup=0.758;
v_inf=0.043;
v_sup=0.730;

% Perform color segmentation in HSV space for kiwi
im_H_BIN = roicolor(im_H, h_inf, h_sup);
im_S_BIN = roicolor(im_S, s_inf, s_sup);
im_V_BIN = roicolor(im_V, v_inf, v_sup);

% Combine binary masks for kiwi using AND operation
kiwi_BIN = im_H_BIN .* im_S_BIN .* im_V_BIN;

% Crop segmented region for kiwi
kiwi_BIN = imcrop(kiwi_BIN, [1 307 710 764]);
%-------------------------------------------------

% Create masked RGB images for each fruit
im_R_mask = imcrop(im_R, [1 7 710 487]) .* uint8(banana_BIN); 
im_G_mask = imcrop(im_G, [1 7 710 487]) .* uint8(banana_BIN);
im_B_mask = imcrop(im_B, [1 7 710 487]) .* uint8(banana_BIN);
im_RGB_MASK_banana = cat(3, im_R_mask, im_G_mask, im_B_mask);

im_R_mask = imcrop(im_R, [1 495 710 955]) .* uint8(apple_BIN);
im_G_mask = imcrop(im_G, [1 495 710 955]) .* uint8(apple_BIN);
im_B_mask = imcrop(im_B, [1 495 710 955]) .* uint8(apple_BIN);
im_RGB_MASK_apple = cat(3, im_R_mask, im_G_mask, im_B_mask);

im_R_mask = imcrop(im_R, [1 495 710 955]) .* uint8(orange_BIN);
im_G_mask = imcrop(im_G, [1 495 710 955]) .* uint8(orange_BIN);
im_B_mask = imcrop(im_B, [1 495 710 955]) .* uint8(orange_BIN);
im_RGB_MASK_orange = cat(3, im_R_mask, im_G_mask, im_B_mask);

im_R_mask = imcrop(im_R, [1 307 710 764]) .* uint8(kiwi_BIN);
im_G_mask = imcrop(im_G, [1 307 710 764]) .* uint8(kiwi_BIN);
im_B_mask = imcrop(im_B, [1 307 710 764]) .* uint8(kiwi_BIN);
im_RGB_MASK_kiwi = cat(3, im_R_mask, im_G_mask, im_B_mask);

% Plot the segmented images and their masks
subplot(4,4,1);
imshow(im_HSV);
title('HSV picture')

subplot(4,4,2);
imshow(im_H);
title('Channel H');

subplot(4,4,3);
imshow(im_S);
title('Channel S');

subplot(4,4,4);
imshow(im_V);
title('Channel V');

subplot(4,4,5);
imshow(banana_BIN);
title('Banana Binary Mask');

subplot(4,4,6);
imshow(apple_BIN);
title('Apple Binary Mask');

subplot(4,4,7);
imshow(orange_BIN);
title('Orange Binary Mask');

subplot(4,4,8);
imshow(kiwi_BIN);
title('Kiwi Binary Mask');

subplot(4,4,9);
imshow(im_IN);
title('Original Picture');

subplot(4,4,10);
imshow(im_R);
title('Channel R');

subplot(4,4,11);
imshow(im_G);
title('Channel G');

subplot(4,4,12);
imshow(im_B);
title('Channel B');

subplot(4,4,13);
imshow(im_RGB_MASK_banana);
title('Banana Segmented');

subplot(4,4,14);
imshow(im_RGB_MASK_apple);
title('Apple Segmented');

subplot(4,4,15);
imshow(im_RGB_MASK_orange);
title('Orange Segmented');

subplot(4,4,16);
imshow(im_RGB_MASK_kiwi);
title('Kiwi Segmented');
