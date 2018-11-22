---
title: "Value at Risk: Matricies"
permalink: /java/var/matrices/
excerpt: "Building matricies in the application of Value at Risk"
toc: true
mathjax: true
classes: wide
---


We define a number of methods for producing matrices in `VolatilityAbstract.java`.

* `getCorrelationMatrix(double[][] matrix)`
* `getCovarianceMatrix(double[][] matrix)`
* `getCholeskyDecompositionMatrix(double[][] matrix)`




## Percentage Changes

Suppose our portfolio contains multiple stocks, say _GOOG_, _MSFT_, and _AAPL_.

We will need to compute a vector of historical percentage changes for each of these.
We can combine each of these vectors to produce a matrix of price changes.

In `HistoricalSimulation.java` and `MonteCarlo.java` we instantiate this matrix as a two dimensional array: 

```java
double[][] matrix = double[countAsset][size];
```
where `countAsset` is the number of stock symbols in our portfolio and `size` is the number of percentage changes in our data.


## getCovarianceMatrix

The method `getCovarianceMatrix()` returns an $$N \times N$$ matrix for a portfolio of $$N$$ stocks.

The value of each element is computed as:

$$
\sigma^2_{x,n}={\frac{1}{m}}\sum_{i=1}^mx^2_{n-i},\quad \sigma^2_{y,n}={\frac{1}{m}}\sum_{i=1}^my^2_{n-i}
$$







```java
private double[][] getCovarianceMatrix(double[][] matrix) {
    int numCol = matrix.length;
    double[][] covarianceMatrix = new double[numCol][numCol];

    for (int i = 0; i < numCol; i++) {
        for (int j = 0; j < numCol; j++)
            covarianceMatrix[i][j] = getVariance(matrix[i], matrix[j]);
    }
    return covarianceMatrix;
}
```

$$
\begin{bmatrix}
	a_{2.694056173665337E-4} & a_{2.1361059045418314E-4} & a_{1.709980427330677E-4}\\
	a_{2.1361059045418314E-4} & a_{2.669503258565737E-4} & a_{1.7039293114741037E-4}\\
	a_{1.709980427330677E-4} & a_{1.7039293114741037E-4} & a_{2.6718851085657364E-4}
\end{bmatrix}
$$

## getCorrelationMatrix

```java
public double[][] getCorrelationMatrix(double[][] matrix) {
    int numCol = matrix.length;
    double[][] correlationMatrix = new double[numCol][numCol];

    for (int i = 0; i < numCol; i++) {
        for (int j = 0; j < numCol; j++) {
            double covXY = getVariance(matrix[i], matrix[j]);
            double sigmaX = getVolatility(matrix[i], matrix[i]);
            double sigmaY = getVolatility(matrix[j], matrix[j]);
            correlationMatrix[i][j] = covXY / (sigmaX * (sigmaY));
        }        
    }
    return correlationMatrix;
}
```

## getCholeskyDecomposition

```java
public double[][] getCholeskyDecomposition(double[][] matrix) {
    double[][] covarianceMatrix = getCovarianceMatrix(matrix);
    int numCol = matrix.length;
    double[][] choleskyMatrix = new double[numCol][numCol];

    for (int i = 0; i < covarianceMatrix.length; i++)
        for (int j = 0; j <= i; j++) {
            Double sum = 0.0;
            for (int k = 0; k < j; k++)
                sum += choleskyMatrix[i][k] * choleskyMatrix[j][k];
            if (i == j)
                choleskyMatrix[i][j] = Math.sqrt(covarianceMatrix[i][j] - sum);
            else
                choleskyMatrix[i][j] = (covarianceMatrix[i][j] - sum) / choleskyMatrix[j][j];
        }
    return choleskyMatrix;
}
```
