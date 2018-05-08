---
title: "MATLAB: Hidden Markov Models - Computing Gamma"
permalink: /matlab/hmm/gamma/
excerpt: "How to compute gamma for Hidden Markov Models in MATLAB by Adrian Ng"
toc: true
mathjax: true
classes: wide
---

## Formula

$$
\mathbb{P}(H_t=s_i|v_1,...v_T) = \frac{a_t(i)\beta_i(t)}{\sum_{j=1}^N a_t(j)\beta_t(j)}
$$

## Implementation

```
function g = gamma_dynamic(alpha,beta) 
    %return alphas and betas
        a = alpha;
        b = beta;    
    %calculate denominator
    %sum over j (the different states)
        den = sum(a.*b,1);
    %populate matrix of gammas
        g = a.*b./den;   
end
```
