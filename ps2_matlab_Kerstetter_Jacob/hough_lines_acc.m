function [H, theta, rho] = hough_lines_acc(BW, varargin)
    % Compute Hough accumulator array for finding lines.
    %
    % BW: Binary (black and white) image containing edge pixels
    % RhoResolution (optional): Difference between successive rho values, in pixels
    % Theta (optional): Vector of theta values to use, in degrees
    %
    % Please see the Matlab documentation for hough():
    % http://www.mathworks.com/help/images/ref/hough.html
    % Your code should imitate the Matlab implementation.
    %
    % Pay close attention to the coordinate system specified in the assignment.
    % Note: Rows of H should correspond to values of rho, columns those of theta.

    %% Parse input arguments
    p = inputParser();
    addParameter(p, 'RhoResolution', 1);
    addParameter(p, 'Theta', linspace(-90, 89, 180));
    parse(p, varargin{:});

    rhoStep = p.Results.RhoResolution;
    theta = p.Results.Theta;

    %% Hough Accumulator Algorithm
    % initialize H to all zeros (no votes) w/ rho rows and theta cols
    [rows, cols] = size(BW);
    diagonal = round(sqrt(rows^2 + cols^2));
    H = zeros(round(diagonal*(1/rhoStep))*2-1, size(theta, 2));

    % create partition for rho
    rho = -diagonal:rhoStep:diagonal;
    Q = (max(theta) - min(theta)) / size(theta, 2);

    % for each edge point in image
    for r = 1:rows % loop over rows 
        for c = 1:cols % loop over cols
            if BW(r, c) == 1 % if pixel is an edge pixel
                for degree = 1:size(theta, 2) % for each degree of theta
                    d = (c*cosd(theta(degree))) + (r*sind(theta(degree)));
                    rhoIndex = quantiz(d, rho);
                    H(rhoIndex, degree) = H(rhoIndex, degree) + 1;
                end
            end
        end
    end
end
