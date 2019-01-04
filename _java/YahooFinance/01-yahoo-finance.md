---
title: "Fun with Yahoo Finance API"
permalink: /java/yahoofinance/
excerpt: "As of March 2018, something happened to Google Finance - it got taken to the chopping board and is now a miserable husk of its former self!
Long gone are the days where one could simply hook into the API and download a fat, juicy csv-file of historical stock price data... or a sensible JSON of option prices.

Thankfully, there are many alternatives out there."
mathjax: true
header:
    image: /assets/images/headers/yahoofinance.jpg
---


## Google Finance API No More!

As of March 2018, something [happened](https://www.marketbeat.com/press-room/google-finance-changes-and-alternatives/) to Google Finance - it got taken to the __chopping board__ and is now a miserable husk of its former self!
Long gone are the days where one could simply hook into the API and download a fat, juicy csv-file of historical stock price data... or a sensible JSON of option prices.

Thankfully, there are many alternatives out there.

## YahooFinanceAPI

Since I've been accessing the API through Java, I'm taking a look at this _unofficial_ [library](https://financequotes-api.com).


### Getting Historical Data

You can construct a `Stock` object such that it contains 5 years historical data.
Then use the `getHistory()` method to return a collection of `HistoricalQuote` elements.

```java
Calendar from = Calendar.getInstance();
Calendar to = Calendar.getInstance();
from.add(Calendar.YEAR, -5); 

Stock google = YahooFinance.get("GOOG", from, to, Interval.DAILY);
List<HistoricalQuote> historyGoogle = google.getHistory();
```
### HistoricalQuote

To look at, say, the closing price on each day, we'll have to traverse the `List` and invoke the method `getClose()`.

```java
for(HistoricalQuote historicalQuote : historyGoogle)
                System.out.println(historicalQuote.getClose());
```
Looking at the [documentation](https://financequotes-api.com/javadoc/yahoofinance/YahooFinance.html), we can see that this method (and others like it) returns a `BigDecimal`.

## Stream()

If you want, you can `stream()` instead of iterating through the collection.

```java
BigDecimal totalClose = historyGoogle
	.stream()
	.map(HistoricalQuote::getClose)
	.reduce(    BigDecimal.ZERO // identity
    		,   BigDecimal::add); // accumulator
System.out.printf("Total close: %s\n", totalClose);
```            
All we are doing here is totalling every closing price.

In `map`, we _map_ from the stream to create a tuple.
In this case, we use the `getClose()` method to emit a singleton of `BigDecimal`.

In `reduce` we aggregate. 
And in this instance, we're adding.

Our `reduce` operation takes [two arguments](https://docs.oracle.com/javase/tutorial/collections/streams/reduction.html#reduce): 
* Identity
* Accumulator

The former is both the initial value of the sum _and_ the default value in case the mapping returns a null-value at any point in the stream.
That is, _zero_.

The latter is the part that adds the `BigDecimal` element to the running total of closing prices.

### Average Closing Price

To calculate any average, we need both a _total_ and a _count_.
We will again use `stream()` and return both these values.

```java
BigDecimal[] totalWithCount = historyGoogle.stream()
	.map(HistoricalQuote -> new BigDecimal[]{HistoricalQuote.getClose(), BigDecimal.ONE})
	.reduce(    new BigDecimal[]{BigDecimal.ZERO, BigDecimal.ZERO},         // identity
                (a,b) -> new BigDecimal[]{a[0].add(b[0]), a[1].add(b[1])}); // accumulator            
BigDecimal mean = totalWithCount[0].divide(totalWithCount[1], RoundingMode.HALF_UP);
System.out.println(mean);
```

#### Stream.map

Now in the `map` operation we have two values: 
* a closing price
* unity

When we emit from `map` to `reduce`, they are simply added to a running total and running count.

#### Stream.reduce

As before, `reduce` takes both _identity_ and _accumulator_ arguments.
But now, `map` is sending a pair of values.
So in both `reduce` arguments, we construct a `BigDecimal[]` and give it two elements.

As before, we use zero in _identity_.
But now, the _accumulator_ now has two parameters: `(a,b)`.
Where `a` is a two-element array which contains the running _total_ and _count_ in the first and second elements respectively.
Likewise, `b` is a two element array, but it contains the next two elements to add to `a`.

### Equal Weighted Variance

How would we go about computing a simple variance from the stream?

Suppose our variance is defined as:

$$
\sigma^2 = \frac{1}{n-1} \sum_{i=1}^n (x_i-\mu)^2
$$

Our method is defined as 
```java
public BigDecimal varianceEqualWeighted(List<HistoricalQuote> history, BigDecimal mean)
```

This requires that we have computed our _mean_ in a prior step.


```java
BigDecimal totalProduct = IntStream
            .range(0, history.size())
```

This time our stream is an instantiation of an `IntStream`, which we use to address the index of `history`.

```java
            .mapToObj(i -> history.get(i).getClose().subtract(mean))
            .map(bd -> bd.multiply(bd))
```
Now we map the difference between the mean and the closing price. 

Then we emit a tuple containing the square of the previous map.

```java
			.reduce(BigDecimal.ZERO, BigDecimal::add);
```

Next, we aggregate the square. `BigDecimal.ZERO` is our zero element, necessary for computing the partial total at the first element. 

```java
    return totalProduct.divide(new BigDecimal(history.size() - 1), RoundingMode.HALF_UP);
```

When all is said and done, we return `BigDecimal totalProduct` and divide it by the number of elements in the stream. We subtract 1 from this divisor to reduce error caused by bias.


## Yahoo!

And so we have it - a quick introduction to YahooFinanceAPI and a quick spin with Java 8 streams! Yeah! MapReduce!

## References

1. [YahooFinanceAPI](https://financequotes-api.com)
2. [Oracle Java Documentation: Reduction](https://docs.oracle.com/javase/tutorial/collections/streams/reduction.html)
3. [What Happened to Google Finance?](www.marketbeat.com/press-room/google-finance-changes-and-alternatives/)
4. [YahooFinanceAPI Documentation](https://financequotes-api.com/javadoc/yahoofinance/YahooFinance.html)
5. [How to average BigDecimals Streams: WillShackleford](https://stackoverflow.com/a/31882656)

## GitHub Repo

[https://github.com/Adrian-Ng/YahooFinance](https://github.com/Adrian-Ng/YahooFinance)






