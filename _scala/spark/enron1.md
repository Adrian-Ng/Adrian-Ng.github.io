---
title: "Scraping the Enron Corpus via Spark REPL"
permalink: /scala/enron1/
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
Note: it's `:quit` to quit the REPL. `ctrl-c` works too. If you're like me, you'll find yourself inadvertently quitting the REPL when attempting to copy some lines.

### VS Code

I find it convenient to write my `Scala` in _VS Code_ and take advantage of the built-in terminal. In this environment, I can simply highlight some code and hit a keybind of my chosing to run it in terminal. I've bound `alt-X` to do this as it's what I'm familiar with from using _SQL Server_.

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

## Parsing 

We are interested in scraping three bits of information:

* sender
* recipient
* date 

Let's look at how to do this in a single email. Given that `Seq` types are indexed, we just write:

```scala
val email = seq20(1)
```
This returns the second email in this collection, which looks like:

```
M.A.
??????? ?folder-2???�Message-ID: <4152796.1075843929751.JavaMail.evans@thyme>
Date: Sun, 29 Apr 2001 11:54:00 -0700 (PDT)
From: george.mcclellan@enron.com
To: sven.becker@enron.com
Subject: RE: Summary on Bremen Deal
Cc: stuart.staley@enron.com, manfred.ungethum@enron.com,
 mike.mcconnell@enron.com, jeffrey.shankman@enron.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: quoted-printable
Bcc: stuart.staley@enron.com, manfred.ungethum@enron.com,
 mike.mcconnell@enron.com, jeffrey.shankman@enron.com
X-From: George Mcclellan
X-To: Sven Becker
X-cc: Stuart Staley, Manfred Ungethum, Mike McConnell, Jeffrey A Shankman
X-bcc:
X-Folder: \Mark_McConnell_June2001\Notes Folders\Coal
X-Origin: MCCONNELL-M
X-FileName: mmcconn.nsf
```


### Singleton Fields

To scrape the sender and date, we look for either `From: ` and `Date: ` and scrape the remainer of the line:

#### From

```scala
val sender = email.replace("\n\t","").
    split("\n").
    filter(line => line.startsWith("From:"))(0).
    substring(6).
    trim()
```

#### Date

```scala
val date = email.
    replace("\n\t","").
    split("\n").
    filter(line => line.startsWith("Date:"))(0).
    substring(6).
    trim() 
```

### Multiple Elements

A recipient is denoted in multiple ways:

* To:
* Cc:
* Bcc:

We want to scrape all these prefixes. So I just throw these in a collection:

```scala
val recipPrefix = Seq("To:","Cc:","Bcc:")
```
So we want to iterate through each prefix and scrape the header. We can do this via an anonymous function known as a _For Comprehension_. I suppose this is analogous to a _List Comprehension_ in Python, _apply_ in R, and _lambda_ in Java.

The below is an example of _For Comprehension_

```scala
for (prefix <- recipPrefix){
	println(prefix)
}
```

It iterates through `recipPrefix` and prints each element:

```
To:
Cc:
Bcc:
```

But if I want it to return something (instead of printing), I can write `yield`:

```scala
for (prefix <- recipPrefix) yield{
	prefix
}
```
This will return the same type as the input. In this case, `Seq`.

Now we can perform a similar regex as before:

```scala
for (prefix <- recipPrefix) yield{
	email.
	replace("\n\t","").
	split("\n").
	filter(line => line.startsWith(prefix))
}
```
This returns a `Seq` of three elements (one for each prefix).


```
res0: Seq[Array[String]] = List(Array(To: george.mcclellan@enron.com, daniel.reck@enron.com, stuart.staley@enron.com, michael.beyer@enron.com, kevin.mcgowan@enron.com, jeffrey.shankman@enron.com, mike.mcconnell@enron.com, paula.harris@enron.com), Array(), Array())
```
There are some issues with this output

* Each element is of type `Array[String]`. This is due to our use of `split()`. 
* Notice how some of these arrays are empty. This is because `Cc: ` and `Bcc: ` prefixes for this email did not appear in the header (because those fields had not been populated).
* Lastly, the prefixes have not yet been removed from the string. I.e., `To:` is still present in the first element.

Let's first tackle the last bullet first. As with any _regex_ problem like this, we can solve with `substring()`, which returns a smaller portion of the string -- a _substring_!

```scala
val recipients =  for (prefix <- recipPrefix) yield{
	email.
	replace("\n\t","").
	split("\n").
	filter(line => line.startsWith(prefix)).
	map(_.substring(prefix.length + 1)).
}
```

```
recipients: Seq[Array[String]] = List(Array(sven.becker@enron.com), Array(stuart.staley@enron.com, manfred.ungethum@enron.com, mike.mcconnell@enron.com, jeffrey.shankman@enron.com), Array(stuart.staley@enron.com, manfred.ungethum@enron.com, mike.mcconnell@enron.com, jeffrey.shankman@enron.com))
```
Great, the prefix no longer appears in each `Array[String]`.

