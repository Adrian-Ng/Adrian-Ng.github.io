---
title: "Joins: Associativity"
permalink: /SQL/joins/associativity/
excerpt: "What is associativity in joins?"
toc: true
mathjax: true
---

When an operation is __associative__, the _grouping_ of elements does not matter.

Addition and multiplication are both associative. You can add brackets or remove brackets. The result is always the same.

## Addition

$$
(1 + 2) + 3 = 6\\
3 + (2 + 1) = 6\\
3 + 2 + 1 = 6
$$

## Multiplication

$$
(3 \times 2) \times 1 = 6\\
3 \times (2 \times 1) = 6\\
3 \times 2 \times 1 = 6
$$


## SQL Joins

SQL Joins are associative when they are of the same type

### Inner Join Only

```sql
(A INNER JOIN B) INNER JOIN C = A INNER JOIN (B INNER JOIN C) = A INNER JOIN B INNER JOIN C
```
### Left Join Only

```sql
(A LEFT JOIN B) LEFT JOIN C = A LEFT JOIN (B LEFT JOIN C) = A LEFT JOIN B LEFT JOIN C
```




