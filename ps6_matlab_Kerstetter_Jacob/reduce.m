function imgOut = reduce(imgIn)

% define kernels
kernel = (1/16) * [1, 4, 6, 4, 1];
kernel_2d = kernel' * kernel;

filterIm = imfilter(imgIn, kernel_2d);
imgOut = imgaussfilt(filterIm(1:2:end, 1:2:end), 2);

end