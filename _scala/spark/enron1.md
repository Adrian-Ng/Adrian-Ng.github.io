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

I downloaded Apache Spark from here: [spark.apache.org/downloads.html](spark.apache.org/downloads.html).
and installed it via terminal:

```bash
wget http://mirrors.ukfast.co.uk/sites/ftp.apache.org/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
#unzip and set symlink
sudo tar -xvzf spark-2.4.0-bin-hadoop2.7.tgz -C /opt
sudo ln -s spark-2.4.0-bin-hadoop2.7 /opt/spark
```

To launch the REPL, run the following in the terminal:
```bash
/opt/spark/bin/spark-shell 
```


Pull Enron data from HDFS.
```scala
val seq20 = sc.wholeTextFiles("hdfs://localhost:54310/user/hduser/in/enron20.seq").first._2.split("\n\n").filter(line => line.contains("Date:"))
```


and then I define a Scala function. This function scrapes each email and via _Regex_, parses the following info:
* sender
* recipient
* date 

```scala
def emitRecipTriplet (email:String) : Seq[String] = {
	// These prefixes denote recipients.
	var recipPrefix = Seq("To:","Cc:","Bcc:") 
	
	// Parse sender
	val sender = email.replace("\n\t","").split("\n").filter(line => line.startsWith("From:"))(0).substring(6).trim()

	//Parse Date
	val date = email.replace("\n\t","").split("\n").filter(line => line.startsWith("Date:"))(0).substring(6).trim() 

	// this comprehension is an anonymous function that returns a Seq of recipients. It's pretty good.
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
