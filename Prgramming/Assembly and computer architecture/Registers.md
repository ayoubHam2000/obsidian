## Related

[[Flags register]]
[[QA#1. **RSP (Stack Pointer)**]]
## Main

In the **x86** architecture (both 32-bit and 64-bit variants), registers are small, fast storage locations directly within the CPU. They are used to hold data, memory addresses, or control information during program execution. These registers have evolved over time from the original 16-bit registers in **x86 (IA-32)** to **32-bit** in x86 and finally **64-bit** in **x86-64 (AMD64)** architecture.

### 1. **General-Purpose Registers**

These are the most commonly used registers in the x86/x86-64 CPU for arithmetic, data movement, and logic operations. Here's an overview of these registers and their different versions:

| **Register Name**     | **64-bit** | **32-bit** | **16-bit** | **8-bit** |
| --------------------- | ---------- | ---------- | ---------- | --------- |
| **Accumulator**       | `RAX`      | `EAX`      | `AX`       | `AH/AL`   |
| **Base**              | `RBX`      | `EBX`      | `BX`       | `BH/BL`   |
| **Counter**           | `RCX`      | `ECX`      | `CX`       | `CH/CL`   |
| **Data**              | `RDX`      | `EDX`      | `DX`       | `DH/DL`   |
| **Source Index**      | `RSI`      | `ESI`      | `SI`       | —         |
| **Destination Index** | `RDI`      | `EDI`      | `DI`       | —         |
| **Stack Pointer**     | `RSP`      | `ESP`      | `SP`       | —         |
| **Base Pointer**      | `RBP`      | `EBP`      | `BP`       | —         |
The x86-64 general-purpose registers are
aliased: each has multiple names, which refer
to overlapping bytes in the register
![[Screenshot from 2024-12-14 17-09-32.png]]
![[Screenshot from 2024-12-14 17-10-09.png]]
**RAX (Accumulator Register)**: Often used for arithmetic operations, storing function return values, and other general-purpose data. For example, after a function call, the return value is usually found in `RAX`.
**RBX (Base Register)**: Used as a general-purpose register. It can store memory addresses or values.
**RCX (Counter Register)**: Often used as a loop counter in iteration operations
**RDX (Data Register)**: Holds additional data for arithmetic operations, especially multiplication and division.
**RSI (Source Index)**: Used for string and array operations
**RDI (Destination Index)**: Complementary to `RSI`, this register holds the destination address for string and memory operations.
**RSP (Stack Pointer)**: Points to the top of the **stack**
**RBP (Base Pointer)**: Used to reference function arguments and local variables in the stack. [[QA#1. **RSP (Stack Pointer)**]]
**R8-R15**: These are new 64-bit registers added to increase the number of general-purpose registers in 64-bit mode.

### Special-Purpose Registers

**RIP (Instruction Pointer)**: Holds the address of the next instruction to be executed.
**RFLAGS (Flags Register)**: Stores various status flags that reflect the outcome of operations and control flags.
	[[Flags register]]
**CS (Code Segment)**: Holds the segment of memory where the current code is located (used in real mode or 16-bit x86).
**SS (Stack Segment)**: Stores the segment address for the stack (used in real mode or 16-bit x86).
**DS (Data Segment)**: Holds the segment for data storage (used in real mode or 16-bit x86).

### Floating-Point and Vector Registers

[[Vector Registers]]

In modern x86 CPUs, **SSE** and **AVX** instruction sets provide special-purpose registers for floating-point and vectorized data processing.
**XMM Registers**: Used for **SSE** (Streaming SIMD Extensions) instructions and hold 128 bits of data.
- **XMM0-XMM15** (in x86-64): Can hold four 32-bit floats or two 64-bit double precision floats.

**YMM Registers**: Introduced with **AVX (Advanced Vector Extensions)**, these registers extend the **XMM** registers to 256 bits for vector operations.
-  **YMM0-YMM15**: Can hold eight 32-bit floats or four 64-bit double precision floats.

**ZMM Registers**: Introduced with **AVX-512** (512-bit registers), mainly for high-performance vectorized operations.

### **Segment Registers (Legacy)**

Although not commonly used in modern **protected mode** and **long mode** (64-bit), **segment registers** still exist from the older **real mode** x86 architecture:

- **CS (Code Segment)**: Points to the current code segment.
- **DS (Data Segment)**: Points to the current data segment.
- **SS (Stack Segment)**: Points to the current stack segment.
- **ES, FS, GS**: Extra segment registers, often used for specialized purposes (e.g., thread-local storage in 64-bit systems using `FS` or `GS`).