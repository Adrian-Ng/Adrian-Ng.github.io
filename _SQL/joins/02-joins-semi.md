---
title: "Joins: Semi"
permalink: /SQL/joins/semi/
excerpt: "A look at the various semi joins in SQL by Adrian Ng"
toc: true
---

## SEMI-JOINS

These lack the _syntactic sugar_ of the cartesian joins.
But funnily enough I find that the syntax of semi-joins tends to more natural human language.

Another big upside is that they are **faster** than cartesian joins.

There are just two types of semi-joins that I am interested in.

### LEFT SEMI JOIN

Use case:
* Values in your joining field exist in both tables.
* You _only_ want to return columns from the left table.
* Speed is a concern (when isn't it?)

```sql
SELECT
	*
FROM [leftTable] AS left
WHERE EXISTS (SELECT 1 FROM [rightTable] WHERE left.ID = ID)
```

### LEFT ANTI SEMI JOIN

Use case is same as the above except you're returning rows where values in your joining field _don't match_.

```sql
SELECT
	*
FROM [leftTable] AS left
WHERE NOT EXISTS (SELECT 1 FROM [rightTable] WHERE left.ID = ID)
```

