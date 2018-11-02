---
title: "Options Pricing: Monte Carlo"
permalink: /java/options/montecarlo/
excerpt: "Pricing European and Asian options via diffusion or Monte Carlo method"
toc: true
mathjax: true
---


The behaviour of the price of a stock price can be described by the Generalised Wiener process.

$$
x(t + \Delta t) = x(t) + \mu\Delta t + \sigma dz
$$

Where $$dz$$ is the __Wiener Process__.

## Wiener Process

The __Wiener Process__ is a particular type of _Markov Process_ with mean change 0 and variance rate of 1 per year.




### Random Walk

Let's start by constructing a _random walk_.

{% include figure image_path="/assets/images/montecarlo/random walk.png" alt="Random Walk" caption="Hand-drawn random walk with step-size of approx $$\pm 1$$" %}
Starting at $$t=0$$, let $$Z_t$$ describe our position after a random walk consisting of $$T$$ steps. 

$$
z_t = \epsilon_1 + \epsilon_2 +,...,+ \epsilon_T
$$


### Step Size

At each step we move up or down. The change $$\Delta \$$ at each step is

We define epsilon as a random variable sampled from the standard gaussian (mean 0, standard devition 1).

$$\epsilon_i \sim \phi(0,1)$$.

Thus each $$\epsilon_t$$ describes the up or down direction of the walk at each step.

### Sampling the Gaussian in Java

We use the `java.util.Random` class. When instantiated, this class will generate a stream of pseudorandom numbers using a seed, which is set by the constructor `Random()`.
According to the [Java doc](https://docs.oracle.com/javase/7/docs/api/java/util/Random.html), this seed is unlikely to collide with any previous seed.

```java
Random random = new Random();
```
We want to sample from the _Gaussian distribution_ so we use the method `nextGaussian()` to return the next pseudorandom sample from the Gaussian distribution.

```java
double epsilon = random.nextGaussian();
```
### Scaling

Our Random Walk lasts for the time horizon $$T - 0$$. 
But we need our steps to be as small as possible. 
So divide this duration into a grid of infintessimally small intervals.

We pick some large value $$N$$, and calculate the time interval $$\Delta t$$.

$$
\Delta t = \frac{T}{N}
$$

{% include figure image_path="/assets/images/montecarlo/scaling.png" %}






```java
    public double sampleStepSize(double dt) {        
        Random epsilon = new Random();
        // sample from random Gaussian of mean 0 and sd 1        
        double dz = epsilon.nextGaussian()*Math.sqrt(dt);
        // return a step. value dz, size dt.
        return dz;
    }
```



