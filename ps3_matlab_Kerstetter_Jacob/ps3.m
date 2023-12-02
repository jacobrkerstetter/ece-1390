% ps3
% Jacob Kerstetter
% 4406239

clear
clc

%% 1-a
% Read images
L = im2double(imread(fullfile('input', 'pair0-L.png')));
R = im2double(imread(fullfile('input', 'pair0-R.png')));

% Compute disparity
D_L = disparity_ssd(L, R);
D_R = disparity_ssd(R, L);

% Save output images (D_L as output/ps3-1-a-1.png and D_R as output/ps3-1-a-2.png)
% Note: They may need to be scaled/shifted before saving to show results properly
imwrite(abs(D_L), fullfile('output', 'ps3-1-a-1.png'));
imwrite(abs(D_R), fullfile('output', 'ps3-1-a-2.png'));

%% 2-a
L2 = rgb2gray(im2double(imread(fullfile('input', 'pair1-L.png'))));
R2 = rgb2gray(im2double(imread(fullfile('input', 'pair1-R.png'))));

% Compute disparity
D_L2 = medfilt2(disparity_ssd(L2, R2));
D_R2 = medfilt2(disparity_ssd(R2, L2));

% Save images
imwrite(mat2gray(D_L2), fullfile('output', 'ps3-2-a-1.png'));
imwrite(mat2gray(D_R2), fullfile('output', 'ps3-2-a-2.png'));

%% 3-a
% load images
L2 = rgb2gray(im2double(imread(fullfile('input', 'pair1-L.png'))));
R2 = rgb2gray(im2double(imread(fullfile('input', 'pair1-R.png'))));

% add gaussian noise to image L2
L2_noisy = imnoise(L2, 'gaussian');

% run ssd disparity again
D_L2_noise = medfilt2(disparity_ssd(L2_noisy, R2));
D_R2_noise = medfilt2(disparity_ssd(R2, L2_noisy));

% save images
imwrite(mat2gray(D_L2_noise), fullfile('output', 'ps3-3-a-1.png'));
imwrite(mat2gray(D_R2_noise), fullfile('output', 'ps3-3-a-2.png'));

% increase contrsat of L2 by 10%
L2_contrast = L2 * 1.1;

% run ssd disparity again
D_L2_contrast = medfilt2(disparity_ssd(L2_contrast, R2));
D_R2_contrast = medfilt2(disparity_ssd(R2, L2_contrast));

% save images
imwrite(mat2gray(D_L2_contrast), fullfile('output', 'ps3-3-b-1.png'));
imwrite(mat2gray(D_R2_contrast), fullfile('output', 'ps3-3-b-2.png'));

%% 4-a
% load images
L2 = rgb2gray(im2double(imread(fullfile('input', 'pair1-L.png'))));
R2 = rgb2gray(im2double(imread(fullfile('input', 'pair1-R.png'))));

% compute disparity
D_L2_NCorr = medfilt2(disparity_ncorr(L2, R2));
D_R2_NCorr = medfilt2(disparity_ncorr(R2, L2));

% write images to file
imwrite(mat2gray(D_L2_NCorr), fullfile('output', 'ps3-4-a-1.png'));
imwrite(mat2gray(D_R2_NCorr), fullfile('output', 'ps3-4-a-2.png'));

%% 4-b
% load images
L2 = rgb2gray(im2double(imread(fullfile('input', 'pair1-L.png'))));
R2 = rgb2gray(im2double(imread(fullfile('input', 'pair1-R.png'))));

% add gaussian noise to image L2
L2_noisy = imnoise(L2, 'gaussian');

% run ssd disparity again
D_L2_noise = medfilt2(disparity_ncorr(L2_noisy, R2));
D_R2_noise = medfilt2(disparity_ncorr(R2, L2_noisy));

% save images
imwrite(mat2gray(D_L2_noise), fullfile('output', 'ps3-4-b-1.png'));
imwrite(mat2gray(D_R2_noise), fullfile('output', 'ps3-4-b-2.png'));

% increase contrsat of L2 by 10%
L2_contrast = L2 * 1.1;

% run ssd disparity again
D_L2_contrast = medfilt2(disparity_ncorr(L2_contrast, R2));
D_R2_contrast = medfilt2(disparity_ncorr(R2, L2_contrast));

% save images
imwrite(mat2gray(D_L2_contrast), fullfile('output', 'ps3-4-b-3.png'));
imwrite(mat2gray(D_R2_contrast), fullfile('output', 'ps3-4-b-4.png'));