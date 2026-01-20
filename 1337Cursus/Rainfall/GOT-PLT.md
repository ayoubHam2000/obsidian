### **What Are GOT and PLT?**

1. **GOT (Global Offset Table):**
    
    - The **GOT** is used in dynamic linking. It holds the addresses of external functions and global variables that the program uses, like `puts` or `exit`.

| Section    | What it holds                                                                                   | When it is written                                                                     | Lazy-binding target?                                                                                                                                                                                                                                        |
| ---------- | ----------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `.got`     | pointers used for **data** (and for functions when _eager_ binding or full RELRO is in effect)  | populated once by the dynamic loader while the program is still starting               | **No** – entries are _not_ rewritten lazily ([stackoverflow.com](https://stackoverflow.com/questions/11676472/what-is-the-difference-between-got-and-got-plt-section "linux - What is the difference between .got and .got.plt section? - Stack Overflow")) |
| `.got.plt` | the subset of the Global Offset Table that backs **PLT stubs** (one slot per external function) | **rewritten on the first call** to each function – this is what “lazy binding” updates | **Yes** – entries are patched at run-time ([elswix.com](https://elswix.com/articles/6/PLT-and-GOT.html "PLT & GOT"), [elswix.com](https://elswix.com/articles/6/PLT-and-GOT.html "PLT & GOT"))                                                              |

2. **PLT (Procedure Linkage Table):**
    
    - The **PLT** contains function stubs. When a program calls a function that isn't loaded yet, it jumps to the corresponding **PLT** entry.
        
    - The **PLT** either directly jumps to the function if it’s already been resolved or triggers the **dynamic linker** (ld-linux.so) to resolve the address.

### **How the GOT Gets Updated:**

Step-by-step: how the address of `puts` is resolved

Below is the exact control flow for a 32-bit non-PIE Linux binary that calls `puts` for the very first time
```c
1. `main` calls the PLT stub
call   puts@plt        ; in section .plt

2. PLT stage 1 – indirect jump through `.got.plt`
jmp *GOT_PLT[puts]     ; first instruction in puts@plt

Initially GOT_PLT[puts] does not contain the address of puts.
Instead it points back into the same PLT stub (to instruction #2 below).

3. PLT stage 2 – push relocation index & jump to the resolver stub
push $index            ; index of GOT_PLT[puts]
jmp  plt0              ; plt0 is PLT entry 0

PLT entry 0 (sometimes called the resolver stub) is shared by every external function.
It jumps into the dynamic linker, passing:
the link-map of the binary, and
the relocation index just pushed.

4. Dynamic linker (ld-linux.so) work

Inside the loader’s routine (usually _dl_runtime_resolve_xxx) the linker:
looks up the symbol “puts” in every loaded object,
finds its absolute address inside libc.so,
writes that address into GOT_PLT[puts], and
finally returns directly to puts itself (so the first call still succeeds).
The moment it writes the address, lazy binding for puts is finished.

5. Subsequent calls

Next time puts@plt executes step 1, the very first jmp *GOT_PLT[puts] now lands straight in libc’s puts.
No loader, no extra pushes, just one indirect jump – the overhead is gone.
```

#### Why split the tables at all?

- **Security & flexibility** – keeping function pointers that can change (**`.got.plt`**) separate from data-relocations (**`.got`**) lets glibc combine protections such as _partial_ and _full_ RELRO:
    
    - _partial‐RELRO_ makes `.got` read-only after load (protecting global data) but leaves `.got.plt` writable so lazy binding still works.
        
    - _full‐RELRO_ forces immediate (eager) binding, merges `.got.plt` back into `.got`, then marks the whole page read-only.
        
- **Performance** – lazy binding lets large programs start faster, resolving only the functions they really call.

####  Take-away

- The **only entries that change during lazy binding live in `.got.plt`.**  
    `.got` is unaffected unless you compile with full RELRO/eager binding.
    
- The first invocation of `puts` travels: **`main → puts@plt → GOT_PLT[puts] → PLT resolver → ld.so → libc puts`**.  
    Every later invocation bypasses the linker entirely.


### **Security Mitigations**

Since this technique has been known for a long time, several mitigations have been implemented to protect against **GOT overwriting** and **PLT redirection**:

1. **RELRO (Read-Only Relocations)**: This is a protection mechanism that prevents writing to the **GOT**. There are two types:
    
    - **Partial RELRO**: Makes the **GOT** read-only after the initial resolution.
        
    - **Full RELRO**: Not only makes the **GOT** read-only but also ensures that all symbols are resolved before execution, preventing exploitation of unresolved function addresses.
        
2. **PIE (Position Independent Executable)**: This makes it harder for attackers to predict where **GOT** entries are located, thus mitigating attacks that rely on the fixed address of **GOT** sections.

### **Why is it called a "Relocation Address"?**

The term **"relocation address"** is used because the address of an external symbol (such as a function or variable) needs to be **relocated** from its **initial placeholder** (which is typically a **stub address** or **symbol reference**) to its **actual address** in memory.

### Commands

```
objdump -R exec
The objdump -R command in Linux is used to display the relocation entries
```

### **Dynamically resolve** the address of the external function

```c
default rel
call malloc wrt ..plt
```
indicates that the assembly code needs to **dynamically resolve** the address of the external function `malloc` at **runtime** rather than using an **absolute address**. This is necessary for **position-independent code** (PIC) and **dynamically linked binaries** that rely on **GOT/PLT** for function address resolution.

### **Why Can't You Use the Absolute Address of `malloc`?**

- **Position-Independent Code (PIC)**: Modern systems, especially when using **shared libraries** (like `libc`), use **ASLR** (Address Space Layout Randomization) to randomize the locations of shared libraries in memory. The **absolute address** of a function like `malloc` in `libc` cannot be known in advance because it might be loaded into a different memory address each time the program is executed.
    
- **Shared Libraries**: When linking dynamically, the actual memory address of `malloc` (or any external function) is not known until runtime. So, **absolute addresses** cannot be used in the compiled code because they would break the flexibility of loading libraries at different locations in memory.

- The **PLT** is used for **lazy function resolution** in dynamically linked programs.
- `wrt` is an assembly modifier used to specify that the address of the function should be resolved **with respect to the PLT**.

### **Why Use `default rel`?**

- **`default rel`** refers to **relocatable** code, meaning that the code doesn't rely on absolute addresses and instead uses **relative addressing** or **runtime relocations**.
    
- This is a requirement in modern systems with **Position Independent Executable (PIE)** code, which is needed for **security** (e.g., **ASLR**).
    
- **`rel`** ensures that the **relocation** happens during **runtime** when the **actual addresses** are known, instead of at **compile-time**.


### Further reading

- How the dynamic linking works
- https://chatgpt.com/g/g-p-67c82d11c6dc8191aa4bac9681a63d3a-rainfall/c/684452fb-bbdc-8008-8997-b56e66058caa?model=o3
