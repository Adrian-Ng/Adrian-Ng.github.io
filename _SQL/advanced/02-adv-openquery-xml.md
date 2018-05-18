---
title: "SQL Advanced: Openqueries... and XML"
permalink: /SQL/Advanced/openquery-xml/
excerpt: "When XML can come to the rescue and make Openqueries even more fun in SQL"
#toc: true
classes: wide
---

## Intro

This is an unorthodox solution. And it came to me two years ago working on a problem that had very particular constraints.

The underlying idea is to use an `OPENQUERY` to send both a query and some XML to the remote server.
This makes for some very fast set-based filtering.

## Openquery

Openqueries (OQ) make pulling data from a remote server really fast by delegating processing duties to the remote server.
That is the `OPENQUERY` is executed remotely such that any transformation, filter, or what-have-you is performed _only_ onl the remote server..

If you query a table on a remote server without normally, the entire table is sent across _before_ any processing is performed. 
In other words, cross-server queries take much less time with `OPENQUERY`!

### with Where Clause

For example, I would query my remote server in this way:

```sql
SELECT
	*
FROM OPENQUERY([remoteServer],
	'	SELECT 
			FirstName
		,	LastName
		,	BankDetails 
		FROM BankDB.dbo.Customers 
		WHERE accountNo = 123456
	')
```

Notice how we have a query in single quotes. This is the query that is executed on `remoteServer`.
And because we're using a `WHERE` clause to specify that we only want to return a specific tuple, then only one tuple will be returned to the local server.

### Set-Based Filtering in Openquery

But what if I have more than one `acccountNo` that I need to pull from the remote server? 
What if I have a hundred?

First thing that probably comes to mind is to stick those accounts into a temp table and rewrite the openquery to perform matching the temp table... right?

Right! But that won't work. Remember - the openquery is executed remotely - far out of scope from where your temp table sits!

Ok - so use a user table - problem solved!
But that means the remote server is going to have to query that table on the local server - an openquery within an openquery?
This might work.

But for sake of argument, suppose you find yourself in a situation where you can't use a temp table, user table, nor stick every item into a really long `WHERE` clause.

Solution: Since the remote server is being sent a query, why not also include some data at the same time?
Why not bake this data into our `OPENQUERY` using XML?

### Using XML

Let's pretend we've got a hundred accounts in `#accountNo`.
In the first step, we express `#accountNo` as an XML string.

```sql
DECLARE @XMLStr varchar(max);
SELECT @XMLStr = (
		SELECT 
		accountNo AS a 
		FROM #accountNo AS [t] 
		FOR XML AUTO);
```
Our datatype is `varchar` (instead of `XML`) because we are using dynamic SQL.
But on the remote server, we will need an `XML` datatype because we will need to use `XML` methods to read the data using SQL DML.
So we read the `XML` like this:

```sql
DECLARE @xml xml;
SET @xml = @XMLStr;
SELECT
	Tbl.Col.value('@a','int') AS accountNo
FROM @xml.nodes('//t')Tbl(Col)
```

Next, we use  __dynamic SQL__ to pass the contents of  `@XMLStr` to the `OPENQUERY`.

```sql
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
		'')
	';
EXEC (@dSQL);
```

And so without _too much_ verbosity, we are able to filter an `OPENQUERY` using the contents of a temp table!


