

This project demonstrates how to use **ParMETIS** to generate a **dual graph** from a finite element mesh and (optionally) partition it. ParMETIS can operate in both **parallel** and **serial** modes.

---

## ✨ Features

- Converts a mesh (element-node format) into a **dual graph** using `ParMETIS_V3_Mesh2Dual`
    
- Partitions the dual graph using `ParMETIS_V3_PartKway`
    
- Runs on **multiple MPI ranks** or in **serial mode** (`-np 1`)
    

---

## 📁 Requirements

- MPI compiler (`mpicc`)
    
- [ParMETIS](https://github.com/KarypisLab/ParMETIS) (and METIS)
    

### Build ParMETIS:

```bash
git clone https://github.com/KarypisLab/ParMETIS.git
cd ParMETIS
make config     # Choose 32- or 64-bit, and MPI compiler
make
sudo make install PREFIX=/opt/parmetis
```

---

## ⚒️ Building This Project

Compile with:

```bash
mpicc mesh2dual.c -I/opt/parmetis/include -L/opt/parmetis/lib \
      -lparmetis -lmetis -lm -o mesh2dual
```

---

## 🚀 Running

### Parallel (e.g., 4 MPI processes)

```bash
mpirun -np 4 ./mesh2dual
```

### Serial (1 MPI process)

```bash
mpirun -np 1 ./mesh2dual
```

ParMETIS fully supports size-1 MPI communicators, so it behaves like a serial library in this mode.

---

## 🔄 Dual Graph Generation API

```c
ParMETIS_V3_Mesh2Dual(elmdist, eptr, eind,
                      &numflag, &ncommon,
                      &xadj, &adjncy,
                      &MPI_COMM_WORLD);
```

- `elmdist` → global element distribution (same on all ranks)
    
- `eptr`, `eind` → local mesh: CSR-style element-node list
    
- `ncommon` → number of shared nodes that define adjacency:
    
    - `2` → triangles/quads
        
    - `3` → tetrahedra
        
    - `4` → hexahedra
        
- `xadj`, `adjncy` → returned dual graph in CSR format
    

---

## 🤖 Partitioning the Graph

```c
ParMETIS_V3_PartKway(elmdist, xadj, adjncy,
                     NULL, NULL,
                     &wgtflag, &numflag,
                     &ncon, &nparts,
                     tpwgts, ubvec,
                     options,
                     &edgecut, part, &MPI_COMM_WORLD);
```

Use this after building the dual graph with `ParMETIS_V3_Mesh2Dual`.

Alternatively, do it all in one call:

```c
ParMETIS_V3_PartMeshKway(...);
```

---

## 🚫 When NOT to Use ParMETIS

If you're always working in serial, or don't want MPI dependencies, use **METIS**:

```c
METIS_PartMeshDual(...);
```

Same interface, no `MPI_Init()` or communicator required.

---

## 🔧 Common Pitfalls

|Symptom|Cause|
|---|---|
|Segfault|`elmdist` not consistent across ranks|
|METIS_ERROR_INPUT|`ncommon` invalid or elements missing|
|One rank does all the work|Bad `elmdist` or unbalanced mesh|

---

## ✨ Example: Minimal Serial Mesh

```c
idx_t elmdist[2] = {0, 2};
idx_t eptr[3] = {0, 3, 6};
idx_t eind[6] = {0,1,2, 1,3,2};
idx_t ncommon = 2, numflag = 0;
ParMETIS_V3_Mesh2Dual(elmdist, eptr, eind,
                      &numflag, &ncommon,
                      &xadj, &adjncy,
                      &MPI_COMM_WORLD);
```

This creates a dual graph of 2 triangles sharing an edge.

---

## 📊 License

ParMETIS is open source under a permissive license (see its repo).