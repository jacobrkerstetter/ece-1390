function [bestM, results] = calibrate(pts2d, pts3d, k)

% variables for storing best of trial
n = size(pts2d, 1);
bestM = zeros(3, 4);
lowestResidual = Inf;
results = zeros(10, 1);

% repeat 10 times to find best M
for i = 1:10
    % choose k random points (+ 4 for residual checking)
    ptIndex = randperm(n, k + 4);
    in2d = zeros(k, 2);
    in3d = zeros(k, 3);

    for j = 1:k
        in2d(j, :) = pts2d(ptIndex(j), :);
        in3d(j, :) = pts3d(ptIndex(j), :);
    end

    % compute M with the points
    currM = least_squares(in2d, in3d);

    % pick 4 points and compute average residual
    avgResidual = 0;
    for j = 1:4
        curr3d = [transpose(pts3d(ptIndex(k + j), :)); 1]; % put the current point in homogeneous coords
        proj = currM * curr3d; % project the current point to 2d
        curr2d = [proj(1) / proj(3); proj(2) / proj(3)]; % put the projection into 2d coords

        avgResidual = avgResidual + sqrt((curr2d(1)-pts2d(ptIndex(k + j),1))^2 + (curr2d(2)-pts2d(ptIndex(k + j),2))^2);
    end
    avgResidual = avgResidual / 4;

    % keep M with lowest residual
    if avgResidual < lowestResidual
        bestM = currM;
        lowestResidual = avgResidual;
    end

    results(i) = avgResidual;
end
    
end