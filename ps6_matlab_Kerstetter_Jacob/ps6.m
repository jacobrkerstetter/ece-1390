% Jacob Kerstetter 
% 4406239
% ECE1390 PS6

clear
clc

%% 1-a: Load the two motion sets and run LK on them
% load in images
shift0 = im2double(imread(fullfile('input', 'TestSeq', 'Shift0.png')));
shiftR2 = im2double(imread(fullfile('input', 'TestSeq', 'ShiftR2.png')));
shiftR5U5 = im2double(imread(fullfile('input', 'TestSeq', 'ShiftR5U5.png')));

% plot and save both sets
[u1, v1] = lk(imgaussfilt(shift0, 3), imgaussfilt(shiftR2, 3), 9);
imagesc([u1, v1])
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-1-a-1.png'))

[u2, v2] = lk(imgaussfilt(shift0, 3), imgaussfilt(shiftR5U5, 3), 9);
imagesc([u2, v2])
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-1-a-2.png'))

%% 1-b: Attempt to use LK on large shifts (10, 20, 40)
% load in new images
shiftR10 = im2double(imread(fullfile('input', 'TestSeq', 'ShiftR10.png')));
shiftR20 = im2double(imread(fullfile('input', 'TestSeq', 'ShiftR20.png')));
shiftR40 = im2double(imread(fullfile('input', 'TestSeq', 'ShiftR40.png')));

% plot and save all three sets
[u3, v3] = lk(imgaussfilt(shift0, 3), imgaussfilt(shiftR10, 3), 9);
imagesc([u3, v3])
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-1-b-1.png'))

[u4, v4] = lk(imgaussfilt(shift0, 3), imgaussfilt(shiftR20, 3), 9);
imagesc([u4, v4])
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-1-b-2.png'))

[u5, v5] = lk(imgaussfilt(shift0, 3), imgaussfilt(shiftR40, 3), 9);
imagesc([u5, v5])
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-1-b-3.png'))

%% 2-a: Reduce the four images and plot as a subplot
% calculate gaussian pyramid
yos = im2double(imread(fullfile('input', 'DataSeq1', 'yos_img_01.jpg')));
yos_half = reduce(yos);
yos_quarter = reduce(yos_half);
yos_eighth = reduce(yos_quarter);

% display images
subplot(2, 2, 1)
imshow(yos);
subplot(2, 2, 2);
imshow(yos_half);
subplot(2, 2, 3);
imshow(yos_quarter);
subplot(2, 2, 4);
imshow(yos_eighth);
saveas(gcf, fullfile('output', 'ps6-2-a-1.png'))

% 2-b: Expand to create 4-level Laplacian pyramid
% expand yos_eighth
yos_level2_expanded = yos_quarter - expand(yos_eighth, yos_quarter);

% expand yos_quarter
yos_level1_expanded = yos_half - expand(yos_quarter, yos_half);

% expand yos half
yos_level0_expanded = yos - expand(yos_half, yos);

% display images
subplot(2, 2, 1);
imshow(yos_eighth);
subplot(2, 2, 2)
imshow(yos_level2_expanded);
subplot(2, 2, 3);
imshow(yos_level1_expanded);
subplot(2, 2, 4);
imshow(yos_level0_expanded);
saveas(gcf, fullfile('output', 'ps6-2-b-1.png'))

%% 3-a: Apply single-level LK to DataSeq1 and DataSeq2
% load in images
yos_1 = im2double(imread(fullfile('input', 'DataSeq1/yos_img_01.jpg')));
yos_2 = im2double(imread(fullfile('input', 'DataSeq1/yos_img_02.jpg')));
yos_3 = im2double(imread(fullfile('input', 'DataSeq1/yos_img_03.jpg')));

seq2_0 = im2double(imread(fullfile('input', 'DataSeq2/0.png')));
seq2_1 = im2double(imread(fullfile('input', 'DataSeq2/1.png')));
seq2_2 = im2double(imread(fullfile('input', 'DataSeq2/2.png')));

% Single-level LK and warping on DataSeq1
% reduce images
yos1_half = reduce(yos_1);
yos2_half = reduce(yos_2);
yos3_half = reduce(yos_3);
yos1_quarter = reduce(yos1_half);
yos2_quarter = reduce(yos2_half);
yos3_quarter = reduce(yos3_half);

