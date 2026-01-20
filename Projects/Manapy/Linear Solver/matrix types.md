
```
    | 1 0 0 0 0 |
    | 0 0 5 0 0 |
A = | 4 0 0 0 3 |
    | 0 8 0 0 2 |
    | 0 0 0 7 0 |
```

## Dense

This is the row-major storage dense matrix format. The matrix `A` would be stored in a single `value` array:
```
value = [ 1 0 0 0 0 0 0 5 0 0 4 0 0 0 3 0 8 0 0 2 0 0 0 7 0 ]
```

## COO 

This is the Coordinate (COO) sparse matrix format. Only stores the non-zero values, including the row- and column-indices corresponding to that value.

```
val     = [ 1 5 4 3 8 2 7 ]
row_idx = [ 0 1 2 2 3 3 4 ]
col_idx = [ 0 2 0 4 1 4 3 ]
```

## CSR

This is the Compressed Sparse Row (CSR) sparse matrix format. It is basically the COO format sorted by row indices which compresses the row indices by only storing the beginning of each row

```
val       = [ 1 5 4 3 8 2 7 ]
row_start = [ 0 1 2 4 6 7 ]
col_idx   = [ 0 2 0 4 1 4 3 ]
```

## More

https://github.com/ginkgo-project/ginkgo/wiki/Matrix-Formats-in-Ginkgo#gkomatrixcoo
