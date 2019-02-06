---
title: "Scraping the Enron Corpus via Spark REPL"
permalink: /scala/spark/enron1/
excerpt: "Scraping the Enron Corpus via Spark REPL"
toc: true
mathjax: true
---

## Intro

I wrote a number of _Apache Hadoop_ applications in Java. I found writing these applications a frustrating exercise in verbosity.

One in particular involved some data mining of the _Enron Corpus_. This is my so-called _Timeslicer_, which can be found on GitHub.

On this page, I will attempt to do the same in `spark`. To accomplish this, I've downloaded and installed it on top of my `Hadoop` installation. As such, Spark can simply pull data from HDFS, where all my Enron data already lives.

## Installation

I downloaded _Apache Spark_ from here: [spark.apache.org/downloads.html](spark.apache.org/downloads.html).
and installed like so:

```bash
wget http://mirrors.ukfast.co.uk/sites/ftp.apache.org/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
#unzip and set symlink
sudo tar -xvzf spark-2.4.0-bin-hadoop2.7.tgz -C /opt
sudo ln -s spark-2.4.0-bin-hadoop2.7 /opt/spark
```

To launch the _REPL_, run the following in the terminal:
```bash
/opt/spark/bin/spark-shell 
```

You'll see something like this:

```bash
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /___/ .__/\_,_/_/ /_/\_\   version 2.4.0
      /_/

Using Scala version 2.11.12 (OpenJDK 64-Bit Server VM, Java 10.0.2)
Type in expressions to have them evaluated.
Type :help for more information.

scala>
```
Note: it's `:quit` to quit the REPL.

## Data Pull

Now we can pull data from _HDFS_.

```scala
val seq20 = sc.wholeTextFiles("hdfs://localhost:54310/user/hduser/in/enron20.seq").
    first.
    _2.
    split("\n\n").
    filter(line => line.contains("Date:"))
```

`sc.wholetextfiles` returns a Resilient Distributed Dataset (RDD), which is _Scala_'s primary abstraction. RDDs contain a key and a value, where the key is the file path.

Since we are only interested in the value, we specify `_2` to indicate the second column index.

This file contains only one tuple (=line). As such, `first` is redundant but nonetheless we can split and filter such that each block of email header is on its own line.

This would look something like:

```
Date: Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
From: mark.rodriguez@enron.com
To: george.mcclellan@enron.com, daniel.reck@enron.com, stuart.staley@enron.com,
 michael.beyer@enron.com, kevin.mcgowan@enron.com,
 jeffrey.shankman@enron.com, mike.mcconnell@enron.com,
 paula.harris@enron.com
Subject: Hotsheet Update
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: Mark Anthony Rodriguez
X-To: George McClellan, Daniel Reck, Stuart Staley, Michael J Beyer, Kevin McGowan, Jeffrey A Shankman, Mike McConnell, Paula Harris
X-cc:
X-bcc:
X-Folder: \Mark_McConnell_June2001\N..
```

## Parsing 

We are interested in scraping three bits of information:

* sender
* recipient
* date 

Let's look at how to do this in a single email. Given that `seq20` contains a number of emails, we can 

```scala
val email = seq20(0)
```

### Sender

```scala
val sender = email.replace("\n\t","").
    split("\n").
    filter(line => line.startsWith("From:"))(0).
    substring(6).
    trim()
```

### Date

```scala
val date = email.
    replace("\n\t","").
    split("\n").
    filter(line => line.startsWith("Date:"))(0).
    substring(6).
    trim() 
```

### Recipients

A recipient is denoted in multiple ways:

* To:
* Cc:
* Bcc:

We want to scrape all these prefixes. So I just throw these in a collection:

```scala
val recipPrefix = Seq("To:","Cc:","Bcc:")
```

I want to iterate through each prefix and scrape the header. We can do this via an anonymous function known as a _For Comprehension_. I suppose this is analogous to a _List Comprehension_ in Python, _apply_ in R, and _lambda_ in Java.

This is the end result:

```scala
	val recipientSeq = (
		for {
		prefix <- recipPrefix
		x <- email. // this is a flatmap
			replace("\n\t","").
			split("\n").
			filter(line => line.startsWith(prefix)).
			collect { case s if (s.contains(":")) =>
				s.substring(prefix.length + 1)
			}
		y <- x.split(", ") //another flatmap
		} yield 
		{
			y
		}// comprehension "body"	
	).toSet.toSeq
```
This returns a `Seq` of email addresses. It looks like:

```
recipientSeq: Seq[String] = ArrayBuffer(michael.beyer@enron.com, kevin.mcgowan@enron.com, stuart.staley@enron.com, george.mcclellan@enron.com, mike.mcconnell@enron.com, paula.harris@enron.com, jeffrey.shankman@enron.com, daniel.reck@enron.com)
```

## Encapsulation

We can wrap all of the above in a function:

```scala
def emitRecipTriplet (email:String) : Seq[String] = {
	// These prefixes denote recipients.
	val recipPrefix = Seq("To:","Cc:","Bcc:") 
	
	// Parse sender
	val sender = email.replace("\n\t","").split("\n").filter(line => line.startsWith("From:"))(0).substring(6).trim()

	//Parse Date
	val date = email.replace("\n\t","").split("\n").filter(line => line.startsWith("Date:"))(0).substring(6).trim() 

	// For Comprehension. Parse Recipients
	val recipientSeq = (
		for {
		prefix <- recipPrefix
		x <- email. // this is a flatmap
			replace("\n\t","").
			split("\n").
			filter(line => line.startsWith(prefix)).
			collect { case s if (s.contains(":")) =>
				s.substring(prefix.length + 1)
			}
		y <- x.split(", ") //another flatmap
		} yield 
		{
			y
		}// comprehension "body"	
	).toSet.toSeq
		
	return recipientSeq.map(r => sender + "\t" + r + "\t" + date)
}
```

This function takes a single email as input. For each input, it returns a collection (Seq) of tuples.
Each tuple would look like:
```
from:			to:				date:
bill.cordes@enron.com	mike.mcconnell@enron.com	Mon, 24 Jul 2000 00:28:00 -0700 (PDT)
```

Given that each line in the data represents an email, we need to use a `For Comprehension` to iterate through the email corpus and add each output to a mutable collection, `buf`.

```scala
val buf = scala.collection.mutable.ListBuffer.empty[String]

for(email <- seq20) {
	buf ++= emitRecipTriplet(email)
}
```
`++=` lets me add (union?) a collection to a collection. In this case, I'm adding a `Seq` to a `ListBuffer`. Each element in `buf` is a `String` and not a `Seq` (I didn't believe it myself, so I checked).


Lastly, I sort the collection, cast to RDD type and save in HDFS.

```scala
val enronRDD = sc.parallelize(buf.sorted)
enronRDD.saveAsTextFile("hdfs://localhost:54310/user/hduser/out/enronRDD1")
```
Problem with this is it does not overwrite. I'll have to write this in terminal:

```bash
hadoop fs -rm -r /user/hduser/out/enronRDD1/
```

Also, I think `hadoop fs` is deprecated - I will have to fix that!
