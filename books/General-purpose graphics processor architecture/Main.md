## Notes

### Chapter 1 Introduction
- Turing Complete programming model. By Turing Complete, we mean that any computation can be run given enough time and memory.
- While there are ongoing eﬀorts to develop application programming interfaces (APIs) providing I/O services directly on the GPU, so far these all assume the existence of a nearby CPU
- The DRAM technology used for these memories is often diﬀerent (DDR for CPU vs. GDDR for GPU). The CPU DRAM is typically optimized for low latency access whereas the GPU DRAM is optimized for high throughput.
- At the same time the CPU portion of the GPU computing application also speciﬁes how `many threads` should run and where these threads should look for input data. The kernel to run, number of threads, and data location are conveyed to the GPU hardware via the `driver` running on the CPU. The driver will `translate` the information and place it memory accessible by the GPU at a location where the GPU is conﬁgured to look for it. The driver then `signals` the GPU that it has new computations it should run.

- A modern GPU is composed of many cores, as shown in Figure 1.2. NVIDIA calls these cores `streaming multiprocessors` and AMD calls them `compute units`. Each GPU core executes a `single-instruction multiple-thread (SIMT)` program corresponding to the kernel that has been launched to run on the GPU.
	- The threads executing on a single core can communicate through a scratchpad memory and synchronize using fast barrier operations.
	- The large number of threads running on a core are used to hide the latency to access memory when data is not found in the ﬁrst-level caches.
![[Screenshot from 2024-07-19 17-17-44.png]]

- early Researchers quickly learned how to implement linear algebra
using these early GPUs by mapping matrix data into into textures and applying shaders
- SIMD:
	- **Single Instruction**: A single operation or instruction is executed.
	- **Multiple Data**: The instruction is applied to multiple data elements at once.
- OpenCL (a programming model similar
to CUDA which can be compiled to many architectures)

- To improve eﬃciency typical GPU hardware executes groups of threads
together in lock-step. These groups are called warps by NVIDIA and wavefronts by AMD.
- Threads within a CTA can communicate with each other eﬃciently via a per `compute core scratchpad memory.` This scrathpad is called `shared memory` by NVIDIA. Each streaming multi-processor (SM) contains a single shared memory.
	- ... scratchpad memory that AMD calls the `local data store` (LDS). These scratchpad memories are small, ranging from 16–64 KB per SM,
- Threads within a CTA (Cooperative Thread Array) can efficiently synchronize using hardware-supported barrier instructions.
- Threads in different CTAs can communicate through a global address space accessible to all threads.
- Accessing the global address space is typically more expensive in terms of time and energy compared to accessing shared memory.
## Keywords
- DRAM, DRR, GDDR
- streaming multi-processor (SM)
- single-instruction multiple-thread (SIMT)
- streaming multiprocessors / compute units
- single instruction multiple thread (SIMT)
- SIMD (Single Instruction, Multiple Data)
- OpenCL
- warps by NVIDIA and wavefronts by AMD
- cooperative thread array (CTA) or thread block by NVIDIA
- compute core scratchpad memory called shared memory by NVIDIA