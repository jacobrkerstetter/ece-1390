function corners = filter_corners(R, threshold, suppressionRadius)

% get size of image
[rows, cols] = size(R);

% loop over the whole image and threshold
for i = 1:rows
    for j = 1:cols
        if R(i, j) < threshold
            R(i, j) = 0;
        end
    end
end

% loop over the whole image and do non-maximal suppression
offset = floor(suppressionRadius/2);
for i = 1+offset:suppressionRadius:rows-offset
    for j = 1+offset:suppressionRadius:cols-offset
        % create window and find max
        window = R(i-offset:i+offset, j-offset:j+offset);
        maxVal = max(max(window));
        
        % if array is all zeros, skip
        isEmpty = (sum(sum(window)) == 0);
        if isEmpty
            continue;
        end
        
        % find location of max
        [rowLoc, colLoc] = find(window == maxVal);

        % if there are more than one of the same value in a window, use 1
        if size(rowLoc, 1) > 1
            rowLoc(2:end) = [];
            colLoc(2:end) = [];
        end

        % zero anything that is not max of window
        for offsetRow = -offset:offset
            for offsetCol = -offset:offset
                if offsetRow+offset+1 ~= rowLoc || offsetCol+offset+1 ~= colLoc
                    R(i+offsetRow, j+offsetCol) = 0;
                end
            end
        end
    end
end

[cornersY, cornersX] = find(R);
corners = [cornersX, cornersY];

end