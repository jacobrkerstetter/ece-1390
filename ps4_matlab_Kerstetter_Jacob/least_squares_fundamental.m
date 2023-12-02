function F = least_squares_fundamental(pts1, pts2)

% define A, B, F
n = size(pts1, 1);

% A = n x 9
% M = 9 x 1
% B = n x 1
A = zeros(n, 9);
M = zeros(9, 1);
B = zeros(n, 1);

% loop and fill in A appropriately
for i = 1:n
    A(i, :) = [pts2(i,1)*pts1(i,1), pts2(i,1)*pts1(i,2), pts2(i,1), pts2(i,2)*pts1(i,1), pts2(i,2)*pts1(i,2), pts2(i,2), pts1(i,1), pts1(i,2), 1];
end

[U, D, V] = svd(A);
f = V(:, end);

F = reshape(f, [3, 3]);

end