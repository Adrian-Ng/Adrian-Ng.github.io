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

In a **Hidden Markov Model**, we have a first order stationary process $H_1, H_2, \ldots$
  * These can be in a finite number of spaces
  * These have transition probabilities
  
On top of this, there is a mechanism that produces variables $V$, which are observable - $H$ variables are _hidden_.

In other words, only $V_T$ is impacted by other variables through $H_T$

## Use cases of Hidden Markov Models

### Speech Recognition

Assuming a sound recording. We want to recover the text from the sounds. Now, text follows a Markov Chain very closely. 

Speech can be thought of as emissions from text. We can easily find the parameters of this Markov Chain


## Join Distribution

Here is a Hidden Markov Chain with:

* Hidden states $s_1, s_2, s_3$
* Transition probabilities $p$
* Emission probabilities $b$ (found from the emission matrix $B$)

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
\mathbb{P}(H_1 = s_3, H_2 = s_1, H_3 = s_2, H_4 = s_1, V_1 = x_2, V_2 = x_2, V_3 = x_1, V_4 = x_3) = p_3^{\text{initial}} p_{3,1} p_{1,2} p_{2,1} p_{3,2} b_{1,2} b_{2,1} b_{1,3} 
$$

### What questions can we ask?

