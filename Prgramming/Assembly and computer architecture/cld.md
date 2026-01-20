## 🔍 `cld` — **Clear Direction Flag**

### ✅ Purpose:

`cld` clears the **Direction Flag (DF)** in the `rflags` register, which controls **string instruction direction** in x86 assembly (like `movsb`, `cmpsb`, `scasb`, etc.).

## 🧠 What Does It Actually Do?

- **Direction Flag (DF)** determines whether pointer registers (`rsi`, `rdi`) **increment** (forward) or **decrement** (backward) during string operations.
    
- When DF = **0** (after `cld`), memory operations go **forward**.
    
- When DF = **1** (after `std`), memory operations go **backward**.