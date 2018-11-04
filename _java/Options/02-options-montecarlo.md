---
title: "Options Pricing: Monte Carlo"
permalink: /java/options/montecarlo/
excerpt: "Pricing European and Asian options via diffusion or Monte Carlo method"
toc: true
mathjax: true
---

The Monte Carlo method is a way of simulating a distribution by way of randomly generating a whole bunch of numbers. 
In __Central Limit Theorem__, the distribution of the sum of a large number of small contributions is approximately Gaussian.

Stock prices can be described as a _random walk_. That is, a stock price is the linear combination of a number of infinitessimally small changes otherwise known as the __Wiener Process__. Each change is randomly sampled from sthe standard Gaussian distribution. Our predicted stock price is where ever we end up at the end of the random walk.

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

where $$\epsilon_i$$ is our random sample. 

Values of $$\Delta z$$ at different time slices, $$\Delta t$$, are independent.

### Random Walk

Consider the below illustration. We a see a simple random walk with approximately $$N=6$$ intervals of $$\Delta t$$.

As you can see, at each step we move up or down. 

{% include figure image_path="/assets/images/montecarlo/random walk.png" alt="Random Walk" caption="Hand-drawn random walk" %}

At $$t=T$$, we can describe our position at the end of the walk by:

$$
z(T) - z(0) = \sum_{i=1}^N \epsilon_i \sqrt{\Delta t}
$$

That is our final position can be calculated as the linear combination of every step in the walk.

### Epsilon

We define epsilon as a random variable sampled from the standard gaussian (mean 0, standard devition 1).

$$\epsilon_i \sim \phi(0,1)$$.

This means that the value of epsilon is going to be somewhere between -1 and +1. And average, this value is going to be 0.

If we get a positive value, then our step goes up (and down if negative).

How do we generate epsilon in Java?

We use the `java.util.Random` class. When instantiated, this class will generate an iterable collection of pseudorandom numbers. This collection is governed by a seed, which is set by the constructor `Random()`.
According to the [Java doc](https://docs.oracle.com/javase/7/docs/api/java/util/Random.html), this seed is unlikely to collide with any previous seed.

```java
Random random = new Random();
```
We want to sample from the _Gaussian distribution_ so we use the method `nextGaussian()` to return the next pseudorandom sample from the Gaussian distribution.

```java
double epsilon = random.nextGaussian();
```

### Scaling

Our Random Walk has the duration $$T - 0$$. 
But we would like our steps $$\Delta t$$ to be as small as possible. 
The result is a really fine random walk.


$$
\Delta t = \frac{T}{N}
$$

We therefore want $$N$$ to be as large as possible.

{% include figure image_path="/assets/images/montecarlo/scaling.png" %}

Suppose we want to simulate the change in a stock price over the next year, $$T=1$$.
It would make sense to divide this time horizon by $$N=365$$ such that each timeslice $$\Delta t$$ represents one day.

## Java

## Basic Weiner Process

Translating all this to a method is rather simple:

```java
    public double basicWeinerProcess(double dt) {        
        Random epsilon = new Random();
        // sample from random Gaussian of mean 0 and sd 1        
        double dz = epsilon.nextGaussian()*Math.sqrt(dt);
        // return a step. value dz, size dt.
        return dz;
    }
```

### Random Walk

#### European

```java
public double simuluatePath(int N, double S0, double dt, double r, double sigma) {
        // allocate memory to grid
        double[] grid = new double[N];
        grid[0] = S0;
        for (int i = 1; i < N; i++){
            double dz = basicWeinerProcess(dt);
            grid[i] = grid[i-1] + (r*grid[i-1]*dt)+(sigma*grid[i-1]*dz);
        }
        return grid[N-1];
    }
```

#### Asian

```java
public double simuluatePath(int N, double S0, double dt, double r, double sigma) {
        // allocate memory to grid
        double[] grid = new double[N];
        grid[0] = S0;
        for (int i = 1; i < N; i++){
            double dz = basicWeinerProcess(dt);
            grid[i] = grid[i-1] + (r*grid[i-1]*dt)+(sigma*grid[i-1]*dz);
        }
        //Because this is Asian option, we compute average price throughout the lifetime
        double Savg = 0.0;
        for (int i = 0; i < N; i++)
            Savg += grid[i];
        return Savg/N;
    }
```