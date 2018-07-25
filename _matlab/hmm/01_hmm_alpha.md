---
title: "MATLAB: Hidden Markov Models - Computing Alpha"
permalink: /matlab/hmm/alpha/
excerpt: "How to compute alpha for Hidden Markov Models in MATLAB by Adrian Ng"
toc: true
mathjax: true
classes: wide
---

## Formula

$$
\mathbb{P}(H_T = s_i, v_1,...,v_T) = \alpha_T = \mathbb{P}(V_t|s_j)\sum_{i=1}^N \alpha_{T-1}(i)p_{i,j}
$$

## Implementation


```matlab
function a = alpha_dynamic(M,p,B,v)
% ALPHA DYNAMIC(M,p,B,v) calculates the matrix of alpha's the
% hmm with transition matrix M, emission matrix B, and initial
% probabilities p, given the observations v

    [np, ~]     = size(p);
    [N, ~]      = size(M);
    T           = length(v);
    %initialise alphas
    a           = zeros(N,T);
    % making sure p is a column
    if np == 1
        p = p'; 
    end
    % alpha 1 from initial probability
    a(:,1) = p.*B(:,v(1));
    %subsequent alphas
    for t = 2:T
        a(:,t) = M' * a(:,t-1) .* B(:,v(t));
    end
end
```

