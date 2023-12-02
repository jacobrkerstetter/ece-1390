function H = hough_circles_acc(BW, radius)
    % Compute Hough accumulator array for finding circles.
    %
    % BW: Binary (black and white) image containing edge pixels
    % radius: Radius of circles to look for, in pixels

    % create array H (2D)
    H = zeros(size(BW));
    [rows, cols] = size(BW);
       
    % begin algorithm
    for row = 1:rows      % for each row
        for col = 1:cols  % for each col (covering all pixels in image)
            if BW(row, col) == 1    % if the pixel is an edge pixel
                for theta = 1:360   % for each theta degree
                    a = col - round(radius * cosd(theta));
                    b = row - round(radius * sind(theta));
                    if a > 0 && a <= rows && b > 0 && b <= cols
                        H(a, b) = H(a, b) + 1;
                    end
                end
            end
        end
    end
end
