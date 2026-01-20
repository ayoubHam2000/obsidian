
```c
// List all nodes (default summary)
sinfo -N

// Detailed info per node
scontrol show node
scontrol show node node001

//Reserve a specific node
salloc --nodelist=node007 --exclusive --time=00:30:00

//See your active jobs and their nodes
squeue -u $USER -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %R"

//Show specific job info
scontrol show job <jobid>


```

**Submit a job that runs on one node** (with `sbatch`)
```sh
#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --job-name=test
#SBATCH --output=out.txt

hostname
```

```
sbatch job.sh
```

```
module list
module avail
module load Anaconda3/2020.11
module load Python/3.8.6-GCCcore-10.2.0
module load OpenMPI/4.1.1-GCC-11.2.0
module load CMake/3.22.1-GCCcore-11.2.0
module load gmsh
gmsh tetrahedron.geo -3 -o kkk.msh
```

```
#!/bin/bash
#SBATCH --job-name=my_gmsh_job
#SBATCH --output=logs/out_%t.log      # standard output
#SBATCH --error=logs/error_%t.log        # standard error
#SBATCH --mem=180G                     # total memory
#SBATCH --time=03:00:00
#SBATCH --ntasks=56                   # single task
#SBATCH --cpus-per-task=1
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=50

# Load modules
module load Anaconda3/2020.11
module load Python/3.8.6-GCCcore-10.2.0
module load OpenMPI/4.1.1-GCC-11.2.0
module load CMake/3.22.1-GCCcore-11.2.0
# module load gmsh

# Your command here
echo "Starting job on $(hostname)"
bash ./node_info.sh > node_info.txt
mpirun -n 56 python3 mpi_domain_test.py
```

```
export OMPI_MCA_mtl=^ofi
export OMPI_MCA_btl=self,tcp
Do you need performance from RDMA? TCP
```