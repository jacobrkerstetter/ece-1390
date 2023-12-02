% Jacob Kerstetter
% Problem Set #1

clear
clc

% load the 3 images
img1 = imread('input/im1.jpg');
img2 = imread('input/im2.jpg');
img3 = imread('input/im3.png');

% send images into segmentation function
im1_out1 = segment_kmeans(img1, 5, 7, 5);
im1_out2 = segment_kmeans(img1, 5, 15, 5);
im1_out3 = segment_kmeans(img1, 5, 30, 5);

im1_out4 = segment_kmeans(img1, 5, 7, 5);
im1_out5 = segment_kmeans(img1, 5, 7, 15);
im1_out6 = segment_kmeans(img1, 5, 7, 20);

im1_out7 = segment_kmeans(img1, 3, 7, 5);
im1_out8 = segment_kmeans(img1, 5, 7, 5);
im1_out9 = segment_kmeans(img1, 7, 7, 5);

im2_out1 = segment_kmeans(img2, 3, 7, 15);
im2_out2 = segment_kmeans(img2, 3, 15, 15);
im2_out3 = segment_kmeans(img2, 3, 30, 15);

im2_out4 = segment_kmeans(img2, 5, 7, 5);
im2_out5 = segment_kmeans(img2, 5, 15, 5);
im2_out6 = segment_kmeans(img2, 5, 30, 5);

im2_out7 = segment_kmeans(img2, 3, 7, 5);
im2_out8 = segment_kmeans(img2, 5, 7, 5);
im2_out9 = segment_kmeans(img2, 7, 7, 5);

im3_out1 = segment_kmeans(img3, 3, 15, 5);
im3_out2 = segment_kmeans(img3, 5, 15, 5);
im3_out3 = segment_kmeans(img3, 7, 15, 5);

im3_out4 = segment_kmeans(img3, 5, 7, 5);
im3_out5 = segment_kmeans(img3, 5, 15, 5);
im3_out6 = segment_kmeans(img3, 5, 30, 5);

im3_out7 = segment_kmeans(img3, 5, 15, 5);
im3_out8 = segment_kmeans(img3, 5, 15, 15);
im3_out9 = segment_kmeans(img3, 5, 15, 20);

% convert images back to uint8 and save
im1_save1 = im2uint8(im1_out1);
imwrite(im1_save1, 'output/im1_save1.png')
im1_save2 = im2uint8(im1_out2);
imwrite(im1_save2, 'output/im1_save2.png')
im1_save3 = im2uint8(im1_out3);
imwrite(im1_save3, 'output/im1_save3.png')

im1_save4 = im2uint8(im1_out4);
imwrite(im1_save4, 'output/im1_save4.png')
im1_save5 = im2uint8(im1_out5);
imwrite(im1_save5, 'output/im1_save5.png')
im1_save6 = im2uint8(im1_out6);
imwrite(im1_save6, 'output/im1_save6.png')

im1_save7 = im2uint8(im1_out7);
imwrite(im1_save7, 'output/im1_save7.png')
im1_save8 = im2uint8(im1_out8);
imwrite(im1_save8, 'output/im1_save8.png')
im1_save9 = im2uint8(im1_out9);
imwrite(im1_save9, 'output/im1_save9.png')

im2_save1 = im2uint8(im2_out1);
imwrite(im2_save1, 'output/im2_save1.png')
im2_save2 = im2uint8(im2_out2);
imwrite(im2_save2, 'output/im2_save2.png')
im2_save3 = im2uint8(im2_out3);
imwrite(im2_save3, 'output/im2_save3.png')

im2_save4 = im2uint8(im2_out4);
imwrite(im2_save4, 'output/im2_save4.png')
im2_save5 = im2uint8(im2_out5);
imwrite(im2_save5, 'output/im2_save5.png')
im2_save6 = im2uint8(im2_out6);
imwrite(im2_save6, 'output/im2_save6.png')

im2_save7 = im2uint8(im2_out7);
imwrite(im2_save7, 'output/im2_save7.png')
im2_save8 = im2uint8(im2_out8);
imwrite(im2_save8, 'output/im2_save8.png')
im2_save9 = im2uint8(im2_out9);
imwrite(im2_save9, 'output/im2_save9.png')

im3_save1 = im2uint8(im3_out1);
imwrite(im3_save1, 'output/im3_save1.png')
im3_save2 = im2uint8(im3_out2);
imwrite(im3_save2, 'output/im3_save2.png')
im3_save3 = im2uint8(im3_out3);
imwrite(im3_save3, 'output/im3_save3.png')

im3_save4 = im2uint8(im3_out4);
imwrite(im3_save4, 'output/im3_save4.png')
im3_save5 = im2uint8(im3_out5);
imwrite(im3_save5, 'output/im3_save5.png')
im3_save6 = im2uint8(im3_out6);
imwrite(im3_save6, 'output/im3_save6.png')

im3_save7 = im2uint8(im3_out7);
imwrite(im3_save7, 'output/im3_save7.png')
im3_save8 = im2uint8(im3_out8);
imwrite(im3_save8, 'output/im3_save8.png')
im3_save9 = im2uint8(im3_out9);
imwrite(im3_save9, 'output/im3_save9.png')