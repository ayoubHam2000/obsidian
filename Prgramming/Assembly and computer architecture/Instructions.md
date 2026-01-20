### Related

```
https://www.felixcloutier.com/x86/
```

https://www.felixcloutier.com/x86/

https://flint.cs.yale.edu/cs421/papers/x86-asm/asm.html

[[pop]]
[[ret]]
[[call]]
[[push]]
[[test]]
[[leal]]
[[repe-seta-setb-repz-cmps]]
[[repne-scasb]]
[[sub]]
[[movsbl]]
[[jump-family]]
[[cmp]]
[[cld]]

### x86-64 Instruction Format

![[Screenshot from 2024-12-14 20-25-09.png]]

[[repe-seta-setb-repz-cmps#General Syntax of an Assembly Instruction]]

### AT&T versus Intel Syntax

![[Screenshot from 2024-12-14 20-25-24.png]]

### Opcode Suffixes

Opcodes might be augmented with a suffix that describes the data type of the operation or a condition code.
- An opcode for data movement, arithmetic, or logic uses a single-character suffix to indicate the data type.
- If the suffix is missing, it can usually be inferred from the sizes of the operand registers.
![[Screenshot from 2024-12-14 20-35-54.png]]
![[Screenshot from 2024-12-14 20-36-55.png]]

![[Screenshot from 2024-12-14 20-48-14.png]]

### Conditional Operations

Conditional jumps and conditional moves use a one- or two-character suffix to indicate the condition code.

```c
cmpq $4096, %r14
jne .LBB1_1
```
![[Screenshot from 2024-12-14 20-52-10.png]]

### Idiom

```c
xor %rax, %rax ; // Zeros the register.
```

```c
test %rax, %rax; // Checks to see whether the register is 0.
je 400c0a <mm+0xda>
```

```c
data16 data16 data16 nopw %cs:0x0(%rax, %rax, 1); //Nothing
```

### Common x86-64 Opcodes

![[Screenshot from 2024-12-14 20-26-08.png]]

|**Opcode (Hex)**|**Mnemonic**|**Operation**|**Description**|
|---|---|---|---|

|          |       |              |                                                   |
| -------- | ----- | ------------ | ------------------------------------------------- |
| **0x90** | `NOP` | No operation | Does nothing; often used for alignment or delays. |

|   |   |   |   |
|---|---|---|---|
|**0x89**|`MOV r/m32, r32`|Move 32-bit register/memory to register|Moves data from a register or memory location to a register.|

|   |   |   |   |
|---|---|---|---|
|**0x8B**|`MOV r32, r/m32`|Move register to 32-bit memory/register|Moves data from a register/memory to a register.|

|   |   |   |   |
|---|---|---|---|
|**0x83**|`ADD r/m32, imm8`|Add 8-bit immediate to 32-bit register/memory|Adds an immediate value (8-bit) to a register/memory operand.|

|   |   |   |   |
|---|---|---|---|
|**0x01**|`ADD r/m32, r32`|Add two 32-bit registers/memory|Adds the value of two registers or memory locations.|

|   |   |   |   |
|---|---|---|---|
|**0x29**|`SUB r/m32, r32`|Subtract two 32-bit registers/memory|Subtracts the value of one register/memory from another.|

|   |   |   |   |
|---|---|---|---|
|**0xF7**|`DIV r/m32`|Signed division of 32-bit values|Divides the accumulator register by the operand.|

|   |   |   |   |
|---|---|---|---|
|**0xC7**|`MOV r/m32, imm32`|Move immediate 32-bit value to 32-bit register/memory|Moves a 32-bit immediate value into a register or memory.|

|   |   |   |   |
|---|---|---|---|
|**0xE8**|`CALL`|Call a procedure (relative offset)|Transfers control to a subroutine at the given offset.|

|   |   |   |   |
|---|---|---|---|
|**0xFF**|`INC r/m32`|Increment the value in a register or memory|Increments the operand by 1.|

|   |   |   |   |
|---|---|---|---|
|**0xF0**|`LOCK`|Used with instructions for atomic operations (prefix)|Ensures atomic execution of the following instruction.|

|   |   |   |   |
|---|---|---|---|
|**0xF3**|`REP`|Repeat string operation (prefix)|Used for repeating string operations (like `MOVSD`).|

|   |   |   |   |
|---|---|---|---|
|**0xF2**|`REPE`|Repeat while equal (string operations)|Repeats the string operation while comparison is equal.|

|   |   |   |   |
|---|---|---|---|
|**0x48**|`REX`|REX prefix for extended 64-bit registers and operations|Used for addressing the 64-bit registers `R8-R15`.|

|   |   |   |   |
|---|---|---|---|
|**0x0F**|`OPCODE EXT`|Extended operation (used for AVX, SSE, etc.)|Marks the beginning of extended opcodes (e.g., AVX, SSE).|

|   |   |   |   |
|---|---|---|---|
|**0xD1**|`SHL/SHR`|Shift left or right (by count in register)|Shifts the operand left or right by the number in a register.|

|   |   |   |   |
|---|---|---|---|
|**0xC1**|`SHL/SHR`|Shift left or right (by immediate count)|Shifts the operand left or right by an immediate count.|

|   |   |   |   |
|---|---|---|---|
|**0xAA**|`STOSB`|Store byte at ES:DI|Stores the byte in `AL` at the address specified by `ES:DI`.|

|   |   |   |   |
|---|---|---|---|
|**0xA4**|`MOVSB`|Move byte from DS:SI to ES:DI|Moves a byte from `DS:SI` to `ES:DI`.|

|   |   |   |   |
|---|---|---|---|
|**0xC5**|`VEX`|AVX instruction (VEX prefix)|Used for AVX and AVX2 instructions (256-bit/512-bit registers).|

|   |   |   |   |
|---|---|---|---|
|**0x0F 0x10**|`MOVSS`|Move scalar single-precision floating-point|Moves single-precision float from memory or register.|

|   |   |   |   |
|---|---|---|---|
|**0x0F 0x28**|`MOVAPS`|Move aligned packed single-precision floats|Moves packed single-precision floats (aligned).|

|   |   |   |   |
|---|---|---|---|
|**0x0F 0x58**|`ADDPS`|Add packed single-precision floating-point values|Adds packed floats (32-bit).|

|   |   |   |   |
|---|---|---|---|
|**0x0F 0x59**|`SUBPS`|Subtract packed single-precision floating-point values|Subtracts packed floats (32-bit).|

|   |   |   |   |
|---|---|---|---|
|**0xF3 0x0F 0x10**|`MOVSS`|Move scalar single-precision floating-point from memory|Moves a scalar single-precision float from memory.|

|   |   |   |   |
|---|---|---|---|
|**0xF3 0x0F 0x58**|`ADDPD`|Add packed double-precision floating-point values|Adds packed double-precision floats (64-bit).|

|   |   |   |   |
|---|---|---|---|
|**0xF3 0x0F 0x5A**|`MULPS`|Multiply packed single-precision floating-point values|Multiplies packed floats (32-bit).|

|   |   |   |   |
|---|---|---|---|
|**0xF2 0x0F 0x10**|`MOVSS`|Move scalar single-precision floating-point to register|Moves scalar single-precision float to a register.|

|   |   |   |   |
|---|---|---|---|
|**0xF2 0x0F 0x59**|`SUBSS`|Subtract scalar single-precision floating-point values|Subtracts scalar single-precision floats.|

|   |   |   |   |
|---|---|---|---|
|**0x0F 0xD0**|`PSHUF`|Shuffle packed values|Shuffles data within registers using masks.|


