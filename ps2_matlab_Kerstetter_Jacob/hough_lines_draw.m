function hough_lines_draw(img, outfile, peaks, rho, theta)
    % Draw lines found in an image using Hough transform.
    %
    % img: Image on top of which to draw lines
    % outfile: Output image filename to save plot as
    % peaks: Qx2 matrix containing row, column indices of the Q peaks found in accumulator
    % rho: Vector of rho values, in pixels
    % theta: Vector of theta values, in degrees

    % display the image in the background
    figure, imshow(img)
    hold on

    r = rho(peaks(:, 1));
    a = cosd(theta(peaks(:, 2)));
    b = sind(theta(peaks(:, 2)));

    x = r .* a;
    y = r .* b;

    for i = 1:size(peaks, 1)
        plot([x(i) + 1000*(-b(i)), x(i) - 1000*(-b(i))], [y(i) + 1000*(a(i)), y(i) - 1000*(a(i))], 'Color', 'g', 'LineWidth', 2)
    end
    
    imwrite(getframe(gcf).cdata, fullfile('output', outfile))
end