% apply LK to yos_1 -> yos_2
[u1_2, v1_2] = lk(yos1_quarter, yos2_quarter, 5);
% apply LK to yos_2 -> yos_3
[u2_3, v2_3] = lk(yos2_quarter, yos3_quarter, 5);

% plot x/y displacements for level of pyramid that works well
subplot(2, 2, 1)
imagesc(u1_2)
colormap jet
colorbar
title('yos1 --> yos2: u')
subplot(2, 2, 2)
imagesc(v1_2)
colormap jet
colorbar
title('yos1 --> yos2: v')
subplot(2, 2, 3)
imagesc(u2_3)
colormap jet
colorbar
title('yos2 --> yos3: u')
subplot(2, 2, 4)
imagesc(v2_3)
title('yos2 --> yos3: v')
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-3-a-1.png'))

% warp image 2 back to image 1
warpedYosImg2 = warp(yos2_quarter, u1_2, v1_2);

% plot diff image of warmped image2 - image1
yos_diffImg = yos1_quarter - warpedYosImg2;
imwrite(yos_diffImg, fullfile('output', 'ps6-3-a-2.png'))

%% Single-level LK and warping on DataSeq2 
% reduce images
seq2_0_half = reduce(seq2_0);
seq2_1_half = reduce(seq2_1);
seq2_2_half = reduce(seq2_2);
seq2_0_quarter = reduce(seq2_0_half);
seq2_1_quarter = reduce(seq2_1_half);
seq2_2_quarter = reduce(seq2_2_half);
seq2_0_eighth = reduce(seq2_0_quarter);
seq2_1_eighth = reduce(seq2_1_quarter);
seq2_2_eighth = reduce(seq2_2_quarter);

% apply LK to seq2_0 -> seq2_1
[uSeq0_1, vSeq0_1] = lk(seq2_0_eighth, seq2_1_eighth, 9);
% apply LK to seq2_1 -> seq2_2
[uSeq1_2, vSeq1_2] = lk(seq2_1_eighth, seq2_2_eighth, 9);

% plot x/y displacements for level of pyramid that works well
subplot(2, 2, 1)
imagesc(uSeq0_1)
title('seq2_0 --> seq2_1: u')
colormap jet
colorbar
subplot(2, 2, 2)
imagesc(vSeq0_1)
title('seq2_0 --> seq2_1: v')
colormap jet
colorbar
subplot(2, 2, 3)
imagesc(uSeq1_2)
title('seq2_1 --> seq2_2: u')
colormap jet
colorbar
subplot(2, 2, 4)
imagesc(vSeq1_2)
title('seq2_1 --> seq2_2: v')
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-3-a-3.png'))

% warp image 2 back to image 1
warpedSeq2 = warp(seq2_1_eighth, uSeq0_1, vSeq0_1);

% plot diff image of warped image2 - image1
diffSeq2Img = seq2_0_eighth - warpedSeq2;
imwrite(yos_diffImg, fullfile('output', 'ps6-3-a-4.png'))

%% 4-a: Do hierarchical LK on TestSeq (R10, R20, R40)
% load the images
shift0 = im2double(imread(fullfile('input', 'TestSeq', 'Shift0.png')));
shiftR10 = im2double(imread(fullfile('input', 'TestSeq', 'ShiftR10.png')));
shiftR20 = im2double(imread(fullfile('input', 'TestSeq', 'ShiftR20.png')));
shiftR40 = im2double(imread(fullfile('input', 'TestSeq', 'ShiftR40.png')));

% compute shifts and warped image 2
[u_10, v_10, warpedI2_10] = hierarchical_lk(imgaussfilt(shift0, 3), imgaussfilt(shiftR10, 3), 4, 11);
[u_20, v_20, warpedI2_20] = hierarchical_lk(imgaussfilt(shift0, 3), imgaussfilt(shiftR20, 3), 5, 13);
[u_40, v_40, warpedI2_40] = hierarchical_lk(imgaussfilt(shift0, 3), imgaussfilt(shiftR40, 3), 6, 15);

% plot the shifts
subplot(3, 2, 1)
imagesc(u_10)
title('0 --> R10: u')
colormap jet
colorbar
subplot(3, 2, 2)
imagesc(v_10)
title('0 --> R10: v')
colormap jet
colorbar

