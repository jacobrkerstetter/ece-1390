ps2
Jacob Kerstetter - 4406239

clear
clc

%% 1-a
img = imread(fullfile('input', 'ps2-input0.png'));  % already grayscale
img_edges = edge(img, 'canny');

imwrite(img_edges, fullfile('output', 'ps2-1-a-1.png'));  % save as output/ps1-1-a-1.png

%% 2-a
[H, theta, rho] = hough_lines_acc(img_edges);  % defined in hough_lines_acc.m
%% Plot/show accumulator array H, save as output/ps1-2-a-1.png
H_img = im2uint8(H ./ max(H, [], 'all'));
imwrite(H_img, fullfile('output', 'ps2-2-a-1.png'));

%% 2-b
peaks = hough_peaks(H, 10);  % defined in hough_peaks.m

%% Highlight peak locations on accumulator array, save as output/ps2-2-b-1.png
peaks = peaks(any(peaks,2), any(peaks,1));
figure, imshow(H_img)
hold on
plot(peaks(:,2), peaks(:,1), 'rs')
imwrite(getframe(gcf).cdata, fullfile('output', 'ps2-2-b-1.png'))

%% Call line drawing function
hough_lines_draw(img, 'ps2-2-c-1.png', peaks, rho, theta);

%% 3-a
img_noise = imread(fullfile('input', 'ps2-input0-noise.png'));  % already grayscale
img_smoothed = imgaussfilt(img_noise, 5);
imwrite(img_smoothed, fullfile('output', 'ps2-3-a-1.png'));

%% 3-b
edges_noise = edge(img_smoothed, 'canny');
imwrite(img_edges, fullfile('output', 'ps2-3-b-1.png'))
imwrite(edges_noise, fullfile('output', 'ps2-3-b-2.png'))

%% 3-c
[H_noise, theta_noise, rho_noise] = hough_lines_acc(edges_noise, 'RhoResolution', 1, 'Theta', linspace(-90, 89, 180));  % defined in hough_lines_acc.m
peaks_noise = hough_peaks(H_noise, 10, 'Threshold', 70);  % defined in hough_peaks.m
peaks_noise = peaks_noise(any(peaks_noise,2), any(peaks_noise,1));

% Plot/show accumulator array H, save as output/ps2-3-c-1.png
H_img_noise = im2uint8(H_noise ./ max(H_noise, [], 'all'));
figure, imshow(H_img_noise)
hold on
plot(peaks_noise(:,2), peaks_noise(:,1), 'rs')
imwrite(getframe(gcf).cdata, fullfile('output', 'ps2-3-c-1.png'))

% Call line drawing function on smoothed image
hough_lines_draw(img_noise, 'ps2-3-c-2.png', peaks_noise, rho_noise, theta_noise);

%% 4-a
img2 = imread(fullfile('input', 'ps2-input1.png'));
img2_grayscale = rgb2gray(img2);
img2_filtered = imgaussfilt(img2_grayscale, 5);
imwrite(img2_filtered, fullfile('output', 'ps2-4-a-1.png'));

%% 4-b
edges_img2 = edge(img2_filtered, 'canny');
imwrite(edges_img2, fullfile('output', 'ps2-4-b-1.png'));

%% 4-c
[H2, T2, R2] = hough_lines_acc(edges_img2);  % defined in hough_lines_acc.m
P2 = hough_peaks(H2, 10, 'NHoodSize', [7 7], 'Threshold', .7*max(H2));  % defined in hough_peaks.m
P2 = P2(any(P2,2), any(P2,1));

% Plot/show accumulator array H, save as output/ps2-3-c-1.png
H2_img = im2uint8(H2 ./ max(H2, [], 'all'));
figure, imshow(H2_img)
hold on
plot(P2(:,2), P2(:,1), 'rs')
imwrite(getframe(gcf).cdata, fullfile('output', 'ps2-4-c-1.png'))

% Call line drawing function on smoothed image
hough_lines_draw(img2_grayscale, 'ps2-4-c-2.png', P2, R2, T2);

% 5-a
% save smoothed image and edge image
imwrite(img2_filtered, fullfile('output', 'ps2-5-a-1.png'));
imwrite(edges_img2, fullfile('output', 'ps2-5-a-2.png'));

% create accumulator array 
H_circles = hough_circles_acc(edges_img2, 20);

% find peaks
centers = hough_peaks(H_circles, 10);
centers = centers(any(centers,2), any(centers,1));

% draw circles on image
figure, imshow(img2_grayscale)
hold on
th = 0:pi/50:2*pi;
for i = 1:size(centers,1)
    xunit = 20 * cos(th) + centers(i,1);
    yunit = 20 * sin(th) + centers(i,2);
    h = plot(xunit, yunit, 'LineWidth', 2);
