function [simModel, consensusSet] = ransacSim(keyA, keyB, sigma)

simModel = zeros(3,3);
maxConsensus = 0;
consensusSet = [];

range = size(keyA, 2);
threshold = 4*sigma;

for N = 1:16
    % pick 1 pair of matched points
    randIndex = randperm(range, 2);
    
    % calculate similarity matrix (get p and p' sets)
    x1 = keyA(1, randIndex(1));
    y1 = keyA(2, randIndex(1));
    x2 = keyA(1, randIndex(2));
    y2 = keyA(2, randIndex(2));

    x_prime1 = keyB(1, randIndex(1));
    y_prime1 = keyB(2, randIndex(1));
    x_prime2 = keyB(1, randIndex(2));
    y_prime2 = keyB(2, randIndex(2));

    A = [x1, -y1, 1, 0;
        y1, x1, 0, 1;
        x2, -y2, 1, 0;
        y2, x2, 0, 1];
    b = [x_prime1; y_prime1; x_prime2; y_prime2];

    tform = estimateGeometricTransform2D([x1, y1; x2, y2], [x_prime1, y_prime1; x_prime2, y_prime2], 'similarity');
    tform = tform.T';
    tform = tform(1:2,:);
    
    % find out how many pairs agree with this (consensus set)
    consensus = 0;
    currConsensus = [];

    % loop over all other points
    for pt = 1:range
        % using the similarity matrix, calculate p_hat = s * p
        p_hat = tform * [keyA(1,pt); keyA(2,pt); 1];
        ptB = [keyB(1,pt); keyB(2,pt)];

        % calculate distance between p_hat and p' (keyB)
        d = sqrt((p_hat(1) - ptB(1))^2 + (p_hat(2) - ptB(2))^2);

        % is distance of p_hat to keyB < threshold? 
        if d < threshold
            % increase consensus count and add points to set
            consensus = consensus + 1;
            ptSet = [keyA(1,pt); keyA(2,pt); keyB(1,pt); keyB(2,pt)];
            currConsensus = [currConsensus, ptSet];
        end
    end

    % check if this is max consensus
    if consensus > maxConsensus
        maxConsensus = consensus;
        simModel = tform;
        consensusSet = currConsensus;
    end

end

end