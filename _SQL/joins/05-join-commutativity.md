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
3 + 1 + 2 = 6
$$

## Multiplication

$$
1 \times 2 \times 3 = 6\\
3 \times 2 \times 1 = 6\\
3 \times 1 \times 2 = 6
$$


## Inner Join

Similarly, the below are equivalent

```sql
A INNER JOIN B
B INNER JOIN A
```

