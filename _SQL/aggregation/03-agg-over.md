---
title: "Aggregation: Over Clause"
permalink: /SQL/aggregation/over/
excerpt: "Aggregating with the Over Clause by Adrian Ng"
toc: false
---

Where do our users come from? How do we express the aggregation as a percentage?

```sql
SELECT
	Country
,	COUNT(*) AS Cnt
,	COUNT(*)*100.0/SUM(COUNT(*)) OVER() AS Pcnt
FROM	music.[User];
GROUP BY
	Country;
```
