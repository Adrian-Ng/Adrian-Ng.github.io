---
title: "SQL Advanced: Openqueries... and XML"
permalink: /SQL/Advanced/openquery-xml/
excerpt: "When XML can come to the rescue and make Openqueries even more fun in SQL"
#toc: true
classes: wide
---

## Openquery

Openqueries (OQ) make pulling data from a remote server really fast by delegating processing duties to the remote server.
That is, the query you write in your OQ will be executed remotely such that any transformations, filtering, or what-have-you occur before any data is sent to the local server.

If you query a remote server without the openquery, the entire table is sent across _before_ any processing is performed. 
In other words, cross-server queries take much less time with `OPENQUERY`!.

### with Where Clause

For example, I would query my remote server in this way:

```
SELECT
	*
FROM OPENQUERY([remoteServer],'SELECT FirstName, LastName, BankDetails FROM CorpBank.dbo.Customers WHERE accountNo = 123456')
```

Notice how I've got a query in single quotes within a query. That is the query that gets passed to `remoteServer` and executed.
And because we're using a `WHERE` clause to specify that I only want to return a specific tuple, then only one tuple will be returned to the local server.

### with XML

But what if I have more than one `acccountNo` that need to pull from the remote server? 
What if I have a hundred?

First thing that probably comes to mind is to stick those accounts into a temp table and rewrite the openquery to only rows that match to the temp table... right?

Right! But that won't work. Remember - the openquery is executed remotely - far out of scope from where your temp table sits!

Ok - so use a user table - problem solved!
But that means the remote server is going to have to query that table on the local server - an openquery within an openquery?
This might work.

But for sake of argument, suppose you find yourself in a situation where you can't use a temp table, user table, nor stick every item into a really long `WHERE` clause.
Then we might want to try using XML.

### Using XML

Let's pretend we've got a hundred accounts in a temp table `#accountNo`.
In the first step, we convert this `#accountNo to an XML string `@XMLStr`.

```
DECLARE @XMLStr varchar(max);
SELECT @XMLStr = (
		SELECT 
		accountNo AS a 
		FROM #accountNo AS [t] 
		FOR XML AUTO);
```

Next, we use  __dynamic SQL__ to pass the contents of  `@XMLStr' to the `OPENQUERY`.

```
DECLARE @dSQL varchar(max);

SET @dSQL = '
		SELECT 
			*
		FROM OPENQUERY([remoteServer],''
						DECLARE @xml xml
						SET @xml = ''''' + @XMLStr + ''''';
						WITH [cteXML] AS (
							SELECT
								Tbl.Col.value(''''@a'''',''''int'''') AS accountNo
							FROM @xml.nodes(''''//t'''')Tbl(Col)
							)
						SELECT
							FirstName
						,	LastName
						,	BankDetails
						FROM [BankDB].[dbo].[Customer] AS [c]
						WHERE EXISTS (SELECT 1 FROM [cteXML] WHERE [c].[accountNo] = [accountNo]
		'')'
```

And so without _too much_ verbosity, we are able to filter an `OPENQUERY` using the contents of a temp table!


