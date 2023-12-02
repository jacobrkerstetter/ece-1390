function [centers, radii] = find_circles(BW, radius_range)
    % Find circles in given radius range using Hough transform.
    %
    % BW: Binary (black and white) image containing edge pixels
    % radius_range: Range of circle radii [min max] to look for, in pixels

    % initialize overall accumulator
    [rows cols] = size(BW);
    H = zeros(rows, cols, range(radius_range));

    % call hough_circles_acc for each radius in radius_range
    for i = radius_range(1):radius_range(2)
        H_return = hough_circles_acc(BW, i);
        H(:, :, i) = H_return;
    end

    % get centers of the circles
    peaks = hough_peaks(H, 20);
    centers = peaks(:,1:2);
    radii = peaks(:,3);
end
