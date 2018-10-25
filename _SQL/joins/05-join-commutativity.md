---
title: "Joins: Commutativity"
permalink: /SQL/joins/commutativity/
excerpt: "What is commutativity in joins?"
toc: true
mathjax: true
---

When an operation is __commutative__, the _ordering_ of elements does not matter.

Addition and multiplication are both commutative. You can change the order of the elements. The result is always the same.

## Addition

$$
1 + 2 + 3 = 6\\
3 + 2 + 1 = 6\\
$$

## Multiplication

$$
1 \times 2 \times 3 = 6\\
3 \times 2 \times 1 = 6\\
$$


## SQL

### Inner Join

```sql
A INNER JOIN B = B INNER JOIN A
```

### Left/Right Join

Left/Right joins are not commutative.

That is 
```sql
A LEFT JOIN B <> B LEFT JOIN A
```
But:

```sql
A LEFT JOIN B = B RIGHT JOIN A
```


## References
http://blog.ylett.com/2011/09/non-associativity-of-sql-table-joins.html
http://www.sql-tutorial.ru/en/book_explicit_join_operations/page4.html