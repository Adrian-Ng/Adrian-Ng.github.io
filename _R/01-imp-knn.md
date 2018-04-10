---
title: "R Language: Implementing K Nearest Neighbours"
permalink: /R/imp-knn/
excerpt: "An implementation of K Nearest Neighbours in R Language by Adrian Ng"
toc: true
---

## DOWNLOAD

[ynn.r](/R/NN.r)

## Intro

A generalized function for calculating nearest neighbours for any value of k.
This is a set based solution that aims to optimise for speed by avoiding as many loops as possible.knn_general <- function

## Code

Ok this page is a work in progress and to begin with I'm just going to dump all my code here. 

Now this is an implementation of KNN that I made in Q4 2016 and it was THE first thing I built in R. 
I tried to make it rely on as few loops as possible since... R is really slow.

I do think it's imperfect in the way it tries to use `merge` as an analogue to SQL's `CROSS JOIN` and `INNER JOIN`.
The problem is that `merge` returns a set that is completely different from the original ordering. 
I mean it's just a waste of time.

Well I had some design constraints, which is why I went about doing it this way.

Design constraints: 
* Not allowed to use `sort` or `order`.
* Minimise the use of for-loops.

## `knn_general` Class Creation

First I create my class. It takes four parameters:
* `trainObject`: a vector of training data consisting of _Objects_.
* `testObject`: a vector of test data. This vector would probably just be a singleton.
* `trainLabel`: a vector of training data consisting of _Labels_.

```R
knn_general <- function
(	trainObject
,	testObject
,	trainLabel
,	kValue
){
```

## Computing Mode

R does not appear to have a function of finding model values. 

```R
modlab <- function
	(xx){
	modlab <- aggregate(	
		as.numeric(xx)
	,	by=list(as.numeric(xx))
	,	FUN = length
	)	[which.max(aggregate(	
			as.numeric(xx)
		,	by=list(as.numeric(xx))
		,	FUN = length
		)	$x),1]
return(modlab)
}
```

## INITIALISE DATA FRAMES AND CREATE IDENTITIES

```R
trainObject		<- data.frame(rownames(trainObject),trainObject);
names(trainObject)[1]	<- paste("trainID");
testObject		<- data.frame(rownames(testObject),testObject);
names(testObject)[1]	<- paste("testID");
trainLabel		<- data.frame(trainLabel);
trainLabel		<- data.frame(rownames(trainLabel),trainLabel);
names(trainLabel)[1]	<- paste("labelID");
```

## CREATE DATA FRAME FOR STORING PREDICTED LABEL

This stores the predicted labels for our `testObject` of every nearest neighbour at any level of k.

```R
predicted		<- data.frame(testObject[,1]);
names(predicted)[1]	<- paste("testID");
```
This converts `testID` from factor to numeric to maintain ordering.

```R
predicted$testID	<- as.numeric(levels(predicted$testID))[predicted$testID]
```




