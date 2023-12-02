function [im_out] = segment_kmeans(im_in, K, iters, R)
    % convert image to double
    double_im = im2double(im_in);

    % resize image
    img_small = imresize(double_im, [100 100]);

    % reshape in
    img_reshape = reshape(img_small, 100*100, 3);

    % cluster the images
    [ids, means, ssd] = kmeans_multiple(img_reshape, K, iters, R);

    % recolor the output
    % for each pixel, replace with mean of cluster
    for i = 1:100*100
        img_reshape(i, 1) = means(ids(i), 1);
        img_reshape(i, 2) = means(ids(i), 2);
        img_reshape(i, 3) = means(ids(i), 3);
    end
    
    im_out = reshape(img_reshape, [100, 100, 3]);
end