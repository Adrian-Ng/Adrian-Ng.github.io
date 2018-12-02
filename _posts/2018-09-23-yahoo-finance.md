---
layout: single
title: Fun with Yahoo Finance API
permalink: /java/yahoofinance/
excerpt: "As of March 2018, something happened to Google Finance - it got taken to the chopping board and is now a miserable husk of its former self!
Long gone are the days where one could simply hook into the API and download a fat, juicy csv-file of historical stock price data... or a sensible JSON of option prices.

Thankfully, there are many alternatives out there."
categories: java
classes: wide
header:
  image: /assets/images/splash/yahoofinance.jpg
  caption: "Photo credit: Mt Rinjani, Lombok - Adrian Ng 2014"
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

### Stream()

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

In `map`, we simply specify what data we want to reduce.
In this case, we use the `getClose()` method to emit a singleton of `BigDecimal`.

In `reduce` we aggregate. 
And in this instance, we're adding.

Our `reduce` operation takes [two arguments](https://docs.oracle.com/javase/tutorial/collections/streams/reduction.html#reduce): 
* Identity
* Accumulator

The former is both the initial value of the sum _and_ the default value in case the mapping returns a null-value at any point in the stream.
That is, _zero_.

The latter is the part that adds the `BigDecimal` element to the running total of closing prices.

### Averaging Closing Price

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

## Yahoo!

And so we have it - a quick introduction to YahooFinanceAPI and a quick spin with Java 8 streams! Yeah! MapReduce!

## References

1. [YahooFinanceAPI](https://financequotes-api.com)
2. [Oracle Java Documentation: Reduction](https://docs.oracle.com/javase/tutorial/collections/streams/reduction.html)
3. [What Happened to Google Finance?](www.marketbeat.com/press-room/google-finance-changes-and-alternatives/)
4. [YahooFinanceAPI Documentation](https://financequotes-api.com/javadoc/yahoofinance/YahooFinance.html)
5. [How to average BigDecimals Streams: WillShackleford](https://stackoverflow.com/a/31882656)

## Appendix

```java
import yahoofinance.Stock;
import yahoofinance.YahooFinance;
import yahoofinance.histquotes.HistoricalQuote;
import yahoofinance.histquotes.Interval;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Calendar;
import java.util.List;

/**
 * Created by Adrian on 21/09/2018.
 */
public class YahooAPI {

    public static void printClose(List<HistoricalQuote> historyGoogle){
        for(HistoricalQuote historicalQuote : historyGoogle)
            System.out.println(historicalQuote.getClose());
    }

    public static void printTotal(List<HistoricalQuote> historyGoogle){
        BigDecimal totalClose = historyGoogle
                .stream()
                .map(HistoricalQuote::getClose)
                .reduce(    BigDecimal.ZERO // identity
                        ,   BigDecimal::add); // accumulator
        System.out.printf("Total close: %s\n", totalClose);
    }

    public static void printMean(List<HistoricalQuote> historyGoogle){
        //https://stackoverflow.com/questions/31881561/how-to-average-bigdecimals-using-streams
        BigDecimal[] totalWithCount = historyGoogle.stream()
                .map(HistoricalQuote -> new BigDecimal[]{HistoricalQuote.getClose(), BigDecimal.ONE})
                // accumulator only
                // a[] = partial sum array
                // b[] = to be added array
                .reduce(    new BigDecimal[]{BigDecimal.ZERO, BigDecimal.ZERO},     // identity
                        (a,b) -> new BigDecimal[]{a[0].add(b[0]), a[1].add(b[1])}   // accumulator
                );
        BigDecimal mean = totalWithCount[0].divide(totalWithCount[1], RoundingMode.HALF_UP);
        System.out.println(mean);
    }


    public static void main(String[] args){

        Calendar from = Calendar.getInstance();
        Calendar to = Calendar.getInstance();
        from.add(Calendar.YEAR, -5); // from 5 years ago

        try{
            Stock google = YahooFinance.get("GOOG", from, to, Interval.DAILY);
            List<HistoricalQuote> historyGoogle = google.getHistory();

            printClose(historyGoogle);
            printTotal(historyGoogle);
            printMean(historyGoogle);
        } catch (IOException e){
            e.printStackTrace();
        }

    }

}
```




