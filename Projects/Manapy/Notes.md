
## Question

- [ ] `_dist_ortho_function_2d` -> float64 ??
- [ ] `face_f4  node_R_z  node_lambda_z` -> note used on 2d or 3d ?? 
- [ ] `node_periodicid   cell_periodicnid   cell_periodicfid   cell_shift` -> what is the use of these tables because i don't see where the modification is
- [ ] `face name of 33 22 11` ??
- [ ] face name == face oldname
- [ ] node name vs node oldname
- [ ] haloextloc -> why size should be 9 (suppose max number of nodes)
- [ ] ask about cell.tc (store loctoglob in domain 0, but in domain 1.. tc is qual 0.0)
- [ ] update_pediodic_info_3d ?? It create 4 tables but it never return them
- [ ] oriente_3dfacenodeid ?? Not sure what is the use case of orienting the faces, it could be oriented in the creation once for all
- [ ] update_pediodic_info_2d -> the same thing it create tables and it does not return
- [ ] TODO check indexing limit on int32
- [ ] np.dot(np.ascontiguousarray(face_normal[i].astype(np.float64)), np.ascontiguousarray(s7))
## Tasks

- [x] np.zeros
- [x] check 2D compatible (ghost)
- [x] ghost (halo_cell)index point to halosext
- [x] halosext, halocvol
- [x] create localdomais for each rank
- [ ] benchmark the results
- [ ] create imad's domain version
- [ ] compare the two versions
- [ ] test hybrid domain
- [ ] apprx_nb_faces ((nb_cells * max_cell_faceid + boundary_faces) / 2)
- [ ] _create_halo_ghost_tables_3d SLOW
- [x] remove phy_faces_loctoglob
- [ ] `_variables_3d and _face_gradient_info_3d` return 0.0
- [x] remove cell_halofid
- [ ] try to remove cell loop of cell table from `create_cell_ghostnid`
- [ ] check for boundary_cell `_create_bcell_halobfid   _count_max_bf_nodeid` (loooop)
- [ ] b_visited , i_visited, try to allocate for this table once, see if it can optimize intersect function
- [ ] face_and_node name function see if it can be optimzied
- [ ] unified checker3d 
- [ ] check hexa measures if it should be general or limited to rectangle case
- [ ] check gamma and normal face
- [ ] check random mesh
- [ ] C to python, malloc failed to exception
- [ ] tests for float64
- [ ] documentation and revise 
- [ ] bug when spliting triangle 2D with 100 halos
- [ ] float precision revision 
- [ ] metis dual and nodal does not work properley with cuboid and rectangle
- [ ] metis nodal not work with tetra when low cells and heigh partition vs make_nparts
- [ ] check map_halos (cell_halos vs node_halos)
- [ ] visual the partitioning to see if there any error
- [ ] Hybrid Test the order of faces must be match also
---
- [ ] `_share_ghost_info` need to be like imad function
- [ ] Multigrid ginkgo
- [ ] the new version of domain creation need to be working with core.py and simulations
- [ ] need to get the resuls of PETScKrylovSolver
#### extra

- cells_type
- phy_faces
- phy_faces_name
- node_halos
- dim
- float_precision
- max_cell_nodeid
- max_cell_faceid
- max_face_nodeid
#### cell

- [x] center 
- [x] volume
- [x] cellfid
- [x] cellnid
- [x] halonid
- [x] halofid
- [x] faceid
- [x] nodeid
- [x] nf
- [x] loctoglob
- [x] ghostnid
- [x] haloghostnid
- [x] haloghostcenter
- [ ] tc  
- [x] periodicnid  
- [x] periodicfid  
- [x] shift
- [ ] globtoloc (not used)
- [x] nbcells
#### Node

- [x] nbnodes  
- [x] vertex  
- [x] name  
- [x] oldname  
- [x] cellid  
- [x] ghostid  
- [x] haloghostid  
- [x] ghostcenter  
- [x] haloghostcenter  
- [x] ghostfaceinfo  
- [x] haloghostfaceinfo    
- [x] loctoglob  
- [x] halonid  
- [ ] nparts  (not used)
- [x] periodicid  
- [x] R_x  
- [x] R_y  
- [x] R_z  
- [x] number  
- [x] lambda_x  
- [x] lambda_y  
- [x] lambda_z

#### Face

- [x] nbfaces
- [x] nodeid
- [x] cellid
- [x] name
- [x] oldname
- [x] normal
- [x] mesure
- [x] center
- [x] dist_ortho
- [x] ghostcenter
- [ ] oppnodeid (not used)
- [x] halofid
- [x] param1
- [x] param2
- [x] param3
- [x] param4
- [x] f_1
- [x] f_2
- [x] f_3
- [x] f_4
- [x] airDiamond
- [x] tangent
- [x] binormal


#### Halo

- [ ] halosint
- [x] halosext
- [x] neigh
- [ ] centvol
- [ ] faces
- [ ] nodes
- [ ] sizehaloghost
- [ ] scount
- [ ] rcount
- [ ] indsend
- [ ] comm_ptr
- [ ] requests


int32 vs int_precesion


### Log

- changing `node_haloghostcenter` to `node_haloghostcenter, node_haloghostinfo`
- changing `node_ghostcenter` to `node_ghostcenter, node_ghostinfo`
- changing `shared_ghost_info` to `shared_ghost_info_flt, shared_ghost_info_int`
	- this affect `_create_shared_ghost_info, _share_ghost_info, _create_ghost_tables, _create_halo_ghost_tables` in `LocalDomainClass.py`


## Install

### Petsc

```
git clone -b release https://gitlab.com/petsc/petsc.git petsc
python3 -m pip install src/binding/petsc4py

conda install -c conda-forge compilers
which x86_64-conda-linux-gnu-cc       
/home/aben-ham/anaconda3/envs/work/bin/x86_64-conda-linux-gnu-cc

sudo apt install petsc-dev




```

#### Petsc Segv

Both **`mpi4py`** and **`petsc4py`** interact with **MPI initialization**.
```python
from mpi4py import MPI
petsc4py.init(sys.argv)
```
you risk **initializing MPI twice** or initializing it with **two different MPI libraries**, which causes a **segmentation fault** at `petsc4py.init()`.

> Option 1: Do **NOT** import `mpi4py` before `petsc4py.init()`.

```python
import sys
import petsc4py

petsc4py.init(sys.argv)

from petsc4py import PETSc
from mpi4py import MPI   # safe AFTER init

print(PETSc.COMM_WORLD.getRank())
```

> Option2

Check for MPI mismatch (VERY IMPORTANT)

```
which mpirun
which python
conda list | grep mpi

--> 
- mixed `mpich` + `openmpi`
```

```
conda activate petsc
conda remove mpi4py petsc petsc4py mpich openmpi -y
conda install -c conda-forge petsc petsc4py mpi4py
```