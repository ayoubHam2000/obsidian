In the **x86 architecture**, the **stack** grows **downwards**, meaning it moves from **higher addresses to lower addresses** as more data is pushed onto the stack. This behavior is consistent across both 32-bit (x86) and 64-bit (x86_64) architectures.

When a function pushes data onto the stack, (such as function arguments, return addresses, or local variables), the **stack pointer (`ESP` in x86 or `RSP` in x86_64)** decreases to a **lower memory address**. Conversely, when data is popped off the stack, the stack pointer increases, moving back toward **higher memory addresses**.

```
+------------------+
| Address   | Value|
+------------------+
| 0x7FFFFF20 | ... |  <-- Stack pointer now here (ESP)
| 0x7FFFFF1C | ... |
| 0x7FFFFF18 | ... |
| 0x7FFFFF14 | ... |
| 0x7FFFFF10 | ... |
+------------------+
```

```c
push %eax    ; // push a 4-byte value from EAX onto the stack (in x86)
```

```
+------------------+
| Address   | Value|
+------------------+
| 0x7FFFFF20 | ... |
| 0x7FFFFF1C | EAX |  <-- Stack pointer now here (ESP)
| 0x7FFFFF18 | ... |
| 0x7FFFFF14 | ... |
| 0x7FFFFF10 | ... |
+------------------+
```

```c
pop %eax     ; // pop the top value of the stack into EAX (in x86)
```

```
+------------------+
| Address   | Value|
+------------------+
| 0x7FFFFF20 | ... |  <-- Stack pointer now here (ESP)
| 0x7FFFFF1C | EAX |
| 0x7FFFFF18 | ... |
| 0x7FFFFF14 | ... |
| 0x7FFFFF10 | ... |
+------------------+
```

---
#### Little-Endian Byte Ordering

In a **little-endian** system, **the least significant byte (LSB)** is stored at the lowest memory address, and the **most significant byte (MSB)** is stored at the higher memory addresses.

Let’s take the 64-bit value `0x123456789ABCDEF0` as an example.
- **Lower 32 bits** (least significant): `0x9ABCDEF0`
- **Upper 32 bits** (most significant): `0x12345678`

```c
movl $0x12345678, 4(%esp)   ;
movl $0x9ABCDEF0, (%esp)    ;
```

- The **lower** 32 bits (`0x9ABCDEF0`) are stored at the **lower address** (i.e., at `ESP`).
- The **upper** 32 bits (`0x12345678`) are stored at the **higher address** (i.e., at `ESP + 4`).
```
+-------------------------+
| Address     | Value     |
+-------------------------+
| 0xBFFFF628 | 0x9ABCDEF0 | <- Lower 32 bits (least significant)
+-------------------------+
| 0xBFFFF62C | 0x12345678 | <- Upper 32 bits (most significant)
+-------------------------+
```

![[Screenshot from 2024-12-13 21-42-53.png]]
![[Screenshot from 2024-12-13 21-43-03.png]]
The upper 32 bits are stored at the higher address in the stack.


---

```c
#include <stdio.h>

void my_function(int x) {
    int y = x + 10;  // Local variable
    printf("y = %d\n", y);
}

int main() {
    my_function(5);  // Call with argument 5
    return 0;
}
```

```
   High Memory Addresses (Before Function Call)
   ┌──────────────────────────┐
   │ Free / Unused Memory     │  <- (e.g., old RSP before call)
   ├──────────────────────────┤
   │ Caller Stack Frame       │
   ├──────────────────────────┤
   │                          │  
   └──────────────────────────┘
   
   After Calling `my_function(5)`, the stack looks like this:

   ┌──────────────────────────┐  <- Old stack pointer (before function call)
0x1000 │ Previous Stack Data     │  
   ├──────────────────────────┤
0x0FF8 │ Argument (x = 5)        │  <- Function argument (caller may push this)
   ├──────────────────────────┤
0x0FF0 │ Return Address (e.g., 0x1234) │ <- Stored return address
   ├──────────────────────────┤
0x0FE8 │ Saved RBP (Old rbp)    │  <- Old base pointer (%rbp of caller)
   ├──────────────────────────┤
0x0FE0 │ Local Variable (y)     │  <- Space allocated for local variable y
   ├──────────────────────────┤
0x0FD8 │ More Local Variables   │  <- (if any, more space is allocated)
   ├──────────────────────────┤
   │                          │  
   └──────────────────────────┘  <- New RSP (stack pointer after allocation)

```


## Function Argument Passing: System V AMD64 ABI

In 64-bit Assembly (System V ABI, used on Linux/macOS), **function arguments are passed via registers** rather than the stack (as in 32-bit).
This is different on **Windows (x64)**: it uses a different calling convention (`rcx`, `rdx`, `r8`, `r9` for the first four args). Let me know if you're targeting Windows and I’ll adjust.

