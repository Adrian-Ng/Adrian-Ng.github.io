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

We need to predict the _label_ for a test object $$x$$.

The algorithm will
1. Search for the _nearest_ training object to the test object $$x$$
2. Take the label of the nearest training object as the prediction for the label of the test object.

## Binary Classification Problem

When our label space contains only two distinct values, this is __binary classification__.

The label space could be something like $${-1,+1}$$ or $${\times,\bigtriangleup}$$

