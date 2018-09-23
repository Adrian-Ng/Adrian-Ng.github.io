---
title: "k Nearest Neighbours: k > 1"
permalink: /R/knn/kgtone/
toc: true
classes: wide
mathjax: true
---

## Intro

This time we want to find the nearest _k_ neighbours to the test object.

For classification, we simply take a vote between them.
In regression, we predict with the average of their labels.

## Deciding k

To decide what size _k_ to use, we can use _cross validation_.

For a large training set, we can use cross validation with 10 folds.

## Computational Aspects

A large _k_ can be computationally expensive.

Computing one distance takes time $$O(p)$$ where $$p$$ is the dimension of the objects (i.e. number of numeric attributes).

For each object in the test set, we need to calculate $$n$$ distances.
The total time required to calculate distances for each test object is $$O(np)$$.

### Curse of Dimensionality

As the number of observations needed increases exponentially with each attribute.

## Examples

### Classification



### Regression

