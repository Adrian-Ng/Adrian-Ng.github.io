---
title: "Options Pricing: Monte Carlo"
permalink: /java/options/montecarlo/
excerpt: "Pricing European and Asian options via diffusion or Monte Carlo method"
toc: true
mathjax: true
---


The behaviour of the price of a stock price can be described by the Generalisedd Wiener process.

$$
x(t + \Delta t) = x(t) + \mu\Delta t + \sigma dz
$$

Where $$dz$$ is the __Wiener Process__.

## Wiener Process

### Random Walk

Let's start by constructing a _random walk_.


{% include figure image_path="/assets/images/random walk.png" alt="this is a placeholder image" caption="Random Walk" %}

Let $$Z_t$$ describe our position after $$t$$ steps. 

$$
Z_t = \epsilon_1 + \epsilon_2 +,...,+ \epsilon_t
$$

We start at $$t = 0$$.

### Step Size

At each step we move up or down. The size of each step is random.

We define epsilon as a random variable sampled from the standard gaussian (mean 0, standard devition 1)

$$\epsilon_i \approx \phi(0,1)$$.

Thus each $$\epsilon_t$$ describes the up or down direction of the walk at each step.

### double sampleStepSize(double dt){}

In Java we can write a method that, when invoked, returns a sample from this distribution.

We will use the `java.util.Random' library.`

```java
    public double sampleStepSize(double dt) {
        // sample from random Gaussian of mean 0 and sd 1
        Random epsilon = new Random();
        // return a step. value dz, size dt.
        double dz = epsilon.nextGaussian()*Math.sqrt(dt);
        return dz;
    }
```



