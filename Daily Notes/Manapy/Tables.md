

## Tables

nodes_ghostid => [ghostid_1, ..., ghostid_n, nb_ghost_of_a_node] * nb_node ghostid_1 <=> face_id !!??  
nodes_ghostcenter => [[g_x, g_y, cell_id, face_old_name, ghostid] * nb_ghost_of_a_node] * nb_node  
nodes_ghostfaceinfo => [[face_center_x, face_center_y, face_normal_x, face_normal_y] * nb_ghost_of_a_node] * nb_nodes  
  
cells_ghostnid => [ghostid_1, ..., ghostid_n, nb_ghost_by_node] * nb_cells <=> face_id !!??



### Tested attributes:

#### cell

center 
volume
nbcells
cellfid
cellnid
halonid
faceid
nodeid
nf
loctoglob
ghostnid
haloghostnid
haloghostcenter

#### Node

nbnodes
vertex
cellid
loctoglob
halonid
oldname
ghostid
ghostcenter
ghostfaceinfo

haloghostid
haloghostcenter
haloghostfaceinfo
name

#### Face

normal (only abs)
center
mesure
halofid
nbfaces
nodeid
cellid
ghostcenter
oldname
name

oppnodeid (Triangle cell only)


#### Halo

halosext
halosint
neigh
centvol
sizehaloghost

### These attributes are not tested

`halo`
faces ->  !AttributeError  
nodes ->  !AttributeError
requests !AttributeError  
rcount 
scount
indsend

`node`
nparts  
periodicid  
R_x  
R_y  
R_z  
number  
lambda_x  
lambda_y  
lambda_z  
  
`cell`
globtoloc
shift  
periodicfid  
periodicnid  
tc  
  
`face`
param1  
param2  
param3  
param4  
f_1  
f_2  
f_3  
f_4  
airDiamond
tangent  
binormal  
dist_ortho  
  
  
