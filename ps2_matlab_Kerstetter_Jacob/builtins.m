clear
clc

%% Load image
img = imread(fullfile('input', 'ps2-input0.png'));
edges = edge(img, 'canny' ) ;

%% Apply Hough transform
[accum theta rho] = hough(edges);
maxAccum = max(accum);
figure, imagesc(accum, 'XData', theta, 'YData', rho), title('Hough Accum');

peaks = houghpeaks(accum, 10); 
figure(2)
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'rs');
