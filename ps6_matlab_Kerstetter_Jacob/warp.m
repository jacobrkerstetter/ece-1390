function [warpedImg] = warp(img, u, v)
    % warp img according to flow field in u and v
    [M,N] = size(img);
    [x,y] = meshgrid(1:N,1:M);

    %use Matlab interpolation routine
    warpedImg2 = interp2(x, y, img, x+u, y+v, '*nearest');

    %use Matlab interpolation routine
    warpedImg = interp2(x, y, img, x+u, y+v, '*linear');

    % fix NAN results in warpedImg
    I = find(isnan(warpedImg)); 
    warpedImg(I) = warpedImg2(I);
end