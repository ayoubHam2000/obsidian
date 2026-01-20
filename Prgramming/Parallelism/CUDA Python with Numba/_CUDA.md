
- GPU code called kernel
- Host launches kernels on device
- Typical CUDA program
	- CPU allocates GPU memory (cudaMalloc)
	- CPU copies data to GPU (cudaMemcpy)
	- CPU lanches kernel on GPU
	- CPU copies results from GPU (cudaMemcpy)
	- Still have computation/communication tradeoff
- Big Idea
	- Kernel looks like a serial program; says nothing about parallelism
	- Write as if run on one thread
	- Will actually run on many threads (CPU says how many)
		- Each thread knows its thread index; can do different parts of the computation


Tesla (2008) TPC -> SMC -> SM -> SP (core)
Ampere (2020) 
	- 7GPC
	- 12SM / GPC
	- 128CUDA/SM
	- 28 Tensor/SM
	- => 10752 CUDA
	- => 336 Tensor
SM-SP
	INT32 - Float32 - Float64 - TensorCore - shared memory - texture


##### Compiler
 - nvcc
 - Offline-Compilation
	 - Host code
		 - Compiled to (x86) binary
	 - Device Code
		 - Compiled to PTX (parallel thread execution)
- Just in time compilation
	- Compile PTX to native GPU instruction

##### GPU Mapping

- Grid - Blocks - Threads
	- `Kernel` executes in a `thread`
	- `threads` grouped into thread `blocks`
	- `blocks` grouped into `grids`
	`Kernel` executed as a `Grid` of `blocks` of `threads`

##### Mapping to hardware

| CUDA   | Hardware |
| ------ | -------- |
| Thread | SP       |
| Block  | SM       |
| Grid   | GPU      |
![[Screenshot from 2024-03-19 10-50-56.png]]![[Screenshot from 2024-03-19 12-10-19.png]]

`__device__` : called form device and run in the device
`__global__`: called form the host and run in the device
`__host__`: called form the host and run in the host

`<<<D_g, D_b>>>` can be of type `dim3`  or `int` 
	- `int` specifies 1D vector
	- `dim3` vector 1D, matrix 2D, volume 3D

- D_g Dimension and size of the grid
- D_b Dimension and size of each block can't exceed 1024 threads

| Type  | Variable  | Description                  |
| ----- | --------- | ---------------------------- |
| dim3  | gridDim   | Dimension of grid            |
| uint3 | blockIdx  | Index of block within grid   |
| dim3  | blockDim  | Dimension of block           |
| uint3 | threadIdx | Index of thread within block |
![[Screenshot from 2024-03-19 12-41-32.png]]

On the GPU
- Each thread has local memory (registers)
	- private to the thread
- Each thread block has shared memory
	- Visible to all threads in thread block
- All threads can access global memory
	- Persistent across kernel launches is same app