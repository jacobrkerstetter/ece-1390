function [ids, means, ssd] = kmeans_single(X, K, iters)
    % compute range of feature space and get centers in this range
    [rows, cols] = size(X);

    % gets range of R, G, B respectively
    ranges = zeros(cols, 2);
    for i = 1:cols
        ranges(i,:) = [max(X(:,i)), min(X(:,i))];
    end

    % centers is a 3D array with each row holding an n dimension center
    centers = zeros(K, cols);
    for i = 1:K
         for j = 1:cols
            a = ranges(j,1);
            b = ranges(j,2);
            centers(i, j) = (b-a)*rand(1) + a;
         end
    end

    % iterate over the steps of the algorithm
    ids = zeros(1, rows);
    for iter = 1:iters
        % compute memberships for each data point
        for i = 1:rows
            shortestDistance = intmax;
            index = 0;
            for j = 1:K
                % if the distance from the current point to the center is
                % shorter than the current shortest distance, make it the
                % shortest distance and store the index
                currDist = pdist2(X(i), centers(j));
                if currDist < shortestDistance 
                    shortestDistance = currDist;
                    index = j;
                end
            end
            % set the point to the cluster of the shortest distance center
            ids(i) = index;
        end
   
        % recompute cluster means (centers)
        % for every point and dimension, add to corresponding id total sum 
        % and increment count

        sums = zeros(K, cols);
        counts = zeros(K, cols);
        ssd = 0;
        for i = 1:rows % for every point
            for id = 1:K % for every cluster
                % check id
                if ids(i) == id
                    for j = 1:cols % for every feature dimension
                        sums(id, j) = sums(id, j) + X(i, j);
                        counts(id, j) = counts(id, j) + 1;
                    end
                end
            end
        end

        % compute means and reassign centers
        centers = sums ./ counts; 
    end

    % assign the final centers to the means return variable
    means = centers;

    % calculate ssd
    ssd = 0;
    for i = 1:rows % for every point
        for id = 1:K % for every cluster
            % check id
            if ids(i) == id
                for j = 1:cols % for every feature dimension
                    ssd = ssd + (X(i, j) - means(K, j))^2;
                end
            end
        end
    end
end