function angleImage = compute_angle(gradX, gradY, R)

[rows, ~] = size(R);
angleImage = zeros(4, rows);

% loop over all pixels
for i = 1:rows
    x = R(i, 2);
    y = R(i, 1);

    angle = atan2(gradX(x, y), gradY(x, y));
    angleImage(:, i) = [y, x, 1, angle];
end

end