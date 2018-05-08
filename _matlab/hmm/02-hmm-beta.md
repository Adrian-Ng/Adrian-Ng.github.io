---
title: "MATLAB: Hidden Markov Models - Computing Beta"
permalink: /matlab/hmm/beta/
excerpt: "How to compute beta for Hidden Markov Models in MATLAB by Adrian Ng"
toc: true
mathjax: true
classes: wide
---

## Formula

$$
\mathbb{P}(v_{t+1},...,v_T|H_t = s_i) \beta_{t(i)} = \sum_{j=1}^N \beta_{t+1}(j)\cdot \mathbb(v_{t+1}|H_{t+1} = s_j)
$$

## Implementation

```
function b = beta_dynamic(M,p,B,v)
    
    [N, ~] = size(M);
    T = length(v);
    %create matrix of betas
    b = zeros(N, T);
    %initialize last column to 1
    b(:,end) = 1;
    %calculate betas right to left
    for t = T-1:-1:1
        for j = 1:N
            b(j,t) = sum(b(:,t+1) .* M(j,:)' .* B(:,v(t+1)));
        end
    end    
end
```
