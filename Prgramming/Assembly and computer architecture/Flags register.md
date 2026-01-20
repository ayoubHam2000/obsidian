The **Flags Register** in x86 and x86-64 architectures (also known as the **EFLAGS** register in 32-bit and **RFLAGS** in 64-bit mode) holds various status and control flags that reflect the outcome of instructions and control the operation of the CPU. Each bit in this register represents a different flag that can be set or cleared depending on the results of arithmetic and logical operations.

- **CF (Carry Flag)**: Bit 0
    - **Set** when an arithmetic operation generates a carry or a borrow out of the most significant bit. This flag is used to detect unsigned overflow.
    - Example: After adding two large unsigned integers, if the result doesn't fit within the bit limit (e.g., 32 or 64 bits), the carry flag is set.
- **PF (Parity Flag)**: Bit 2
    - **Set** if the number of set bits (1s) in the least significant byte of the result is even.
    - Used mainly for detecting transmission errors in serial data communication, although it's not commonly used in modern programming.
- **AF (Auxiliary Carry Flag)**: Bit 4
    - **Set** when there is a carry or borrow from bit 3 to bit 4 in binary-coded decimal (BCD) operations.
    - Primarily used in **BCD arithmetic**, this flag has less significance in general-purpose computation today.
- **ZF (Zero Flag)**: Bit 6
    - **Set** if the result of an arithmetic or logical operation is zero.
    - This flag is often used in comparisons and conditional branches. For example, after a subtraction, if the result is zero, the operands were equal, and the zero flag is set.
- **SF (Sign Flag)**: Bit 7
    - **Set** if the result of an operation is negative (i.e., if the most significant bit is set to 1).
    - This is used for signed arithmetic to detect if a result is positive or negative.
- **TF (Trap Flag)**: Bit 8
    - When **set**, it enables **single-step mode** for debugging. After every instruction, the CPU generates a debug exception, allowing a debugger to control the flow of the program one instruction at a time.
- **IF (Interrupt Enable Flag)**: Bit 9
    - **Set** when interrupts are enabled. If clear, the CPU will ignore maskable hardware interrupts (but still handle non-maskable interrupts or exceptions).
    - This flag controls whether the CPU can respond to **maskable** hardware interrupts.
- **DF (Direction Flag)**: Bit 10
    - Controls the direction for string operations (`MOVS`, `LODS`, `STOS`, etc.). If **set**, string operations process from higher memory addresses to lower ones (i.e., decrementing pointers). If **clear**, they process from lower to higher addresses (i.e., incrementing pointers).
- **OF (Overflow Flag)**: Bit 11
    - **Set** when signed arithmetic operations generate a result too large or too small to fit in the destination operand (signed overflow).
    - This is crucial in detecting signed integer overflows during addition, subtraction, multiplication, etc.
- **IOPL (I/O Privilege Level)**: Bits 12 and 13
    - Indicates the current I/O privilege level. It's used in protected mode to control access to I/O ports.
    - Only code running at a certain privilege level (determined by the operating system) can perform input/output operations. It's not typically modified directly by user applications.
- **NT (Nested Task Flag)**: Bit 14
    - Indicates whether the current task is nested (i.e., if it was called by another task).
    - This flag is used in hardware task switching but is generally irrelevant in most modern operating systems, which use software-based multitasking.
- **RF (Resume Flag)**: Bit 16
    - **Set** to disable certain exceptions, particularly for single-step or breakpoint debugging. This allows the instruction to be resumed after an exception without immediately triggering the same exception.
- **VM (Virtual 8086 Mode Flag)**: Bit 17
    - When **set**, the processor runs in **virtual 8086 mode**, which allows 16-bit code (real-mode programs) to run in a protected or virtual environment, enabling multitasking and protection mechanisms from the 32-bit protected mode.
- **AC (Alignment Check Flag)**: Bit 18
    - **Set** to enable automatic detection of misaligned data accesses, raising an exception if an unaligned memory access occurs. This helps detect bugs related to unaligned memory access.
- **VIF (Virtual Interrupt Flag)**: Bit 19
    - This is a virtual version of the **IF** flag, used in virtual environments or for emulation.
- **VIP (Virtual Interrupt Pending Flag)**: Bit 20
    - This flag indicates that a virtual interrupt is pending. It works with the **VIF** flag in virtualized environments.
- **ID (Identification Flag)**: Bit 21
    - **Set** to allow the use of the **CPUID** instruction. When **clear**, the **CPUID** instruction is disabled, preventing software from querying the CPU for its capabilities.

### Summary of Commonly Used Flags

- **Carry Flag (CF)**: Detects unsigned overflows.
- **Zero Flag (ZF)**: Indicates whether an operation resulted in zero.
- **Sign Flag (SF)**: Detects if the result of an operation is negative.
- **Overflow Flag (OF)**: Detects signed overflow.
- **Interrupt Flag (IF)**: Controls whether hardware interrupts are enabled or disabled.
- **Direction Flag (DF)**: Determines the direction for string operations.


```c
    mov eax, 5       ; Load 5 into EAX
    sub eax, 5       ; Subtract 5 from EAX (result is 0)
    jz  zero_label   ; Jump to zero_label if Zero Flag (ZF) is set
    jl  less_label   ; Jump to less_label if Sign Flag (SF) is set (result is negative)
    jo  overflow_label ; Jump if Overflow Flag (OF) is set
zero_label:
    ; Code to handle the zero case
    ...
less_label:
    ; Code to handle the negative case
    ...
overflow_label:
    ; Code to handle overflow
    ...
```