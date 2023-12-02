% Jacob Kerstetter
% 4406239
% PS4 - ECE1390

clear
clc

%% 1-a
% read in the points from pts2d-norm-pic_a.txt and pts3d-norm.txt
pts2d = load(fullfile('input', 'pts2d-norm-pic_a.txt'));
pts3d = load(fullfile('input', 'pts3d-norm.txt'));

% call least squares function
M = least_squares(pts2d, pts3d);

% do the projection of the first and last points
ptFirst = [transpose(pts3d(1, :)); 1];
ptLast = [transpose(pts3d(end, :)); 1];

proj1 = M * ptFirst;
proj2 = M * ptLast;

pt2d1 = [proj1(1) / proj1(3); proj1(2) / proj1(3)];
pt2d2 = [proj2(1) / proj2(3); proj2(2) / proj2(3)];

% calculate the residual for each point
residualPt1 = sqrt((pt2d1(1)-pts2d(1,1))^2 + (pt2d1(2)-pts2d(1,2))^2);
residualPt2 = sqrt((pt2d2(1)-pts2d(end,1))^2 + (pt2d2(2)-pts2d(end,2))^2);

%% 1-b
pts2d = load(fullfile('input', 'pts2d-pic_b.txt'));
pts3d = load(fullfile('input', 'pts3d.txt'));

% matrix to hold avg residual values
avgResiduals = zeros(10, 3);

% call calibration function to get best M, store results of k

[M8, avgResiduals(:, 1)] = calibrate(pts2d, pts3d, 8);
[M12, avgResiduals(:, 2)] = calibrate(pts2d, pts3d, 12);
[M16, avgResiduals(:, 3)] = calibrate(pts2d, pts3d, 16);

%% 1-c
% using M16, calculate the camera center in the world 
% define M as [Q | m4]
Q = M16(:, 1:3);
m4 = M16(:, end);

% calculate center using C = -inv(Q) * m4
C = -inv(Q) * m4;

%% 2-a
% call the fundamental matrix function to return f for pts2d-pic_a/b
ptSet1 = load(fullfile('input', 'pts2d-pic_a.txt'));
ptSet2 = load(fullfile('input', 'pts2d-pic_b.txt'));

F = least_squares_fundamental(ptSet1, ptSet2);

%% 2-b
% we must force F to rank 2
% decompose F
[U, D, V] = svd(F);

% force last element of D to 0 and recompute F
D(end, end) = 0;
F_rank2 = U * D * V';

%% 2-c
% load image b
imgB = imread(fullfile('input', 'pic_b.jpg'));
[rows, cols, dim] = size(imgB);

% get points for corners of the image
ptUL = [1; 1; 1];
ptBL = [1; rows; 1];
ptUR = [cols; 1; 1];
ptBR = [cols; rows; 1];

% create lines for left and right of image
leftLine = cross(ptUL, ptBL);
rightLine = cross(ptUR, ptBR);

% plot image and line on it as we calculate them
figure, imshow(imgB)
hold on

% for each pt in image a, compute line on b
n = size(ptSet1, 1);
for i = 1:n
    % calculate line in b
    homoPt = [transpose(ptSet1(i,:)); 1];
    lb = transpose(F_rank2) * homoPt;

    % calculate intersection with left and right lines
    iLeft = cross(lb, leftLine);
    iRight = cross(lb, rightLine);

    % convert these points to 2d coords
    leftPt = [iLeft(1)/iLeft(3), iLeft(2)/iLeft(3)];
    rightPt = [iRight(1)/iRight(3), iRight(2)/iRight(3)];

    % plot line using the two intersections
    plot([leftPt(1),rightPt(1)],[leftPt(2),rightPt(2)],'Color','b','LineWidth',1)
end

% save figure
saveas(gcf, fullfile('output', 'ps4-2-c-2.png'));

% load image A
imgA = imread(fullfile('input', 'pic_a.jpg'));

% plot image and line on it as we calculate them
figure, imshow(imgA)
hold on

% for each pt in image a, compute line on b
n = size(ptSet2, 1);
for i = 1:n
    % calculate line in b
    homoPt = [transpose(ptSet2(i,:)); 1];
    lb = F_rank2 * homoPt;

    % calculate intersection with left and right lines
    iLeft = cross(lb, leftLine);
    iRight = cross(lb, rightLine);

    % convert these points to 2d coords
    leftPt = [iLeft(1)/iLeft(3), iLeft(2)/iLeft(3)];
    rightPt = [iRight(1)/iRight(3), iRight(2)/iRight(3)];

    % plot line using the two intersections
    plot([leftPt(1),rightPt(1)],[leftPt(2),rightPt(2)],'Color','b','LineWidth',1)
end

% save figure
saveas(gcf, fullfile('output', 'ps4-2-c-1.png'));