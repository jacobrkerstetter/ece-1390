function peaks = hough_peaks(H, varargin)
    % Find peaks in a Hough accumulator array.
    %
    % Threshold (optional): Threshold at which values of H are considered to be peaks
    % NHoodSize (optional): Size of the suppression neighborhood, [M N]
    %
    % Please see the Matlab documentation for houghpeaks():
    % http://www.mathworks.com/help/images/ref/houghpeaks.html
    % Your code should imitate the matlab implementation.

    %% Parse input arguments
    p = inputParser;
    addOptional(p, 'numpeaks', 1, @isnumeric);
    addParameter(p, 'Threshold', 0.5 * max(H(:)));
    addParameter(p, 'NHoodSize', floor(size(H) / 100.0) * 2 + 1);  % odd values >= size(H)/50
    parse(p, varargin{:});

    numpeaks = p.Results.numpeaks;
    threshold = p.Results.Threshold;
    nHoodSize = p.Results.NHoodSize;

    % get top numpeaks and indices
    maxima = maxk(H(:), numpeaks);
    H_copy = H;
    peaks = zeros(numpeaks, ndims(H));

    for i = 1:numpeaks
        if maxima(i) >= threshold
            k = find(H_copy == maxima(i), 1);
            if size(k) > 0
                if ndims(H) > 2
                    c = find(H_copy == maxima(i), 1);
                    [peaks(i, 1), peaks(i, 2), peaks(i, 3)] = ind2sub(size(H), c);
                else
                    [peaks(i, 1), peaks(i, 2)] = find(H_copy == maxima(i), 1);
                    H_copy(max(-nHoodSize+peaks(i,1), 1):min(nHoodSize+peaks(i,1), size(H,1)), max(-nHoodSize+peaks(i,2), 1):min(nHoodSize+peaks(i,2), size(H,2))) = 0;
                end
            end
        end
    end
end
