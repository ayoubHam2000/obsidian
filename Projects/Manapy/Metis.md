## Metis

METIS is a serial software package for partitioning large irregular graphs, partitioning large meshes, and computing
fill-reducing orderings of sparse matrices. METIS has been developed at the Department of Computer Science &
Engineering at the University of Minnesota and is freely distributed. Its source code can downloaded directly from
http://www.cs.umn.edu/˜metis, and is also included in numerous software distributions for Unix-like operating systems
such as Linux and FreeBSD.![[manual.pdf]]
## Difference between **PyMetis** and **MgMetis**

### **PyMetis**

- **What it is**: A **Python wrapper** around the original **METIS** C library.
    
- **Purpose**: Provides Python bindings to METIS’s graph partitioning functions.
    
- **Features**:
    
    - Offers **standard METIS capabilities**, such as:
        
        - `part_graph`: for graph partitioning.
            
        - `part_mesh_dual`, `part_mesh_nodal`: for mesh partitioning.
            
    - Requires compiling native code (includes a minimal version of METIS).
        
    - Focused on **serial (non-parallel)** partitioning.


### **MgMetis**

- **What it is**: A Python wrapper or reimplementation that uses **Multilevel Graph Partitioning**, sometimes referencing METIS-style algorithms, but **not the original METIS** library.
    
- **Purpose**: Offers graph partitioning with **pure Python and NumPy**, or bindings to **other backends** (e.g., PyTorch Geometric, or for machine learning on graphs).
    
- **Features**:
    
    - May support partitioning of graphs stored in SciPy/NumPy formats.
        
    - Not always compatible with `part_mesh_dual` or `part_mesh_nodal`.
        
    - May be aimed at **graph neural networks** or **big-data partitioning**, not finite element meshes.
        
- **Use case**: When you're dealing with **graph data** in ML pipelines and want partitioning without depending on native C code.


### **Pymetis**

**PyMetis** is a Python wrapper around the **serial** version of the **METIS** library, which is designed for **single-threaded, single-process** graph and mesh partitioning.

**ParMETIS**, the **parallel version** of METIS, developed by the same authors.

#### 🔹 What is ParMETIS?

- A C library for **distributed-memory parallel partitioning** using MPI.
    
- Designed for high-performance computing and large-scale simulations.
    
- Supports parallel mesh and graph partitioning.

### Alternatives for Parallel Partitioning in Python:

- **Zoltan or Scotch with Python bindings** (experimental):
    
    - Libraries like Zoltan and PT-Scotch offer parallel graph partitioning with some wrappers available.

[[ParMETIS Mesh Partitioning (Dual Graph Generation)]]
[[PyMetis]]
