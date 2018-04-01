---
title: "R Implementation: Kernel Ridge Regression"
permalink: /R/imp-krr/
excerpt: "An Implementation of Kernel Ridge Regression in R by Adrian Ng"
toc: true
---


## DEFINE KRR CLASS
```R
KRR <- function
	(	trainObject
	,	testObject
	,	trainLabel
	,	lambda		
	,	km		#kernel method; km = 0 polynomial; km = 1 radial; km = 2 for linear
	,	parameter	#treat as d for polynomial or treat as g for radial
		) {
```

### POLYNOMIAL KERNEL	

<img src="https://latex.codecogs.com/svg.latex?\Large&space;x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" title="\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}" />

```R
polynomial_k <- function (x, x.prime, d) {
	return(I((1 +	x %*% x.prime)^d));		
	};
```

### RADIAL KERNEL
```R
radial_k <- function (x, x.prime, g) {	
	r <- apply(		x.prime
		,	1
		,	function(a)	
			colSums(apply	( x
				,	1
				,	function(b)
					(b - a)^2)
					)
			);		
	return(exp(-g*r));
	};
```

### LINEAR KERNEL

```R
linear_k <-function (x,x.prime) {
	return(x %*% x.prime);
	};		
```

### INITIALISE VARIABLES

```R
#INITIALISE DATA FRAMES
df.trainObject	<- data.frame(trainObject);
df.testObject	<- data.frame(testObject);
df.trainLabel	<- data.frame(trainLabel);			
#INITIALIZE MATRICES
m.trainObject	<- as.matrix(trainObject);
m.testObject	<- as.matrix(testObject);
m.trainLabel	<- as.matrix(trainLabel);			
```

### PARAMETER HANDLING
```R
#number of attributes
p = ncol(df.trainObject);
#number of observations
n = nrow(df.trainObject);
```

## RETURN K and k

### Polynomial
```R
if (km == 0) {
K	<- polynomial_k(m.trainObject,t(m.trainObject),parameter);
k	<- polynomial_k(m.trainObject,t(m.testObject),parameter);
	}
```

### Radial
```R
else if (km == 1) {
K	<- radial_k(df.trainObject,df.trainObject,parameter);
k	<- radial_k(df.trainObject,df.testObject,parameter);
	}
```
### Linear
```R
else if (km == 2) {
K	<- linear_k(m.trainObject,t(m.trainObject));
k	<- linear_k(m.trainObject,t(m.testObject));
	};	
```

### Calculate Y Hat
```R
y.hat	<- trainLabel %*% solve(lambda*diag(n) + K) %*% k;
return (y.hat);
	};
```

## Analysis
