---
title: "OptionPricer"
permalink: /java/options/blackscholes/
excerpt: "Pricing European options using the Black Scholes equation"
toc: true
toc_sticky: true
mathjax: true
header:
    image: /assets/images/headers/blackscholes.jpg
    caption: "Sauðárkrókur"  
  actions:
    - label: "Download"
      url: "https://github.com/Adrian-Ng/OptionPricer"
---

## Black Scholes differential equation

$$
\frac{\partial f}{\partial t} + rS\cdot \frac{\partial f}{\partial S}+\frac{1}{2}\sigma^2 S^2\cdot\frac{\partial^2 f}{\partial S^2} = rf
$$

where

* $$S = \text{stock price}$$
* $$f = \text{option price}$$
* $$r = \text{interest}$$

### Pricing call and put with a given strike price X and maturity T

According the Black-Scholes formula, the values of call and put with the strike price $$X$$ maturing at time $$T$$ are given by:

$$
c(S,t)=SN(d_1)-Xe^{r(T-t)}N(d_2)\\\\
p(S,t)=Xe^{-r(T-t)}N(-d_2)-SN(-d_1)\\
$$

Where $$N$$ is the _distribution function_ of $$\phi(0,1)$$,

and:

$$
d_1=\frac{\ln{\left(\frac{S}{X}\right)}+(r + \frac{\sigma^2}{2})(T-t)}{\sigma\sqrt{T-t}}\\
d_2=\frac{\ln{\left(\frac{S}{X}\right)}+(r - \frac{\sigma^2}{2})(T-t)}{\sigma\sqrt{T-t}} = d_1-\sigma\sqrt{T-t}\\
$$

## Java

### BlackScholes.java

```java
public class BlackScholes implements PricingType
```
`PricingType`, is an interface that defines two abstract methods `getCall()` and `getPut()`.
In `BlackScholes`, we implement these methods.

Our input variables are stored in a collection `HashMap<String, Double>`. At the constructor we initialize a number of instance variables.

```java
stock          = hashMap.get("stock");
strike         = hashMap.get("strike");
volatility     = hashMap.get("volatility");
interest       = hashMap.get("interest");
timehorizon    = hashMap.get("timehorizon");
```

#### d1 & d2

Also at the constructor, we calculate $$d_1$$ and $$d_2$$.

```java
d1 	= (Math.log(stock / strike) 
	+ (interest + (Math.pow(volatility, 2) / 2)) 
	* timehorizon)
	/ (volatility * Math.sqrt(timehorizon));

d2 	= d1 - (volatility * Math.sqrt(timehorizon));
```

#### getCall()

```java
public double getCall() {
    return      (stock * distribution.cumulativeProbability(d1))
            -   (strike * Math.exp(-interest * timehorizon)
            *   distribution.cumulativeProbability(d2));
    }
```

#### getPut()
```java
public double getPut() {
    return  strike * Math.exp(-interest * timehorizon)
    * distribution.cumulativeProbability(-d2)
    - stock * distribution.cumulativeProbability(-d1);
    }
```

### BlackScholes.txt

In the Java implementation, we simply assume $$t=0$$.
So the timehorizon $$T-t$$ is the maturity $$T$$. 

Let's suppose the following:

$$
S = 115\\
X = 80\\
\sigma = 0.48\\
r = 0.07\\
T-t = 0.5\\
$$

So in `BlackScholes.txt`, we have

```
stock,115
strike,80
volatility,0.48
interest,0.07
timehorizon,0.5
```

### Output
```
Black Scholes
	Call:39.63234093141300
	Put:1.88077423201832
```
## The Black Scholes Formulas

### Nearing Maturity

As we approach maturity, $$t \rightarrow T$$, the following terms tend to 0.

$$
\left(T-t\right) \rightarrow 0\\
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