subplot(3, 2, 3)
imagesc(u_20)
title('0 --> R20: u')
colormap jet
colorbar
subplot(3, 2, 4)
imagesc(v_20)
title('0 --> R20: v')
colormap jet
colorbar

subplot(3, 2, 5)
imagesc(u_40)
title('0 --> R40: u')
colormap jet
colorbar
subplot(3, 2, 6)
imagesc(v_40)
title('0 --> R40: v')
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-4-a-1.png'))

% compute image differences
diff_10 = imgaussfilt(shift0, 7) - warpedI2_10;
diff_20 = imgaussfilt(shift0, 7)- warpedI2_20;
diff_40 = imgaussfilt(shift0, 7) - warpedI2_40;

% plot the differences
subplot(1, 3, 1), imshow(diff_10);
subplot(1, 3, 2), imshow(diff_20);
subplot(1, 3, 3), imshow(diff_40);
saveas(gcf, fullfile('output', 'ps6-4-a-2.png'))

%% 4-b: Do hierarchical LK on the yos sequence
% load the images for the yos sequence
yos_1 = im2double(imread(fullfile('input', 'DataSeq1/yos_img_01.jpg')));
yos_2 = im2double(imread(fullfile('input', 'DataSeq1/yos_img_02.jpg')));
yos_3 = im2double(imread(fullfile('input', 'DataSeq1/yos_img_03.jpg')));

% compute shifts and warped image 2 (yos1 --> yos2, yos2 --> yos3)
[u1_2, v1_2, warpedI2_1] = hierarchical_lk(yos_1, yos_2, 3, 7);
[u2_3, v2_3, warpedI2_2] = hierarchical_lk(yos_2, yos_3, 2, 7);

% plot shifts
subplot(2, 2, 1)
imagesc(u1_2)
title('yos1 --> yos2: u')
colormap jet
colorbar
subplot(2, 2, 2)
imagesc(v1_2)
title('yos1 --> yos2: v')
colormap jet
colorbar

subplot(2, 2, 3)
imagesc(u2_3)
title('yos2 --> yos3: u')
colormap jet
colorbar
subplot(2, 2, 4)
imagesc(v2_3)
title('yos2 --> yos3: v')
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-4-b-1.png'))

% compute image differences
diff1_2 = imgaussfilt(yos_1, 3) - warpedI2_1;
diff2_3 = imgaussfilt(yos_2, 3) - warpedI2_2;

% plot the differences
subplot(1, 2, 1), imshow(diff1_2);
subplot(1, 2, 2), imshow(diff2_3);
saveas(gcf, fullfile('output', 'ps6-4-b-2.png'))

%% 4-c: Do hierarchical LK on sequence 2
% load the images for sequence 2 
seq2_0 = rgb2gray(im2double(imread(fullfile('input', 'DataSeq2/0.png'))));
seq2_1 = rgb2gray(im2double(imread(fullfile('input', 'DataSeq2/1.png'))));
seq2_2 = rgb2gray(im2double(imread(fullfile('input', 'DataSeq2/2.png'))));

% compute shifts and warped image 2 (seq2_0 --> seq2_1, seq2_1 --> seq2_2)
[u1_2, v1_2, warpedI2_seq2_1] = hierarchical_lk(seq2_0, seq2_1, 3, 9);
[u2_3, v2_3, warpedI2_seq2_2] = hierarchical_lk(seq2_1, seq2_2, 3, 9);

% plot shifts
subplot(2, 2, 1)
imagesc(u1_2)
title('seq2_0 --> seq2_1: u')
colormap jet
colorbar
subplot(2, 2, 2)
imagesc(v1_2)
title('seq2_0 --> seq2_1: v')
colormap jet
colorbar

subplot(2, 2, 3)
imagesc(u2_3)
title('seq2_1 --> seq2_2: u')
colormap jet
colorbar
subplot(2, 2, 4)
imagesc(v2_3)
title('seq2_1 --> seq2_2: v')
colormap jet
colorbar
saveas(gcf, fullfile('output', 'ps6-4-c-1.png'))

% compute image differences
diffseq2_0_1 = seq2_0 - warpedI2_seq2_1;
diffseq2_1_2 = seq2_1 - warpedI2_seq2_2;

% plot the differences
subplot(1, 2, 1), imshow(diffseq2_0_1);
subplot(1, 2, 2), imshow(diffseq2_1_2);
saveas(gcf, fullfile('output', 'ps6-4-c-2.png'))