function [gradX, gradY] = compute_gradient(img)

[gradX, gradY] = imgradientxy(img);

end