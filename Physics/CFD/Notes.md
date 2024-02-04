
https://www.youtube.com/playlist?list=PL-K7XxqaUNye0co-PFb-YJLfrFpvbYU33

divide & conquer

- Continuous domain is discretized into simple geometric shapes called cells
- A volume should be so small that certain quantities stay constant
- ![[Screenshot from 2024-02-03 17-41-49.png]]

#### Steps in CFD Analysis

1. Physical  problem to mathematical model (PDEs)
2. Mesh (Pre-processing)
3. define Analysis type (compressible, multi-face)
4. specify fluid properties & boundary conditions
5. Select numerical schemes
6. Post-processing of results (pressure, Vorticity, forces)

![[Screenshot from 2024-02-03 17-52-02.png]]

![[Screenshot from 2024-02-03 17-54-07.png]]

#### Approaches to solve equations

FEM, FDM, FVM
- FEM: we start with the weighted integral form of the transport equation.
- FDM: we start with the differential form of the transport equation
- FVM: we start with the integral from of the transport equations

Solution of linear equation systems
- Direct methods
- gauss elimination
- LU decomposition
- tridiagonal algorithm (TDMA - trdiagonal matrix algorithm)

Iterative Methods
- SOR (Successive Over-relaxation)
- ILU (Incomplete LU decomposition)
- ADI (Alternating direction implicit)

#### Turbulence

- Irregular, chaotic motion
- 3 dimensional phenomenon
- enhanced mixing effect
- energy cascade from large eddies to small eddies
- dissipative