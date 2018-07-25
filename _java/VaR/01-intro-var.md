---
title: "VAR: Intro"
permalink: /java/var/intro/
excerpt: "An intro to VAR by Adrian Ng"
toc: true
mathjax: true
---

### Background

In 2017 I write my Master's dissertation which was simply titled _Implementation of Value at Risk Measures in Java_.

That is, I wrote a program in Java which calculated _thing_ - a measurement. That measurement being Value at Risk.
It was during this project that I really got my teeth into Java and immersed me in the world of finance.

### What is Value at Risk?

For a given a portfolio of investments there is an associated risk.
However, there are many measures of risk, such as Greek letters) that simply describe different aspects of risk in a portfolio of derivatives.
The goal of Value at Risk (VaR) is to provide an estimate of risk that summarises all aspects of risk into one figure.

This one figure simply answers the question: _how bad could it get_?
An answer is provided with respect to two parameters: the time horizon and confidence level.
That is, we are $$x\%$$ sure that our portfolio will not lose more than a certain amount over the next $N$ days.
That certain amount is our VaR estimate.

This estimate is widely used in industry.
Take, for instance, an investment bank.
People deposit their money into this bank and in turn, the bank invests this money in the stock market and earns money on the returns.
An investment with high returns is highly risky.
The bank needs to keep a certain amount of cash in reserve to mitigate this risk.
The size of this reserve is proportional to the bank's exposure to risk, i.e. the VaR estimate.

