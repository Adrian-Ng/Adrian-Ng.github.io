---
title: "Options Pricing: Monte Carlo"
permalink: /java/options/montecarlo/
excerpt: "Pricing European and Asian options via diffusion or Monte Carlo method"
toc: true
mathjax: true
---

The Monte Carlo method is a way of simulating a distribution by way of randomly generating a whole bunch of numbers.

Stock prices can be described as a _random walk_. That is, a stock price is the linear combination of a number of infinitessimally small changes otherwise known as the __Wiener Process__. Each change is randomly sampled from some parametric distribution. Our predicted stock price is where ever we end up at the end of the random walk.

With Monte Carlo, we simply generate __large__ number of stock prices and calculate the pay-off for each of them. We average these pay-offs to obtain our predicted option price.


## Formula

We use the Generalised Wiener process to generate a random walk. The following recursive formula describes this process:

$$
x(t + \Delta t) = x(t) + \mu\Delta t + \sigma dz
$$

Where:
* $$dz$$ is the basic __Wiener Process__.
* $$\Delta t$$ is a time step of some very small duration
* $$x_t$$ is the stock price at the current time step
* $$x_{t + \Delta t}$$ is the stock price at the next time step

At $$t=0$$, $$x(0)$$ is our initial stock price.


## Basic Wiener Process

The __Wiener Process__ is a particular type of _Markov probabilistic Process_ with mean change 0 and variance rate of 1 per year.

Which is to say we sample randomly from the standard Gaussian distribution and multiply by the square root of time.  

$$
\Delta z = \epsilon \sqrt{\Delta t}
$$

where $$\epsilon_i \sim \phi(0,1)$$ - epsilon takes the standard Gaussian distribution. 

Any two values of $$\Delta z$$ taken from different time slices, $$\Delta t$$ are independent.

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



