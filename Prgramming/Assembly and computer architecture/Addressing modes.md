In assembly language, **addressing modes** specify how the **operand** is accessed.

### Types of Addressing Modes in x86 Assembly

1. **Immediate Addressing Mode**
2. **Register Addressing Mode**
3. **Direct (or Absolute) Addressing Mode**
4. **Indirect Addressing Mode**
5. **Indexed Addressing Mode**
6. **Base-Indexed Addressing Mode**
7. **Base-Indexed with Scale Addressing Mode**

| Addressing Mode             | Syntax Example                | What It Does                                                               |
| --------------------------- | ----------------------------- | -------------------------------------------------------------------------- |
| **Immediate**               | `movl $10, %eax`              | Loads the immediate value 10 into `EAX`                                    |
| **Register**                | `movl %ebx, %eax`             | Copies the value in `EBX` into `EAX`                                       |
| **Direct (Absolute)**       | `movl 0xBFFFF630, %eax`       | Loads the value at memory address `0xBFFFF630` into `EAX`                  |
| **Indirect**                | `movl (%ebx), %eax`           | Loads the value at the address stored in `EBX` into `EAX`                  |
| **Indexed**                 | `movl array_base(%ebx), %eax` | Loads the value at `array_base + EBX` into `EAX` (accessing array element) |
| **Base-Indexed**            | `movl (%ebx,%esi), %eax`      | Loads the value at the address `EBX + ESI` into `EAX`                      |
| **Base-Indexed with Scale** | `movl 8(%ebx,%esi,4), %eax`   | Loads the value at `EBX + (4 * ESI) + 8` into `EAX`                        |

**Indexed**
```c
movl array_base(,%ebx,4), %eax  ; Move the value at array_base + 4 * EBX into EAX
```

### NASM

|Mode|Example|Description|
|---|---|---|
|**Immediate**|`mov rax, 5`|Use a constant (literal) value|
|**Register**|`mov rax, rbx`|Move data between CPU registers|
|**Direct Memory**|`mov al, [myvar]`|Access a memory address via label|
|**Indirect**|`mov al, [rbx]`|Use the value inside a register as an address|
|**Base + Displacement**|`mov al, [rbx+4]`|Offset from a base address|
|**Base + Index**|`mov al, [rbx+rcx]`|Add two registers (base + index)|
|**Base + Index + Scale**|`mov al, [rbx+rcx*4]`|Use a scaled index (arrays!)|
|**Full Mode**|`mov al, [rbx+rcx*2+8]`|Base + scaled index + displacement|
```
cmp byte [rdi], 0       ; 8-bit comparison
cmp word [rdi], 0       ; 16-bit comparison
cmp dword [rdi], 0      ; 32-bit comparison
cmp qword [rdi], 0      ; 64-bit comparison
```