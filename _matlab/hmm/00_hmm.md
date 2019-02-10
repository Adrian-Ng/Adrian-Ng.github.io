---
title: "MATLAB: Hidden Markov Models"
permalink: /matlab/hmm/
excerpt: "We can model things with _Markov Chains_. But sometimes we don't have access to the full information."
toc: true
mathjax: true
classes: wide
---

We can model things with _Markov Chains_. But sometimes we don't have access to the full information.

For instance, we observe the movements of a stock price. Price changes follow some trends of the economy, but we don't get to see the state of the economy, which is too big and complicated.


$$
\begin{matrix}
H_1 & \rightarrow & H_2 & \rightarrow & \cdots & \rightarrow & H_{T-1} & \rightarrow & H_T & \rightarrow
\\
\downarrow & & \downarrow & & & & \downarrow & & \downarrow 
\\
V_1 & & V_2 &  & \cdots &  & V_{T-1} & & V_T
\end{matrix}
$$

In a **Hidden Markov Model**, we have a first order stationary process $$H_1, H_2, \ldots$$
  * These can be in a finite number of spaces
  * These have transition probabilities
  
On top of this, there is a mechanism that produces variables $$V$$, which are observable - $$H$$ variables are _hidden_.

In other words, only $$V_T$$ is impacted by other variables through $$H_T$$

## Use cases of Hidden Markov Models

### Speech Recognition

Assuming a sound recording. We want to recover the text from the sounds. Now, text follows a Markov Chain very closely. 

Speech can be thought of as emissions from text. We can easily find the parameters of this Markov Chain


## Join Distribution

Here is a Hidden Markov Chain with:

* Hidden states $$s_1, s_2, s_3$$
* Transition probabilities $$p$$
* Emission probabilities $$b$$ (found from the emission matrix $$B$$)

$$
\begin{matrix}
\text{time} && 1 && 2 && 3 && 4
\\
    &&&& p_{3,1} &&&& p_{2,1}
\\
\text{hidden states} 

    & s_1 & \circ &&  \bullet && \circ && \bullet
\\
    &&&&& \searrow  & p_{1,2} & \nearrow
\\
    & s_2 & \circ & \nearrow & \circ && \bullet && \circ
\\
\\
    & s_3 & \bullet && \circ && \circ && \circ 
\\
\\
\text{emission probabilities}    && b_{3,2} && b_{1,2} && b_{2,1} && b_{1,3} 
\\
&& \Downarrow && \Downarrow && \Downarrow && \Downarrow
\\
\text{emission} && x_2 && x_2 && x_1 && x_3

\end{matrix}
$$



we calcuate the probability of join state as:

$$
\mathbb{P}(H_1 = s_3, H_2 = s_1, H_3 = s_2, H_4 = s_1, V_1 = x_2, V_2 = x_2, V_3 = x_1, V_4 = x_3) 
\\
= p_3^{\text{initial}} p_{3,1} p_{1,2} p_{2,1} p_{3,2} b_{1,2} b_{2,1} b_{1,3} 
$$

## Filtering

Filtering problems are about finding the final states of the HMM.

Suppose we have the following observations:

$$
v_1, v_2, \ldots, v_T
$$

We want to find the following probability for all states $$H_T = s_i$$:

$$
\mathbb{P}(H_T = s_i, v_1, \ldots, v_T)
$$

### Naive Approach

To do this, we just sum over all paths that end in $$H_T = s_i$$

But if there are $$N$$ states, then there are $$N^{T-1}$$ paths in the chain. So there is actually a better way of doing this.

## Alpha

We are interested in the probability alpha, which is:

$$
\alpha_T(i) = \mathbb{P}(H_T = s_i, v_1, \ldots, v_T)
$$


$$
\begin{matrix}
\text{time} & & \cdots && T-1 && T
\\
 &&&&&p_{i,j}  & \tiny \leftarrow \text{(transition probability)}
\\
\text{hidden states} 

     &&&&  \bullet & \searrow &&& 
\\

\\
     &&&& \bullet & \rightarrow & \bullet s_j
\\
\\
     &&&& \bullet & \nearrow &&& 
\\
\\
\text{emission} &&  \cdots && V_{T-1} && V_T

\end{matrix}
$$

Now for each alpha we need $$N$$ operations and there are $$NT$$ values of alpha - much better than $$N^{T-1}$$!

$$
\mathbb{P}(H_T = s_i, v_1,...,v_T) = \alpha_T = \mathbb{P}(V_t|s_j)\sum_{i=1}^N \alpha_{T-1}(i)p_{i,j}
$$


This sort of trick goes under the name of _dynamic programming_ (=optimisation).

### MATLAB Implementation


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

### Example

$$
M = \left( 
\begin{matrix}
    0.8 & 0.2 \\ 0.3 & 0.7
\end{matrix}
\right)

\quad 
B = \left(
\begin{matrix}
    0.3 & 0.4 & 0.1 & 0.2 \\ 0.2 & 0.2 & 0.3 & 0.3
\end{matrix}
\right)
\quad
p = \left(
    \begin{matrix}
    0.4 \\ 0.6
    \end{matrix}
    \right)
$$

Observations in the sequence:

$$ x_4, x_1, x_2 $$

### Output

$$
\begin{matrix}
& 1 & 2 & 3
\\
s_1 & 0.08 & 0.0354 & 0.0147
\\
s_2 & 0.18 & 0.0284 & 0.0054
\end{matrix}
$$