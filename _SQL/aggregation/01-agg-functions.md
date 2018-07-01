---
"Aggregation: Functions"
permalink: /SQL/aggregation/functions/
excerpt: "Aggregation functions by Adrian Ng"
toc: false
---


## Intro

Let's take look at some aggregation functions!

Such as these...

* COUNT()
* SUM()

... and these

* AVG()
* MAX()
* MIN()

### COUNT

How many accounts do we have in our music database?

```sql
SELECT 
	COUNT(*)
FROM music.Account
```





