---
title: "Value at Risk"
permalink: /java/var/
excerpt: "How bad could it get for our financial portfolio? This _dissertation project_ looks at a number of ways of estimating __VaR__."
toc: true
toc_sticky: true
mathjax: true
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/headers/var.jpg
  caption: "Kinabalu"  
  actions:
    - label: "Download"
      url: "https://github.com/Adrian-Ng/ValueAtRisk"  

feature_row:
  - image_path: assets/images/splash/binomialTrees.jpg
    image_caption: "Angkor Wat"  
    alt: "Analytical Approach"
    title: "Analytical Approach"
    excerpt: ""
    url: "java/var/analytical/"
    btn_label: "Read More"
    btn_class: "btn--warning"    

  - image_path: /assets/images/splash/montecarlo_options.jpg    
    image_caption: "Angkor Wat"  
    alt: "Historical Simulation"
    title: "Historical Simulation"
    excerpt: ""
    url: "/java/var/historical/"
    btn_label: "Read More"
    btn_class: "btn--danger"

  - image_path: /assets/images/splash/blackscholes.jpg
    image_caption: "Sauðárkrókur"  
    alt: "Monte Carlo Simulation"
    title: "Monte Carlo Simulation"      
    excerpt: ""
    url: "/java/var/montecarlo/"
    btn_label: "Read More"
    btn_class: "btn--info"  
---

{% include feature_row %}

In all cases, we take the parameters of our approaches from real-world historical market data, from [_Yahoo Finance_](java/yahoofinance/).

## Background

For a given a portfolio of investments there is an associated risk. 
However, there are many measures of risk (such as Greek letters) that simply describe different aspects of risk in a portfolio of derivatives. 
The goal of Value at Risk (VaR) is to provide an estimate of risk that summarises all aspects of risk into a single figure.

This figure simply answers the question: how bad _could_ it get? 
An answer is provided with respect to two parameters: the __time horizon__ and __confidence level__. 
That is, we are $$x%$$ sure that our portfolio will not lose more than a certain amount over the next $$N$$ days. 


That certain amount is our VaR estimate. This estimate is widely used in industry. 

Take for instance an investment bank. 
People deposit their money into this bank and, in turn, the bank invests this money in the stock market and earns money on the returns. 

An investment with high returns is highly risky. 
The bank needs to keep a certain amount of cash in reserve to mitigate this risk. 
The size of this reserve is proportional to the bank’s exposure to risk, i.e. the VaR estimate.

## Class Diagram

{% include figure image_path="/assets/images/var/VaR.png" %}

## VaR.java

```java
public class VaR extends DataIngress {

    public static void main(String[] args) {
        HashMap<String, Double> varEstimates = new HashMap<>();

        MeasureFactory measureFactory = new MeasureFactory();
        try {
            for (String str : riskMeasures) {
                System.out.printf("\t%s\n", str);
                RiskMeasure riskMeasure = measureFactory.getMeasureType(str);

                Double VaR = riskMeasure.getVar();
                System.out.printf("\t\tVaR: %f\n", VaR);

                varEstimates.put(str, VaR);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

## Data Ingress

`DataIngress.java` is where data from local `.txt` files and _Yahoo Finance_ is ingested.

### Text Files

* `symbol.txt`
* `parameters.txt`
* `RiskMeasures.txt`



* `/Deltas/*.txt`

### Variables
```java
public static String[] strSymbols;
public static HashMap<String, String> hashParam;
public static String[] riskMeasures;
public static HashMap<String, Stock> stockHashMap;
public static HashMap<String, Integer> hashStockDeltas = new HashMap<>();
public static HashMap<String, Integer> hashOptionDeltas = new HashMap<>();
public static double currentPortfolio;
public static int countAsset;
public static int size;
```
### Methods

* readParameters()
* readDeltas()
* getStock()
* getSize()
* valuePortfolio()
* readTxt()

### Static Block

```java
static {
    strSymbols = readTxt("symbol.txt");
    countAsset = strSymbols.length;
    hashParam = readParameters();
    riskMeasures = readTxt("RiskMeasures.txt");
    stockHashMap = getStock();
    readDeltas();
    currentPortfolio = valuePortfolio();
    size = getSize();
}
```

## PercentageChange

In order to estimate _variance_ and _volatilities_, we take the assumption that the __percentage changes__ between the stock prices on each day can be modelled on the __standard Gaussian Distribution__, $$\Phi(0,1)$$.

$$
u_i = \frac{S_{i}-S_{i-1}}{S_{i-1}}
$$

The class `PercentageChange.java` has two methods that return historical percentage changes (=returns) in the form of an `ArrayList<Double>` and `Double[]`. 

### getArrayList

We pass a collection of `HistoricalQuote` to `getArrayList`, which returns a collection of `Double` in an `ArrayList`.
That is, this is a collection of historical price data for a given stock.

In this method, we iterate through `HistoricalQuote` and invoke `getClose()`, which returns the stock price at the market close in the form of a `BigDecimal` type.
At each iteration, we take the previous and current `BigDecimal` and compute the percentage change.
Because working with `BigDecimal` is computationally expensive (=slow), we cast each result to `double`.

```java
public static ArrayList<Double> getArrayList(List<HistoricalQuote> historicalQuotes) {
    ArrayList<Double> percentageChange = new ArrayList<>();
    Iterator<HistoricalQuote> iterator = historicalQuotes.iterator();
    BigDecimal a = iterator.next().getClose();
    while (iterator.hasNext()){
        BigDecimal b = iterator.next().getClose();
        BigDecimal PriceDiff = a
                                .subtract(b)
                                .divide(a, RoundingMode.HALF_UP);
        percentageChange.add(PriceDiff.doubleValue());
        a = b;
    }
    return percentageChange;
}
```

### getArray

For our purposes, it's much easier to use `double[]` types than `ArrayList<Double>`.

```java
public static double[] getArray(List<HistoricalQuote> historicalQuotes) {
    ArrayList<Double> percentageChange = getArrayList(historicalQuotes);
    int size = percentageChange.size();
    double[] doubles = new double[size];

    for (int i = 0; i < size; i++)
        doubles[i] = percentageChange.get(i);

    return doubles;
}
```

## Abstract Classes

* `RiskMeasure.java`
* `VolatilityAbstract.java`

### RiskMeasure

```java
public abstract class RiskMeasure extends VaR {
    
    abstract double getVar();

}
```

### Volatility

The only abstract method defined in `VolatilityAbstract.java` is as follows:

```java
abstract public double getVariance(double[] xVector, double[] yVector);
```

The classes that implement this method are:

* `VolatilityEW.java`
* `VolatilityEWMA.java`
* `VolatilityGARCH.java`






