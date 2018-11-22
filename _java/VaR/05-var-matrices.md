---
title: "Value at Risk: Matricies"
permalink: /java/var/matrices/
excerpt: "Building matricies in the application of Value at Risk"
toc: false
mathjax: true
classes: wide
---


We define a number of methods for producing matrices in `VolatilityAbstract.java`.

* `getCorrelationMatrix(double[][] matrix)`
* `getCovarianceMatrix(double[][] matrix)`
* `getCholeskyDecompositionMatrix(double[][] matrix)`

These all depend on the interface `getVariance`  and `getVolatility` method.
The latter simply being the square root of the output of `getVariance`.

#### getCorrelationMatrix

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
        //System.out.printf("\t\tCorrelation Matrix:\n\t\t%s\n", Arrays.toString(correlationMatrix[i]));
    }
    return correlationMatrix;
}
```

#### getCovarianceMatrix

```java
private double[][] getCovarianceMatrix(double[][] matrix) {
    int numCol = matrix.length;
    double[][] covarianceMatrix = new double[numCol][numCol];

    for (int i = 0; i < numCol; i++) {
        for (int j = 0; j < numCol; j++)
            covarianceMatrix[i][j] = getVariance(matrix[i], matrix[j]);
        //System.out.printf("\t\tCovariance Matrix\t\t\n%s\n", Arrays.toString(covarianceMatrix[i]));
    }
    return covarianceMatrix;
}
```

#### getCholeskyDecomposition

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
            //System.out.printf("\t\tCholesky Matrix\t\t\n%s\n",Arrays.toString(covarianceMatrix[i]));
        }
    return choleskyMatrix;
}
```
