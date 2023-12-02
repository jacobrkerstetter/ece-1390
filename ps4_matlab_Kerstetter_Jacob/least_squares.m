function M = least_squares(pts2d, pts3d)

% define A, B, M
n = size(pts2d, 1);

% A = 2n x 12 = 2(20) x 12 = 40 x 12
% M = 12 x 1
% B = 2n x 1 = 2(20) x 1 = 40 x 1
A = zeros(2*n, 12);
M = zeros(12, 1);
B = zeros(2*n, 1);

% loop and every 2 rows fill in A appropriately
i = 1;
while i <= 2*n
    % set index of points
    index = ceil(i/2);

    % if it is first of the 2 row "block"
    if mod(i, 2) == 1
        A(i, :) = [pts3d(index, 1), pts3d(index, 2), pts3d(index, 3), 1, 0, 0, 0, 0, -pts2d(index, 1)*pts3d(index, 1), -pts2d(index, 1)*pts3d(index, 2), -pts2d(index, 1)*pts3d(index, 3), -pts2d(index, 1)];
    % if it is the second of the 2 row "block"
    else
        A(i, :) = [0, 0, 0, 0, pts3d(index, 1), pts3d(index, 2), pts3d(index, 3), 1, -pts2d(index, 2)*pts3d(index, 1), -pts2d(index, 2)*pts3d(index, 2), -pts2d(index, 2)*pts3d(index, 3), -pts2d(index, 2)];
    end
    
    % increment i
    i = i + 1;
end

[U, D, V] = svd(A);
f = V(:, end);

M = transpose(reshape(f, [4, 3]));

end