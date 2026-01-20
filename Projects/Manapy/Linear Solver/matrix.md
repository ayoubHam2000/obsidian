```c
A->apply(b, x) // x = A*b
A->apply(alpha, b, beta, x) // x = alpha*A*b + beta*x
b->compute_norm2(res); // res = sqrt(b^T*b)
r->scale(gko::initialize<dense_t>({-1.0}, exec)); // r = -r
r->add_scaled(gko::initialize<dense_t>({1.0}, exec), b); // r = r + 1.0*b
```