### Nested For Comprehension

A `For Comprehension` translates to:

```scala
recipPrefix.forEach(prefix => println(prefix))
```
Indeed, we could have nested `For Comprehension`. This is especially useful in our case, as we now need to loop through each element in `Array[String]` and `split()` it:

```scala
val recipients =  for {
	prefix <- recipPrefix
	x <- email.
		replace("\n\t","").
		split("\n").
		filter(line => line.startsWith(prefix)).
		map(_.substring(prefix.length + 1))
	y <- x.split(", ")
	}
	yield{
	y
}
```

```
recipients: Seq[String] = List(sven.becker@enron.com, stuart.staley@enron.com, manfred.ungethum@enron.com, mike.mcconnell@enron.com, jeffrey.shankman@enron.com,stuart.staley@enron.com, manfred.ungethum@enron.com, mike.mcconnell@enron.com, jeffrey.shankman@enron.com)
```

We cast (over the entire comprehension) to `Set` to remove duplicates and then cast back to `Seq`. the final `For Comprehension` is written thus:

```scala
val recipientSeq = (
for {
	prefix <- recipPrefix
	x <- email. // this is a forEach -- iterating through Seq
		replace("\n\t","").
		split("\n").
		filter(line => line.startsWith(prefix)).
		map(_.substring(prefix.length + 1))
		// the below also worked in place of map()
		// collect { case s if (s.contains(":")) =>
			//s.substring(prefix.length + 1)
	y <- x.split(", ") //another forEach -- iterating through Array[String]
} yield 
{
	y	// return y
}
).toSet.toSeq // cast remove duplicates and cast again to initial type
```
It looks like:

```
recipientSeq: Seq[String] = ArrayBuffer(stuart.staley@enron.com, mike.mcconnell@enron.com, jeffrey.shankman@enron.com, sven.becker@enron.com, manfred.ungethum@enron.com)
```
This returns nine unique email address!

```
scala> recipients.size
res19: Int = 9
```

## Encapsulation

We can wrap all of the above in a class:

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
			map(_.substring(prefix.length + 1))
		y <- x.split(", ") //another flatmap
		} yield 
		{
			y
		}// comprehension "body"	
	).toSet.toSeq
		
	return recipientSeq.map(r => sender + "\t" + r + "\t" + date)
}
```

This class takes a single email as input. For each input, it returns a collection (Seq) of tuples.
Each tuple would look like:
```
from:			to:				date:
bill.cordes@enron.com	mike.mcconnell@enron.com	Mon, 24 Jul 2000 00:28:00 -0700 (PDT)
```

Now we can use this class to iterate and scrape entire corpus.

```scala
val buf = scala.collection.mutable.ListBuffer.empty[String]