end
hold off

% save image
imwrite(getframe(gcf).cdata, fullfile('output', 'ps2-5-a-3.png'))

%% 5-b
% call find_circles for radius range
[centers, radii] = find_circles(edges_img2, [20 50]);

% draw circles on image
figure, imshow(img2_grayscale)
hold on
th = 0:pi/50:2*pi;
for i = 1:size(centers,1)
    xunit = radii(i) * cos(th) + centers(i,1);
    yunit = radii(i) * sin(th) + centers(i,2);
    h = plot(xunit, yunit, 'LineWidth', 2);
end

imwrite(getframe(gcf).cdata, fullfile('output', 'ps2-5-b-1.png'))


%% 6-a
% load image 3 and smooth
img3 = imread(fullfile('input', 'ps2-input2.png'));
img3_grayscale = img3(:,:,3);
img3_smoothed = imgaussfilt(img3_grayscale, 5);

% find edges
img3_edges = edge(img3_smoothed, 'canny');

%find lines and draw them
[H3, T3, R3] = hough_lines_acc(img3_edges);

peaks3 = hough_peaks(H3, 10, 'NHoodSize', [7 7]);
peaks3 = peaks3(any(peaks3,2), any(peaks3,1));

hough_lines_draw(img3_smoothed, 'ps2-6-a-1.png', peaks3, R3, T3);

%% 6-c
% load image 3 and smooth
img3 = imread(fullfile('input', 'ps2-input2.png'));
img3_grayscale = img3(:,:,3);
img3_smoothed = imgaussfilt(img3_grayscale, 5);

% find edges
img3_edges = edge(img3_smoothed, 'canny', [0.4 0.5]);
%imshow(img3_edges)

%find lines and draw them
[H3, T3, R3] = hough_lines_acc(img3_edges);

peaks3 = hough_peaks(H3, 10, 'NHoodSize', [9 9], 'Threshold', 100);
peaks3 = peaks3(any(peaks3,2), any(peaks3,1));

% if there is another line with the same theta value, keep, else discard
for i = 1:size(peaks3, 1)
    parallel = false;
    for j = 1:size(peaks3, 1)
        if i == j
            continue
        elseif peaks3(j,2) == peaks3(i,2)
            parallel = true;
        end
    end

    if not(parallel)
        peaks3(i,:) = [0 0];
    end
end

peaks3 = peaks3(any(peaks3,2), any(peaks3,1));
hough_lines_draw(img3_smoothed, 'ps2-6-c-1.png', peaks3, R3, T3);

%% 7-a
% load image 3 and smooth
img3 = imread(fullfile('input', 'ps2-input2.png'));
img3_grayscale = img3(:,:,3);
img3_smoothed = imgaussfilt(img3_grayscale, 5);

% find edges
img3_edges = edge(img3_smoothed, 'canny');

% find circle and draw them
[centers, radii] = find_circles(img3_edges, [30 70]);

% draw circles on image
figure, imshow(img3_smoothed)
hold on
th = 0:pi/50:2*pi;
for i = 1:size(centers,1)
    xunit = radii(i) * cos(th) + centers(i,1);
    yunit = radii(i) * sin(th) + centers(i,2);
    h = plot(xunit, yunit, 'LineWidth', 2);
end

imwrite(getframe(gcf).cdata, fullfile('output', 'ps2-7-a-1.png'))

% 8-a
img4 = imread(fullfile('input', 'ps2-input3.png'));
img4_grayscale = rgb2gray(img4);
img4_smoothed = imgaussfilt(img4_grayscale, 3);
img4_edges = edge(img4_smoothed, 'canny');

apply line and circle finders
[H_lines T4 R4] = hough_lines_acc(img4_edges);
[centers radii] = find_circles(img4_edges, [20 50]);

find peaks and draw lines
peaks4 = hough_peaks(H_lines, 20, 'Threshold', 100, 'NHoodSize', [15 15]);
peaks4 = peaks4(any(peaks4,2), any(peaks4,1));
hough_lines_draw(img4_smoothed, 'ps2-8-a-1.png', peaks4, R4, T4);

draw circles
circle_background = imread(fullfile('output', 'ps2-8-a-1.png'));

figure, imshow(circle_background)
hold on
th = 0:pi/50:2*pi;
for i = 1:size(centers,1)
    xunit = radii(i) * cos(th) + centers(i,1);
    yunit = radii(i) * sin(th) + centers(i,2);
    h = plot(xunit, yunit, 'LineWidth', 2);
end

imwrite(getframe(gcf).cdata, fullfile('output', 'ps2-8-a-1.png'))