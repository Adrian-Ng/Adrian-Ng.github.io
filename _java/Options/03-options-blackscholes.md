---
title: "Options Pricing: Black Scholes"
permalink: /java/options/blackscholes/
excerpt: "Pricing European options via Black Scholes"
toc: true
mathjax: true
---


### Black Scholes differential equation

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
d_1=\frac{ln(\frac{S}{X})+(r + \frac{\sigma^2}{2})(T-t)}{\sigma\sqrt{T-t}}\\
d_2=\frac{ln(\frac{S}{X})+(r - \frac{\sigma^2}{2})(T-t)}{\sigma\sqrt{T-t}} = d_1-\sigma{T-t}\\
$$

#### Near Maturity

As $$t \rightarrow T$$, the terms

$$
\left(r\pm \frac{\sigma^2}{2} \right)
$$

As time $$t$$ approaches maturity $$T$$