function imgOut = expand(imgIn, imgTemplate)

% define kernels
kernel = [1/8, 1/2, 3/4, 1/2, 1/8];
kernel_2d = kernel' * kernel;

% define imgOut as bigger image size with zeros in every other row/col
[rows, cols] = size(imgIn);
imgOut = zeros(2*rows, 2*cols);
imgOut(1:2:end, 1:2:end) = imgIn;

% convolve with kernel_2d to get expanded image
imgOut = imfilter(imgOut, kernel_2d);

% if the template image has odd numbers of rows/cols, add 1
[tempRows, tempCols] = size(imgTemplate);
if tempRows ~= 2*rows
    imgOut = imgOut(1:end-1, :);
end
if tempCols ~= 2*cols
    imgOut = imgOut(:, 1:end-1);
end

end