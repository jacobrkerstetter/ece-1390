function [shiftModel, consensusSet] = ransacTrans(keyA, keyB, sigma)

shiftModel = [0; 0];
maxConsensus = 0;
consensusSet = [];

range = size(keyA, 2);
threshold = 4*sigma;

for N = 1:7
    % pick 1 pair of matched points
    randIndex = randi(range);
    
    % calculate shift vector
    shiftVector = [keyB(1,randIndex) - keyA(1,randIndex); keyB(2,randIndex) - keyA(2,randIndex)];
    
    % find out how many pairs agree with this (consensus set)
    consensus = 0;
    currConsensus = [];

    % loop over all other points
    for pt = 1:range
        % using the shift vector, calculate p_hat = keyA + shift
        p_hat = [keyA(1,pt) + shiftVector(1); keyA(2,pt) + shiftVector(2)];
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
        shiftModel = shiftVector;
        consensusSet = currConsensus;
    end

end

end