#### First Six Integer or Pointer Arguments

| Argument # | Register |
| ---------- | -------- |
| 1st        | `rdi`    |
| 2nd        | `rsi`    |
| 3rd        | `rdx`    |
| 4th        | `rcx`    |
| 5th        | `r8`     |
| 6th        | `r9`     |
|            |          |
|            |          |
|            |          |

#### Return Value

- Stored in `rax`

```c
; ----- function starts here -----
my_func:
    push    ebp            ; save caller's frame pointer
    mov     ebp, esp       ; establish this frame
    sub     esp, 8         ; (optional) local space

    ; ... function body ...
    mov     eax, 123       ; place return value in EAX

    leave                  ; shorthand for: mov esp, ebp  /  pop ebp
    ret                    ; pop return-address → EIP

```

we can remove  `leave` in this routine because there is **no stack frame to leave**.

```c
push rbp
mov  rbp, rsp
sub  rsp, 32          ; space for locals
⋯                     ; body
leave                 ; restores rsp and pops rbp
ret
```

## Caller-saved vs. callee-saved registers

on the two major 64-bit platforms: **System V AMD64 (used by Linux and macOS)**, and **Windows x64**.
### 🧠 System V AMD64 (Linux / macOS)

In the System V AMD64 calling convention, which is the standard on Linux and macOS, the **caller is responsible** for preserving the following registers if it wants to use them after calling a function:  
`rax`, `rcx`, `rdx`, `rsi`, `rdi`, `r8`, `r9`, `r10`, `r11`, and the SIMD registers `XMM0` through `XMM15`.  
These are called **caller-saved registers** (also known as **volatile** registers), because the callee is allowed to overwrite them freely.

On the other hand, the registers `rbx`, `rsp`, `rbp`, and `r12` through `r15`, as well as `XMM16` through `XMM31` (used in high-performance SIMD code), are considered **callee-saved registers**.  
This means that **any function that modifies them must save their original values and restore them before returning**. The caller can safely assume these registers will retain their values across function calls.

### 🧠 Windows x64

The Windows x64 calling convention is similar, but with a few key differences.  
On this platform, the registers that are **caller-saved** include:  
`rax`, `rcx`, `rdx`, `r8`, `r9`, `r10`, and `r11`, along with `XMM0` through `XMM5`. These registers may be freely modified by any function call, and the caller must save them beforehand if needed.

Meanwhile, the **callee-saved** (non-volatile) registers are:  
`rbx`, `rsp`, `rbp`, `rdi`, `rsi`, and `r12` through `r15`.  
Additionally, the higher SIMD registers `XMM6` through `XMM15` must also be preserved by the callee.  
So if a function wants to use any of these non-volatile registers, it must push them onto the stack (or otherwise save them) at the beginning and restore them before returning.

```c
The caller can safely assume these registers will retain their values across function calls.

System V AMD64 (Linux/ maxOS)
`rbx`, `rsp`, `rbp`, and `r12` through `r15`, as well as `XMM16` through `XMM31`

Windows x64
`rbx`, `rsp`, `rbp`, `rdi`, `rsi`, and `r12` through `r15`.  SIMD registers `XMM6` through `XMM15`
```

##  System call

In **Linux x86_64**, system calls are made using the `syscall` instruction. You pass arguments through registers, set the syscall number in `rax`, then execute `syscall`.

```c
Register	Argument
rax	Syscall number
rdi	1st argument
rsi	2nd argument
rdx	3rd argument
r10	4th argument
r8	5th argument
r9	6th argument
```

```c
the kernel always return an error in the range [-1, -4095]
neg rax to get the errno
call __errno_location  wrt ..plt; get the pointer of errno
```
Only `rax` and the first **6 arguments** have fixed registers.

```c
ft_write:
    ; rdi=fd, rsi=buf, rdx=nbyte
    mov rax, 1; write sys call
    syscall
    cmp rax, -4095; check if rax < 0 and rax > -4095 that because -4095 is large unsigned number
    ; the kernel always return an error in the range [-1, -4095]
    jae ft_write_error ; Above or equal (unsigned)	unsigned
    jmp ft_write_end
    ft_write_error:
    neg eax; errno is 32bit number
    mov rbx, rax
    call __errno_location  wrt ..plt; get the pointer of errno
    ; gcc enables PIE by default.
    ; Use RIP-relative addressing so the relocation goes through the PLT / GOT and doesn’t modify .text.
    mov [rax], ebx
    mov rax, -1
    ft_write_end:
    ret
```

```c
write	1	Write to file/socket
read	0	Read from file/socket
exit	60	Exit program
open	2	Open a file
close	3	Close a file
mmap	9	Map memory
```

