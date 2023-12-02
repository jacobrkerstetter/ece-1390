function [u, v, W_k] = hierarchical_lk(L, R, n, windowSize)

% set k to max level, n
k = n;

while k >= 0
    L_k = L;
    R_k = R;

    % reduce L and R to level k
    for i = 1:k
        L_k = reduce(L_k);
        R_k = reduce(R_k);
    end
    
    % if it is the first iteration, initialize zero arrays
    if k == n
        % initialize u and v
        u = zeros(size(L_k));
        v = zeros(size(L_k));
    % if it is not the first iteration, expand u and v
    else
        u = 2 * expand(u, L_k);
        v = 2 * expand(v, L_k);
    end

    % warp Lk using u, v to form Wk
    W_k = warp(R_k, u, v);

    % perform LK on W_k and R_k
    [Dx, Dy] = lk(L_k, W_k, windowSize);

    % add new displacements to original flow fields
    u = u + Dx;
    v = v + Dy;
    
    if k > 0
        % reduce k by 1 and loop
        k = k-1;
    else
        break
    end
end

end