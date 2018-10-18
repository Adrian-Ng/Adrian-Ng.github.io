---
title: "Options Pricing: Black Scholes"
permalink: /java/options/blackscholes/
excerpt: "Pricing European options via Black Scholes"
toc: true
mathjax: true
---


## Black Scholes differential equation

$$
\frac{\partial f}{\partial t} + rS\cdot \frac{\partial f}{\partial S}+\frac{1}{2}\sigma^2 S^2\cdot\frac{\partial^2 f}{\partial S^2} = rf
$$

### Pricing call and put with a given strike price X and maturity T

According the Black-Scholes formula, the values of call and put with the strike price $$X$$ maturing at time $$T$$ are given by:

$$
c(S,t)=SN(d_1)-Xe^{r(T-t)}N(d_2)\\
p(S,t)=Xe^{-r(T-t)}N(-d_2)-SN(-d_1)\\
$$

Where

$$
d_1=\frac{\ln{\left(\frac{S}{X}\right)}+(r + \frac{\sigma^2}{2})(T-t)}{\sigma\sqrt{T-t}}\\
d_2=\frac{\ln{\left(\frac{S}{X}\right)}+(r - \frac{\sigma^2}{2})(T-t)}{\sigma\sqrt{T-t}} = d_1-\sigma\sqrt{T-t}\\
$$

## Java

### Implementation

In the Java implementation, we simply assume $$t=0$$.

#### d1 & d2

```java
d1 	= (Math.log(stock / strike) 
	+ (interest + (Math.pow(volatility, 2) / 2)) 
	* maturity)
	/ (volatility * Math.sqrt(maturity));

d2 	= d1 - (volatility * Math.sqrt(maturity));
```

#### getCall()

```java
public double getCall() {
    return      (stock * distribution.cumulativeProbability(d1))
            -   (strike * Math.exp(-interest * maturity)
            *   distribution.cumulativeProbability(d2));
    }
```

#### getPut()
```java
public double getPut() {
    return  strike * Math.exp(-interest * maturity)
    * distribution.cumulativeProbability(-d2)
    - stock * distribution.cumulativeProbability(-d1);
    }
```


### Input

### Output


## Appendix

### Nearing Maturity

As we approach maturity, $$t \rightarrow T$$, the following terms tend to 0.

$$
T-t \rightarrow 0\\
\left(r\pm \frac{\sigma^2}{2} \right) \rightarrow 0
$$

Therefore $$\ln{\frac{S}{X}}$$ becomes important to the behaviour of $$d_1$$ and $$d_2$$.


#### If $$S \rightarrow +\infty$$ then $$\ln{\frac{S}{X}}$$ is positive.

When positive,

$$
d_1,d_2 \rightarrow +\infty\\
N(d_1),N(d,2)\rightarrow 1\\
N(-d_1),N(-d_2) \rightarrow 0\\
$$

So at maturity, the value of the options is:

$$
c\rightarrow S-X\\
p\rightarrow 0\\
$$ 

If $$S$$ is big, the call will be executed with high probability and becomes similar to a forward!
Likewise, the Put will not likely be executed.


#### If $$S \rightarrow -\infty$$ then $$\ln{\frac{S}{X}}$$ is negative.

When negative,

$$
d_1,d_2 \rightarrow -\infty\\
N(d_1),N(d,2)\rightarrow 0\\
N(-d_1),N(-d_2) \rightarrow 1\\
$$

So at maturity, the value of the options is:

$$
c\rightarrow 0\\
p\rightarrow X-S\\
$$ 

## References