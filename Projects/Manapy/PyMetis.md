
## ✨ What is PyMetis?

**PyMetis** is a pure Python wrapper around the **serial METIS** C library, allowing Python users to perform graph and mesh partitioning directly.

It supports:

- **Graph partitioning** (`part_graph`)
    
- **Mesh partitioning** (`part_mesh_dual`, `part_mesh_nodal`)
    

---

## 📁 Installation

### Install with pip (recommended)

```bash
pip install pymetis
```

### Dependencies
    
- C compiler (for building the native extension)
    
- `build-essential` and `python3-dev` on Linux
    

> **Note**: PyMetis builds a minimal METIS internally — no need to install METIS separately.

---

## ⚒️ Basic Graph Partitioning

```python
import pymetis

adjacency = [
    [1, 2],     # node 0 is connected to 1, 2
    [0, 2],     # node 1 is connected to 0, 2
    [0, 1, 3],  # node 2 is connected to 0, 1, 3
    [2, 4, 5],  # etc.
    [3, 5],
    [3, 4]
]

n_cuts, membership = pymetis.part_graph(2, adjacency=adjacency)
print("Edge cuts:", n_cuts)
print("Partition labels:", membership)
```

#### `2`

The number of desired **partitions** (or subdomains).

### `n_cuts`

- An **integer**.
    
- The number of **edges that connect nodes in different partitions** — i.e., **cut edges**.
    
- This is the **communication cost** in parallel computing terms (lower is better).
    

### `membership`

- A **list** of integers, one per node.
    
- Each value indicates the **partition ID** (from `0` to `nparts - 1`) assigned to that node.

```python
n_cuts = 2
membership = [0, 0, 0, 1, 1, 1]
```
Means:

- Nodes 0, 1, 2 are in partition 0.
    
- Nodes 3, 4, 5 are in partition 1.
    
- Two edges cross from one partition to the other.
## 🔁 Behind the scenes

PyMetis converts the adjacency list into a **CSR (Compressed Sparse Row)** format and passes it to the METIS library’s function `METIS_PartGraphKway`.

METIS then:

- Tries to **balance the size** of partitions (equal node counts).
    
- **Minimizes cut edges** (edges that cross between partitions).
    
- Uses a **multilevel recursive bisection** or **K-way refinement** method.

---

## 🔄 Mesh Partitioning (FEM/FVM)

### Dual Graph Mode (Cell-centered, CFD typical)

```python
n_cuts, epart = pymetis.part_mesh_dual(
    ne=4,                 # number of elements
    nn=5,                 # number of nodes
    eptr=[0, 3, 6, 9, 12],
    eind=[0,1,2,  1,2,3,  2,3,4,  0,2,4],
    ncommon=2            # number of shared nodes that define adjacency
)
```

⚠️ `pymetis.part_mesh_dual()` actually **does not let you directly specify the number of partitions** — it always defaults to **2 partitions**.

f you want **more than 2 partitions**, you need to:

1. **Manually convert** your mesh into a **dual graph** (CSR format: `xadj`, `adjncy`).
    
2. Use `pymetis.part_graph(nparts, adjacency=...)` with the desired `nparts`.


#### 🔷 `eind` — Element-to-node mapping (flattened)

This is a flat list of **node indices** for all elements. Each group of 3 (or more) integers defines one element.

```python
eind = [0,1,2,   1,2,3,   2,3,4,   0,2,4]
```

This defines 4 **triangular elements**, each with 3 nodes:

- Element 0: nodes `[0, 1, 2]`
    
- Element 1: nodes `[1, 2, 3]`
    
- Element 2: nodes `[2, 3, 4]`
    
- Element 3: nodes `[0, 2, 4]`

#### What does `epart` contain?

- `epart` is a list of length `ne` (number of **elements**).
    
- Each entry tells you **which partition (or subdomain)** that element was assigned to.

``` python
epart = [0, 0, 1, 1]
```

- Element 0 → partition 0
    
- Element 1 → partition 0
    
- Element 2 → partition 1
    
- Element 3 → partition 1
    

This is how METIS partitions the elements so that:

- Each partition has roughly equal elements (load balance).
    
- **The number of shared faces between partitions is minimized** (communication cost).
#### What is `n_cuts`?

- `n_cuts` is a **single integer**.
    
- It tells you **how many “edges” (i.e., faces) are cut** between partitions in the dual graph.

#### 🔷 `eptr` — Element pointer

This tells you **where** each element's node list starts in `eind`.
```python
eptr = [0, 3, 6, 9, 12]
```

It works like this:

- Element 0: `eind[0:3]` → `[0, 1, 2]`
    
- Element 1: `eind[3:6]` → `[1, 2, 3]`
    
- Element 2: `eind[6:9]` → `[2, 3, 4]`
    
- Element 3: `eind[9:12]` → `[0, 2, 4]`
    

The last value in `eptr` (12) marks the end of the data.

#### 🔍 What `ncommon` means

In a **dual graph**, each **element becomes a graph node**, and there is an **edge between two elements if they share at least `ncommon` nodes**.

---

##### 🧠 How to choose `ncommon`

|Element Type|Face definition (in nodes)|✅ Recommended `ncommon`|
|---|---|---|
|2D Triangle|Edge = 2 nodes|**2**|
|2D Quadrilateral|Edge = 2 nodes|**2**|
|3D Tetrahedron|Face = 3 nodes|**3**|
|3D Hexahedron|Face = 4 nodes|**4**|
|Mixed Elements|Use smallest face (e.g., 2)|**2** or lowest value|

##### ⚠️ If you choose `ncommon` too low:

- Elements may be considered neighbors **even if they only touch at a corner** (e.g., 1 shared node).
    
- This increases **false edges** in the graph → more cuts → worse partitions.
    

##### ⚠️ If you choose `ncommon` too high:

- You might **miss legitimate neighbors** that share a face (e.g., setting `ncommon = 3` on triangles means no edges).
    
- The graph may become **disconnected**, making partitioning ineffective or invalid.
### Nodal Graph Mode (Vertex-centered)

```python
n_cuts, npart = pymetis.part_mesh_nodal(
    ne=4,
    nn=5,
    eptr=[0, 3, 6, 9, 12],
    eind=[0,1,2,  1,2,3,  2,3,4,  0,2,4]
)
```

---

## 🚫 What PyMetis Cannot Do

- No **parallelism**: PyMetis is a wrapper around **serial METIS**, not ParMETIS
    
- No MPI, no distributed memory
    
- Not suited for **very large meshes** — use METIS or ParMETIS from C/C++ for better performance and scalability
    

---


## 🌐 Resources

- GitHub: [https://github.com/inducer/pymetis](https://github.com/inducer/pymetis)
    
- METIS Library: [http://glaros.dtc.umn.edu/gkhome/metis/metis/overview](http://glaros.dtc.umn.edu/gkhome/metis/metis/overview)
    

