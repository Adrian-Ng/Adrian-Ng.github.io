---
title: "k Nearest Neighbours: Theory"
permalink: /R/knn/theory/
toc: true
classes: wide
mathjax: true
---

## Intro

Nearest Neighbour algorithms can be used for __classification__ and __regression__.

Suppose we have the following training set:

$$(x_1,y_1),(x_2,y_2),...,(x_n,y_n)$$

We need to predict the _label_ for a test object $$(x,y)$$.

The algorithm will
1. Search for the _nearest_ training object to the test object $$x$$
2. Take the label of the nearest training object as the prediction for the label of the test object.



## Binary Classification Problem

When our label space contains only two distinct values, this is __binary classification__.

The label space could be something like $$\{-1,+1\}$$ or $$\{\times,\bigtriangleup\}$$, for instance. It doesn't matter as long as we can distingish the two.

## Euclidean Distance

In this example our label space is $$\{-1,+1\}$$
Our training set consists of the following training objects:

Positive Objects:
	$$(0,3), (2,2), (3,3)$$
Negative Objects:
	$$(-1,1), (-1,-1), (0,1)$$
Test Object: 
	$$(1,2)$$


TWe will use __Euclidean Distance__ as our distance measure. We need to
compute the Euclidean Distance between the test object and every training object.

To do this, we subtract vectors and compute the Euclidean norm (e.g. $$\sqrt{a^2 + b^2}$$)

The Euclidean Distance between $$(0,3)$$ and the test object is computed like so:

$$
\left\Vert 
\begin{pmatrix} 0 \\ 3 \end{pmatrix} 
- 
\begin{pmatrix} 1 \\ 2 \end{pmatrix} 
\right\Vert 
=
\left\Vert 
\begin{pmatrix} -1 \\ 1 \end{pmatrix} 
\right\Vert
=
\sqrt{-1^2 + 1^2} = 1.414
$$

Eventually, we have the Euclidean distance for all training objects:

$$
\begin{array}{|c|c|}
\hline
\text{Training Object} & \text{Label} & \text{Euclidean Distance} \\ 
\hline
(0,3) 	& +1 & 1.414\\
(2,2) 	& +1 & 1\\
(3,3) 	& +1 & 2.236\\
(-1,1) 	& -1 & 2.236\\
(-1,-1)	& -1 & 3.506\\
(0,1)	& -1 & 1.414\\
\hline
\end{array}
$$

To make our prediction, we take the label of the object with the smallest Eudlidean Distance. This is $$(2,2)$$, which has the label $$+1$$.
That is, we predict our test object will have the label $$+1$$.





