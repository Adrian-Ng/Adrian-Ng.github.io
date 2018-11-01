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

{% include figure image_path="/assets/images/montecarlo/random walk.png" alt="Random Walk" caption="Hand-drawn random walk with step-size of approx $$\pm 1$$" %}
Starting at $$t=0%%, let $$Z_t$$ describe our position after a random walk consisting of $$T$$ steps. 

$$
Z_t = \epsilon_1 + \epsilon_2 +,...,+ \epsilon_T
$$

$$Z_t$$ is a random process such that my position at time $$t$$ is a random process.

### Step Size

At each step we move up or down. The size of each step is random.

We define epsilon as a random variable sampled from the standard gaussian (mean 0, standard devition 1)

$$\epsilon_i \sim \phi(0,1)$$.

Thus each $$\epsilon_t$$ describes the up or down direction of the walk at each step.

### Sampling the Gaussian in Java

We will use the `java.util.Random` library. When instantiated, this class will generate a stream of pseudorandom numbers using a seed, which is set by the constructor `Random()`.
According to the [Java doc](https://docs.oracle.com/javase/7/docs/api/java/util/Random.html), this seed is unlikely to collide with any previous seed.

```java
Random random = new Random();
```

We want to sample from the _Gaussian distribution_. We use the method `nextGaussian()` to return the next pseudorandom sample from the Gaussian distribution.

```java
double epsilon = random.nextGaussian();
```
### Scaling

Our Random Walk lasts for the time horizon T. 
But we need our steps to be as small as possible. 
So divide this duration into a grid of equal sizes.

We pick some large value $$N$$, and calculate the time interval $$\Delta t$$.

$$
\Delta t = \frac{T}{N}
$$


{% include figure image_path="/assets/images/montecarlo/scaling.png" %}




```java
    public double sampleStepSize(double dt) {
        // sample from random Gaussian of mean 0 and sd 1
        Random epsilon = new Random();
        // return a step. value dz, size dt.
        double dz = epsilon.nextGaussian()*Math.sqrt(dt);
        return dz;
    }
```



