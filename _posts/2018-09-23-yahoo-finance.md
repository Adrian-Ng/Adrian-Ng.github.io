---
layout: single
title: Fun with Yahoo Finance API
categories: java
---

## Google Finance API No More!

As of March 2018, something [happened](https://www.marketbeat.com/press-room/google-finance-changes-and-alternatives/) to Google Finance - it got taken to the chopping board and is now a miserable husk of its former self!
Long gone are the days where one could simply hook into the API and download a fat, juicy csv-file of historical stock price data.

Thankfully, there are many alternatives out there.

## Yahoo Finance!

Since I've been accessing the API through Java, I'm taking a look at the [YahooFinanceAPI](https://financequotes-api.com) library.


### Getting Historical Data

You can construct a `Stock` object such that it contains 5 years historical data.
Then use the `getHistory()` method to return a collection of 'HistoricalQuote' classes.

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
Looking at the [documentation](https://financequotes-api.com/javadoc/yahoofinance/YahooFinance.html) we can see that this method (and others like it) returns a `BigDecimal`.

### Stream()

If you want, you can use `stream()` instead of iterating through the collection.


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
In this case, we use the `getClose()` method to return a singleton of `BigDecimal`.

In `reduce` we are simply performing an aggregation, just like in any other reduce.
Here, we're adding.
`Reduce` takes two arguments: 
* Identity
* Accumulator

The former is both the initial value of the sum and the default value in case the mapping returns a null-value at any point in the stream.
That is, _zero_.

The latter is the part that adds the `BigDecimal` element to the partial sum.

### Average Closing Price


```java
BigDecimal[] totalWithCount = historyGoogle.stream()
	.map(HistoricalQuote -> new BigDecimal[]{HistoricalQuote.getClose(), BigDecimal.ONE})
	// a[] = partial sum array
    // b[] = to be added array
	.reduce(    new BigDecimal[]{BigDecimal.ZERO, BigDecimal.ZERO},         // identity
                (a,b) -> new BigDecimal[]{a[0].add(b[0]), a[1].add(b[1])});   // accumulator             
BigDecimal mean = totalWithCount[0].divide(totalWithCount[1], RoundingMode.HALF_UP);
System.out.println(mean);
```

To calculate any average, we need both a _total_ and a _count_.
Therefore, in this example we map two values: a singleton closing price and unity.
When these get passed to `reduce`, they are simply added to the partial sums of _total_ and _count_.

As before, `reduce` takes both _identity_ and _accumulator_ arguments.
But now, `map` is sending a pair of values.
So in both `reduce` arguments, we construct a `BigDecimal[]` and give it two elements.

As before, we use zero in _identity_.
But now, the _accumulator_ now has two parameters: `(a,b)`.
Where `a` is a two-element array which contains the running _total_ and _count_ in the first and second elements respectively.
Likewise, `b` is a two element array, but it contains the next two elements to add to `a`.

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