for(email <- seq20) {
	buf ++= emitRecipTriplet(email)
}
```
`++=` lets me add (union?) a collection to a collection. In this case, I'm adding a `Seq` to a `ListBuffer`. Each element in `buf` is a `String` and not a `Seq` (I didn't believe it myself, so I checked).

```scala
for (tuple <- buf){
	println(tuple)
}
```

```
mark.rodriguez@enron.com        michael.beyer@enron.com Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
mark.rodriguez@enron.com        kevin.mcgowan@enron.com Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
mark.rodriguez@enron.com        stuart.staley@enron.com Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
mark.rodriguez@enron.com        george.mcclellan@enron.com      Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
mark.rodriguez@enron.com        mike.mcconnell@enron.com        Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
mark.rodriguez@enron.com        paula.harris@enron.com  Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
mark.rodriguez@enron.com        jeffrey.shankman@enron.com      Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
mark.rodriguez@enron.com        daniel.reck@enron.com   Mon, 28 Aug 2000 06:57:00 -0700 (PDT)
george.mcclellan@enron.com      stuart.staley@enron.com Sun, 29 Apr 2001 11:54:00 -0700 (PDT)
george.mcclellan@enron.com      mike.mcconnell@enron.com        Sun, 29 Apr 2001 11:54:00 -0700 (PDT)
george.mcclellan@enron.com      jeffrey.shankman@enron.com      Sun, 29 Apr 2001 11:54:00 -0700 (PDT)
george.mcclellan@enron.com      sven.becker@enron.com   Sun, 29 Apr 2001 11:54:00 -0700 (PDT)
george.mcclellan@enron.com      manfred.ungethum@enron.com      Sun, 29 Apr 2001 11:54:00 -0700 (PDT)
stuart.staley@enron.com mike.mcconnell@enron.com        Fri, 4 May 2001 09:10:00 -0700 (PDT)
stuart.staley@enron.com jeffrey.shankman@enron.com      Fri, 4 May 2001 09:10:00 -0700 (PDT)
stuart.staley@enron.com george.mcclellan@enron.com      Sun, 3 Dec 2000 14:59:00 -0800 (PST)
stuart.staley@enron.com jeffrey.shankman@enron.com      Sun, 3 Dec 2000 14:59:00 -0800 (PST)
stuart.staley@enron.com mike.mcconnell@enron.com        Sun, 3 Dec 2000 14:59:00 -0800 (PST)
george.mcclellan@enron.com      michael.beyer@enron.com Mon, 31 Jul 2000 05:48:00 -0700 (PDT)
george.mcclellan@enron.com      kevin.mcgowan@enron.com Mon, 31 Jul 2000 05:48:00 -0700 (PDT)
george.mcclellan@enron.com      stuart.staley@enron.com Mon, 31 Jul 2000 05:48:00 -0700 (PDT)
george.mcclellan@enron.com      mike.mcconnell@enron.com        Mon, 31 Jul 2000 05:48:00 -0700 (PDT)
george.mcclellan@enron.com      jeffrey.shankman@enron.com      Mon, 31 Jul 2000 05:48:00 -0700 (PDT)
george.mcclellan@enron.com      daniel.reck@enron.com   Mon, 31 Jul 2000 05:48:00 -0700 (PDT)
george.mcclellan@enron.com      jordan.mintz@enron.com  Sat, 16 Sep 2000 03:00:00 -0700 (PDT)
george.mcclellan@enron.com      angie.collins@enron.com Sat, 16 Sep 2000 03:00:00 -0700 (PDT)
george.mcclellan@enron.com      matthew.arnold@enron.com        Sat, 16 Sep 2000 03:00:00 -0700 (PDT)
george.mcclellan@enron.com      mike.mcconnell@enron.com        Sat, 16 Sep 2000 03:00:00 -0700 (PDT)
george.mcclellan@enron.com      jeffrey.shankman@enron.com      Sat, 16 Sep 2000 03:00:00 -0700 (PDT)
george.mcclellan@enron.com      daniel.reck@enron.com   Sat, 16 Sep 2000 03:00:00 -0700 (PDT)
george.mcclellan@enron.com      michael.beyer@enron.com Fri, 1 Sep 2000 06:04:00 -0700 (PDT)
george.mcclellan@enron.com      tom.kearney@enron.com   Fri, 1 Sep 2000 06:04:00 -0700 (PDT)
george.mcclellan@enron.com      kevin.mcgowan@enron.com Fri, 1 Sep 2000 06:04:00 -0700 (PDT)
george.mcclellan@enron.com      stuart.staley@enron.com Fri, 1 Sep 2000 06:04:00 -0700 (PDT)
george.mcclellan@enron.com      mike.mcconnell@enron.com        Fri, 1 Sep 2000 06:04:00 -0700 (PDT)
george.mcclellan@enron.com      jeffrey.shankman@enron.com      Fri, 1 Sep 2000 06:04:00 -0700 (PDT)
george.mcclellan@enron.com      daniel.reck@enron.com   Fri, 1 Sep 2000 06:04:00 -0700 (PDT)
george.mcclellan@enron.com      mike.mcconnell@enron.com        Thu, 30 Nov 2000 07:19:00 -0800 (PST)
george.mcclellan@enron.com      jeffrey.shankman@enron.com      Thu, 30 Nov 2000 07:19:00 -0800 (PST)
mary.joyce@enron.com    mike.mcconnell@enron.com        Mon, 11 Sep 2000 02:13:00 -0700 (PDT)
d.hall@enron.com        mike.mcconnell@enron.com        Thu, 24 Aug 2000 00:40:00 -0700 (PDT)
d.hall@enron.com        cathy.phillips@enron.com        Thu, 24 Aug 2000 00:40:00 -0700 (PDT)
cathy.phillips@enron.com        mike.mcconnell@enron.com        Thu, 7 Sep 2000 13:15:00 -0700 (PDT)
cathy.phillips@enron.com        deb.gebhardt@enron.com  Thu, 7 Sep 2000 13:15:00 -0700 (PDT)
jay.hatfield@enron.com  mike.mcconnell@enron.com        Mon, 11 Sep 2000 02:04:00 -0700 (PDT)
bill.cordes@enron.com   mike.mcconnell@enron.com        Mon, 24 Jul 2000 00:28:00 -0700 (PDT)
enron.announcements@enron.com   all.houston@enron.com   Fri, 8 Sep 2000 14:59:00 -0700 (PDT)
john.haggerty@enron.com mike.mcconnell@enron.com        Sun, 10 Sep 2000 01:13:00 -0700 (PDT)
john.nowlan@enron.com   jeffrey.shankman@enron.com      Thu, 21 Sep 2000 10:25:00 -0700 (PDT)
john.nowlan@enron.com   mike.mcconnell@enron.com        Thu, 21 Sep 2000 10:25:00 -0700 (PDT)
```

Lastly, I sort the collection, cast to RDD type and save in HDFS.

```scala
val enronRDD = sc.parallelize(buf.sorted)
enronRDD.saveAsTextFile("hdfs://localhost:54310/user/hduser/out/enronRDD1")
```
Problem with this is it does not overwrite. I'll have to write this in terminal:

```bash
hdfs dfs -rm -r /user/hduser/out/enronRDD1/
```


