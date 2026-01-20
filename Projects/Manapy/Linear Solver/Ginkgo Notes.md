- PETScKrylovSolver
- MUMPS
- Krylov Solvers
- Multigrid
- Preconditioners
- Ginkgo does _not_ provide GPU-aware MPI internally (You _can_ use Ginkgo inside each rank.)
- **Ginkgo does not have a full LU factorization solver like LAPACK or PETSc/MUMPS**. 
- Random matrices often break ILU/ParILU. If ParILU produces NaNs:  
  - Your matrix is not diagonally dominant  
  - Or contains zero pivots  
  - Or is singular  
  - Or structure is incompatible with LU  
- Why gko::share?  
  Because Ginkgo expects a `std::shared_ptr<LinOp>` for chaining operators.


### Turn a **ParILU factorization** into a **full ILU preconditioner**


```c
// Generate incomplete factors using ParILU
auto par_ilu_fact =
    gko::factorization::ParIlu<ValueType, IndexType>::build().on(exec);
// Generate concrete factorization for input matrix
auto par_ilu = gko::share(par_ilu_fact->generate(A));
```

**runs the actual ParILU algorithm** on matrix `A`.
Now `par_ilu` contains:
- `L = par_ilu->get_l_factor()`
- `U = par_ilu->get_u_factor()`
And `par_ilu` itself is a **LinOp** representing both factors.


```c
// Generate an ILU preconditioner factory by setting lower and upper
// triangular solver - in this case the exact triangular solves
auto ilu_pre_factory =
    gko::preconditioner::Ilu<gko::solver::LowerTrs<ValueType, IndexType>,
                             gko::solver::UpperTrs<ValueType, IndexType>,
                             false>::build()
        .on(exec);

// Use incomplete factors to generate ILU preconditioner
auto preconditioner = gko::share(ilu_pre_factory->generate(par_ilu));
```

- Take the ParILU factorization (`par_ilu`)
- Extract **L** and **U**
- Wrap them in **LowerTrs** and **UpperTrs** solvers
- Compose them into a preconditioner **M⁻¹ = U⁻¹ L⁻¹**
- After this:  `preconditioner` acts like:

$$ x=M^{−1}b=U^{−1}L^{−1}b $$

and can be passed into any `Krylov` solver