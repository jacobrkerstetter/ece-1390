function D = disparity_ncorr(L, R)
% Compute disparity map D(y, x) such that: L(y, x) = R(y, x + D(y, x))
%
% L: Grayscale left image
% R: Grayscale right image, same size as L
% D: Output disparity map, same size as L, R

[rows, cols] = size(L);
D = zeros(size(L));
tplSize = 9;

% for each pixel in the left image
for row = 1:rows
    for col = 1:cols
        shift = floor(tplSize/2);

        % ignore rows and cols that will go out of bounds
        if row-shift < 1 || col-shift < 1 || row+shift > rows || col+shift > cols
            continue
        end

        % set up template window on left image
        LPix = L(row-shift:row+shift, col-shift:col+shift);

        % create right window
        RPix = R(row-shift:row+shift, :);

        % set variables for tracking ssd
        norm = normxcorr2(LPix, RPix);
        maxCorr = max(max(norm));
        [temp, bestX] = find(norm == maxCorr);

        % assign disparity to D
        D(row, col) = bestX - col;
    end
end
end
