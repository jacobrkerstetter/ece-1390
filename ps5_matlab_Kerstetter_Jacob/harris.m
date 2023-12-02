function R = harris(gradX, gradY, windowSize)

% size of image
[rows, cols] = size(gradX);

% define window and M
offset = floor(windowSize/2);
R = zeros(rows, cols);

% set derivatives
IxSq = gradX .* gradX;
IySq = gradY .* gradY;
IxIy = gradX .* gradY;

% compute M
% loop over all pixels
for i = 1+offset:rows-offset
    for j = 1+offset:cols-offset
        % set up window
        IxSqSum = sum(sum(IxSq(i-offset:i+offset,j-offset:j+offset)));
        IxIySum = sum(sum(IxIy(i-offset:i+offset,j-offset:j+offset)));
        IySqSum = sum(sum(IySq(i-offset:i+offset,j-offset:j+offset)));

        % compute M and R for this point
        M = [IxSqSum, IxIySum; IxIySum, IySqSum];
        R(i,j) = det(M) - 0.04*(trace(M)^2);
    end
end

end