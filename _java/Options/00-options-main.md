---
title: "Option Pricer"
permalink: /java/options/
excerpt: "This project looks at three implementations of computing _Option Prices_: the _Binomial Tree_, the _Monte Carlo_ simulation, and the _Black Scholes equations_."
classes: wide
mathjax: true
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/headers/optionpricer.jpg
  caption: "Borodur"  
  actions:
    - label: "Download"
      url: "https://github.com/Adrian-Ng/OptionPricer"    

feature_row:
  - image_path: assets/images/splash/binomialTrees.jpg
    image_caption: "Angkor Wat"  
    alt: "Option Pricer"
    title: "Binomial Trees  "
    excerpt: "When pricing options, we don't know whether the price will go _up_ or _down_. This simple model captures that uncertainty."
    url: "java/options/trees/"
    btn_label: "Read More"
    btn_class: "btn--warning"    

  - image_path: /assets/images/splash/montecarlo_options.jpg    
    image_caption: "Angkor Wat"  
    alt: "Value at Risk"
    title: "Monte Carlo Simulation"
    excerpt: "The behaviour of a stock price is like a random walk. Let's simulate a very large number of these to predict our option price."
    url: "/java/options/montecarlo/"
    btn_label: "Read More"
    btn_class: "btn--danger"

  - image_path: /assets/images/splash/blackscholes.jpg
    image_caption: "Sauðárkrókur"  
    alt: "Black Scholes equation"
    title: "Black Scholes equation"      
    excerpt: $$\frac{\partial f}{\partial t} + rS\cdot \frac{\partial f}{\partial S}+\frac{1}{2}\sigma^2 S^2\cdot\frac{\partial^2 f}{\partial S^2} = rf$$      
    url: "/java/options/blackscholes/"
    btn_label: "Read More"
    btn_class: "btn--info"
---


{% include feature_row %}

## Class Diagram

{% include figure image_path="/assets/images/optionpricer/OptionPricer.png" %}

## OptionPricer.java

### Input

The main class is `OptionPricer.java`, which reads `pricingtypes.txt`.
This file contains the following strings:

```
American Binomial Tree
Asian Monte Carlo
European Binomial Tree
European Monte Carlo
Black Scholes
```

### Body

```java
public class OptionPricer extends Utils {

    public static void main(String[] args) {
        String[] Name = readTxt("pricingtypes.txt");
        PricingFactory factory = new PricingFactory();
        for (String str : Name) {
            PricingType pricing = factory.getPricingType(str);

            double call = pricing.getCall();
            double put = pricing.getPut();

            System.out.printf("%s\n\tCall:%.14f\n\tPut:%.14f\n", str, call, put);
        }
    }
}
```

## Interface

This is used by `PricingFactory.java` to construct the appropriate concrete class from the _interface_ `PricingType.java` class.
Classes that implement this interface are:

* BlackScholes
* MC_Abstract
* TreeAbstract

### Methods

`PricingType.java` presecribes the following methods to be implemented:

```java
double getCall()
double getPut()
```

## Abstract Classes

### Monte Carlo

In certain cases, we are concerned with comparing the different type of __pay-offs__ that can be utilised under each pricing method.
For instance, when pricing via _Monte Carlo_, we are able to compare the difference in option prices that result from considering both Asian and European pay-off.


* MC_Abstract.java
    * MC_Asian.java
    * MC_Euro.java

As such, we have an abstract class `MC_Abstract.java` which is extended by `MC_Asian.java` and `MC_Euro.java`. 
Both these concrete classes must define their own implementations of the following method:
 
```java
 public double simulateRandomwalk (int N, double S0, double dt, double interest, double sigma)
```

### Binomial Tree

We have a similar relationship with the abstract class `TreeAbstract.java` and its concrete classes.

* TreeAbstract.java
    * TreeAmerican.java
    * TreeEuropean.java

The difference between an American and European option is that an American __put__ can be exercised at any time up to maturity.
The European put can only be exercised at maturity. There is no difference between American and European calls.

As such, the concrete classes must implement their own version of the following method:

```java
public double setPut(double[][] stockPrice, double strike, double interest, double p, double dt, int T)
```

## Inputs

In addition to `pricingtypes.txt`, we have a number of input `.txt` files. 

* Binomial.txt
* BlackScholes.txt
* MonteCarlo.txt

These files contain the following:

```
stock,115
strike,80
volatility,0.48
interest,0.07
timehorizon,0.5
```
Each file contain identical data. But the user is free to modify the data for each implmentation.

On each line is a comma separated key-value-pair such that this data is mapped accordingly: `HashMap<String, Double>`. 
This allows for the following convenience:

```java
double stock          = hashMap.get("stock");
double strike         = hashMap.get("strike");
double volatility     = hashMap.get("volatility");
double interest       = hashMap.get("interest");
double timehorizon    = hashMap.get("timehorizon");
```
