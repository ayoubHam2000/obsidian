### File

Ginkgo supports **multiple matrix file formats**, but the most commonly used and recommended one is the **Matrix Market (.mtx)** format.  
Ginkgo examples and tutorials almost always use `.mtx` files because they are simple, portable, and widely used in sparse linear algebra.

```
%%MatrixMarket matrix coordinate real general
% optional comments (start with %)
<rows> <columns> <nonzeros>
row col value
row col value
row col value
...
```

```
%%MatrixMarket matrix coordinate real general
```
- **matrix** → this file contains a matrix
- **coordinate** → sparse (list of nonzeros)
- **real** → values are real numbers
- **general** → matrix has no symmetry (all entries explicit)

```
%%MatrixMarket matrix array real general
```

- **matrix**	→This is a matrix
- **array**	→Dense format, stored element-by-element
- **real**	          →Real-valued numbers
- **general**	→No symmetry / fully general

```
%%MatrixMarket matrix coordinate real general
% This is a comment
3 3 4
1 1 2.0
1 3 -1.0
2 1 4.0
2 2 3.0
3 3 5.0
```

---

| Token            | Meaning                                                    |     |
| ---------------- | ---------------------------------------------------------- | --- |
| `%%MatrixMarket` | Required prefix (always the same)                          |     |
| `matrix`         | Indicates this file contains a matrix                      |     |
| `<storage>`      | How the matrix is stored (array or coordinate)             |     |
| `<datatype>`     | Type of numeric values (real, complex, integer, pattern)   |     |
| `<symmetry>`     | Whether the matrix has symmetry (general, symmetric, etc.) |     |

> coordinate
```
%%MatrixMarket matrix coordinate real general
5 5 3
1 1 10
3 4 -2
5 2 4
```
Meaning: 5×5 matrix with 3 nonzero entries.

> array
```
%%MatrixMarket matrix array real general
3 1
1
2
3
```
Meaning: 3×1 matrix

> Datatype

|Field|Means|
|---|---|
|`real`|Real numbers (float/double)|
|`complex`|Complex numbers (a+bi)|
|`integer`|Integer values|
|`pattern`|Only the structure is given (no values)|
> general

No symmetry; matrix entries are listed normally.
> symmetric

Only the **upper or lower** triangular part is stored. The parser **mirrors** them.

---
### Reading 

```python
from scipy.io import mmread

A = mmread("data/A.mtx")  
b = mmread("data/b.mtx")  
x = mmread("data/x0.mtx")  
# print(A.row, A.col, A.data)
```

### Timing

```c
auto start = std::chrono::high_resolution_clock::now();  
ilu_gmres->apply(b, x);  
auto end = std::chrono::high_resolution_clock::now();  
std::chrono::duration<double> duration = end - start;  
std::cout << "Execution time: " << duration.count() << " seconds\n";
```