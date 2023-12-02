% Jacob Kerstetter
% 4406239
% ECE 1390 PS5

clear
clc

%% 1-a
% load original images
transAOrig = imread(fullfile('input', 'transA.jpg'));
transBOrig = imread(fullfile('input', 'transB.jpg'));
simAOrig = imread(fullfile('input', 'simA.jpg'));
simBOrig = imread(fullfile('input', 'simB.jpg'));

% load images and filter
transA = imgaussfilt(imread(fullfile('input', 'transA.jpg')), 2);
simA = imgaussfilt(imread(fullfile('input', 'simA.jpg')), 2);
transB = imgaussfilt(imread(fullfile('input', 'transB.jpg')), 2);
simB = imgaussfilt(imread(fullfile('input', 'simB.jpg')), 2);
checkers = imread(fullfile('input', 'check.bmp'));

% compute gradients and attach
[gradTransAx, gradTransAy] = compute_gradient(transA);
[gradSimAx, gradSimAy] = compute_gradient(simA);
[gradTransBx, gradTransBy] = compute_gradient(transB);
[gradSimBx, gradSimBy] = compute_gradient(simB);
[checkX, checkY] = compute_gradient(checkers);

gradTransA = [gradTransAx, gradTransAy];
gradSimA = [gradSimAx, gradSimAy];
gradTransB = [gradTransBx, gradTransBy];
gradSimB = [gradSimBx, gradSimBy];

% save images
imwrite(mat2gray(gradTransA), fullfile('output', 'ps5-1-a-1.png'));
imwrite(mat2gray(gradSimA), fullfile('output', 'ps5-1-a-2.png'));

%% 1-b 
RTransA = harris(gradTransAx, gradTransAy, 3);
imwrite(mat2gray(RTransA), fullfile('output', 'ps5-1-b-1.png'));
RTransB = harris(gradTransBx, gradTransBy, 3);
imwrite(mat2gray(RTransB), fullfile('output', 'ps5-1-b-2.png'));
RSimA = harris(gradSimAx, gradSimAy, 3);
imwrite(mat2gray(RSimA), fullfile('output', 'ps5-1-b-3.png'));
RSimB = harris(gradSimBx, gradSimBy, 3);
imwrite(mat2gray(RSimB), fullfile('output', 'ps5-1-b-4.png'));

%% Testing on checkerboard
RCheck = harris(checkX, checkY, 3);
% imshow(mat2gray(RCheck))

%% 1-c
%% Testing on checkboard
% checkFiltered = filter_corners(RCheck, 100, 7);
% figure, imshow(checkers)
% hold on
% for i = 1:size(checkFiltered, 1)
%     plot(checkFiltered(i,1), checkFiltered(i,2), 'g+', 'LineWidth', 2);
% end

%% Plotting corners for the four images
TransAFiltered = filter_corners(RTransA, 2e8, 17);
% figure, imshow(transAOrig)
% hold on
% for i = 1:size(TransAFiltered, 1)
%     plot(TransAFiltered(i,1), TransAFiltered(i,2), 'g+', 'LineWidth', 2);
% end
% saveas(gcf, fullfile('output', 'ps5-1-c-1.png'))

TransBFiltered = filter_corners(RTransB, 1e8, 17);
% figure, imshow(transBOrig)
% hold on
% for i = 1:size(TransBFiltered, 1)
%     plot(TransBFiltered(i,1), TransBFiltered(i,2), 'g+', 'LineWidth', 2);
% end
% saveas(gcf, fullfile('output', 'ps5-1-c-2.png'))

SimAFiltered = filter_corners(RSimA, 1e8, 17);
% figure, imshow(simAOrig)
% hold on
% for i = 1:size(SimAFiltered, 1)
%     plot(SimAFiltered(i,1), SimAFiltered(i,2), 'g+', 'LineWidth', 2);
% end
% saveas(gcf, fullfile('output', 'ps5-1-c-3.png'))

SimBFiltered = filter_corners(RSimB, 1e8, 17);
% figure, imshow(simBOrig)
% hold on
% for i = 1:size(SimBFiltered, 1)
%     plot(SimBFiltered(i,1), SimBFiltered(i,2), 'g+', 'LineWidth', 2);
% end
% saveas(gcf, fullfile('output', 'ps5-1-c-4.png'))

%% 2-a: Plot gradients and directions with vlfeat
frameTransA = compute_angle(gradTransAx, gradTransAy, TransAFiltered);
frameTransB = compute_angle(gradTransBx, gradTransBy, TransBFiltered);

% Shift to plot together
[rowsTrans, colsTrans] = size(transA);
frameTransB(1,:) = frameTransB(1,:) + colsTrans;
transFrame = [frameTransA, frameTransB];

% Plot gradients on image
transImage = [transAOrig, transBOrig];
% figure, imshow(transImage);
% hold on;
% vl_plotframe(transFrame);
% saveas(gcf, fullfile('output', 'ps5-2-a-1.png'))

% Repeat for Sim Image
frameSimA = compute_angle(gradSimAx, gradSimAy, SimAFiltered);
frameSimB = compute_angle(gradSimBx, gradSimBy, SimBFiltered);

% Shift to plot together
[rowsSim, colsSim] = size(simA);
frameSimB(1,:) = frameSimB(1,:) + colsSim;
simFrame = [frameSimA, frameSimB];

% Plot gradients on image
simImage = [simAOrig, simBOrig];
% figure, imshow(simImage);
% hold on;
% vl_plotframe(simFrame);
% saveas(gcf, fullfile('output', 'ps5-2-a-2.png'))

%% 2-b: Call SIFT functions to get descriptors
% Do the SIFT operation on Trans image
frameTransB = compute_angle(gradTransBx, gradTransBy, TransBFiltered);
[transAF_out, transAD_out] = vl_sift(single(transA), 'frames', frameTransA);
[transBF_out, transBD_out] = vl_sift(single(transB), 'frames', frameTransB);

% Do the matching between both images
transM = vl_ubcmatch(transAD_out, transBD_out);
ka1 = frameTransA(:, transM(1,:));
ka2 = frameTransB(:, transM(2,:));

% Call the function to draw lines between the points
% draw_matches(ka1, ka2, transAOrig, transBOrig, 'ps5-2-b-1.png');

% Repeat for the Sim image
% Do the SIFT operation on Sim image
frameSimB = compute_angle(gradSimBx, gradSimBy, SimBFiltered);
[simAF_out, simAD_out] = vl_sift(single(simA), 'frames', frameSimA);
[simBF_out, simBD_out] = vl_sift(single(simB), 'frames', frameSimB);

% Do the matching between both images
simM = vl_ubcmatch(simAD_out, simBD_out);
kb1 = frameSimA(:, simM(1,:));
kb2 = frameSimB(:, simM(2,:));

% Call the function to draw lines between the points
% draw_matches(kb1, kb2, simAOrig, simBOrig, 'ps5-2-b-2.png');

%% 3-a: RANSAC on translationally transformed image
% [shiftVector, consensusSet1] = ransacTrans(ka1, ka2, 20);
% draw_matches(consensusSet1(1:2,:), consensusSet1(3:4,:), transAOrig, transBOrig, 'ps5-3-a-1.png');

%% 3-b: RANSAC on similarity transformed image
[simMatrix, consensusSet2] = ransacSim(kb1, kb2, 25);
draw_matches(consensusSet2(1:2,:), consensusSet2(3:4,:), simAOrig, simBOrig, 'ps5-3-b-1.png');