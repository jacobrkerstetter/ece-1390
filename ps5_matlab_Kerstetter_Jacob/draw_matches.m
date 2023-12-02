function draw_matches(keyPointsA, keyPointsB, imgA, imgB, filename)

% shift points in imgB to be in right half of figure
[~, cols] = size(imgA);
keyPointsB(1,:) = keyPointsB(1,:) + cols;

imshow([imgA, imgB]);
hold on;

for i = 1:size(keyPointsA, 2)
    plot([keyPointsA(1,i),keyPointsB(1,i)],[keyPointsA(2,i),keyPointsB(2,i)],'LineWidth',1.5)
end

saveas(gcf, fullfile('output', filename))

end