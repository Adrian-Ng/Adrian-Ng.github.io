---
title: "DDL: Truncate"
permalink: /SQL/ddl/truncate/
excerpt: "A look at Alter Statements in SQL by Adrian Ng"
toc: true
---

`TRUNCATE` will do two things for you:
1) Drop your table
2) Recreate your table

This is handy, but be aware that because this is a DDL, it can't be rolled back like `DELETE`, which is DML.

```sql
TRUNCATE TABLE dbo.Songs;
```
