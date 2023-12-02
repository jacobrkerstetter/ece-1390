function [u, v] = lk(img1, img2, windowSize)

[rows, cols] = size(img1);
offset = floor(windowSize / 2);

% create templates for u and v
u = zeros(rows, cols);
v = zeros(rows, cols);

% calculate gradients
Ix = imfilter(img1, [-1, 1]);
Iy = imfilter(img1, [-1; 1]);
Ix_sq = Ix .^ 2;
Iy_sq = Iy .^ 2;
IxIy = Ix .* Iy;

It = img2 - img1;
IxIt = Ix .* It;
IyIt = Iy .* It;

% loop over all pixels
for i = 1+offset:rows-offset
    for j = 1+offset:cols-offset
        % create M and v matrices for given window size
        M = [sum(sum(Ix_sq(i-offset:i+offset, j-offset:j+offset))), sum(sum(IxIy(i-offset:i+offset, j-offset:j+offset)));
             sum(sum(IxIy(i-offset:i+offset, j-offset:j+offset))), sum(sum(Iy_sq(i-offset:i+offset, j-offset:j+offset)))];
        v_vec = [-sum(sum(IxIt(i-offset:i+offset, j-offset:j+offset))); -sum(sum(IyIt(i-offset:i+offset, j-offset:j+offset)))];

        % assign values of d to u and v matrices
        d = pinv(M) * v_vec;
        u(i, j) = d(1);
        v(i, j) = d(2);
    end
end

end