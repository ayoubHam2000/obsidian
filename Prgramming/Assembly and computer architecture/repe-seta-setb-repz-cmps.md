
## Related
[[Memory Segmentation in x86 Architecture]]

## Main

The [`cmps` instruction](https://github.com/HJLebbink/asm-dude/wiki/CMPS_CMPSB_CMPSW_CMPSD_CMPSQ) compares `[rsi]` and `[rdi]`. The [`repz` prefix](https://github.com/HJLebbink/asm-dude/wiki/REP_REPE_REPZ_REPNE_REPNZ) (alternately spelled `repe`) means to increment `rsi` and `rdi` then repeat `cmps` as long as `[rsi]` and `[rdi]` compare equal. The `rflags` register will be set on each iteration; the final iteration where `[rsi]` ≠ `[rdi]` is what will be used by `seta` (set if above) and `setb` (set if below).

In other words, the C pseudocode for those 3 instructions would look like this:

```c
0x401810:    repz cmps BYTE PTR ds:[rsi],BYTE PTR es:[rdi]
0x401812:    seta   dl
0x401815:    setb   al
```

```c
// Initial values
uint8_t *rsi = (...);
uint8_t *rdi = (...);
uint64_t rcx = (...);

// repz cmps BYTE PTR [rsi], BYTE PTR [rdi]
while (*rsi == *rdi && rcx > 0) {
    rsi++;
    rdi++;
    rcx--;
}

uint8_t dl = *rsi > *rdi;   // seta dl
uint8_t al = *rsi < *rdi;   // setb al
```

```c
repe cmpsb %es:(%edi), (%esi)

// Assuming esi and edi are pointers to the beginning of two strings
while (ecx-- > 0 && *esi == *edi) { 
esi++;
edi++; 
}

```

  **`repe`**: This stands for "Repeat while Equal." It's a **prefix** that modifies the behavior of the following instruction (`cmpsb` in this case). The `repe` prefix means that the instruction will continue to be executed as long as the comparison results in equality (`ZF` = 1, meaning zero flag is set) and the **counter** (`ecx` or `rcx`) is not zero. If a mismatch occurs, or the counter (`ecx`/`rcx`) reaches zero, the repetition will stop.

- **`cmpsb`**: This stands for "Compare String Byte." It compares the byte at the source address (`%esi`) with the byte at the destination address (`%edi`). The source and destination addresses are updated after each comparison (by incrementing or decrementing based on the direction flag `DF`).

- **`%es:(%edi)`**: This refers to the byte at the memory address contained in `edi`, using the `es` segment register. It represents the destination address for comparison.

- **`(%esi)`**: This refers to the byte at the memory address contained in `esi`, which is the source address for comparison.


**`seta`**: This stands for "Set if Above." It sets the destination operand (in this case, the `%dl` register) to 1 if the result of the previous comparison or operation was "above."
More specifically, `seta` will set the operand to 1 if the following condition holds:
- **Carry Flag (CF) = 0** and **Zero Flag (ZF) = 0**.
This means that the operation will set the byte to 1 if the first value is greater than the second value  (i.e., not equal and no carry occurred). If the condition is false, the instruction will set the byte to 0.
```c
cmp %ebx, %eax   # Compare %eax with %ebx (unsigned comparison)
seta %dl         # Set %dl to 1 if %eax > %ebx, otherwise set it to 0
```



**`setb`**: This stands for "Set if Below." It sets the destination operand (in this case, the `%al` register) to 1 if the result of the previous comparison or operation was **below**.
Specifically, `setb` will set the operand to 1 if the following condition holds:
- **Carry Flag (CF) = 1**.
- This means that the operation will set the byte to 1 if the first value is less than the second value in an unsigned comparison (i.e., a carry occurred). If the condition is false, the instruction will set the byte to 0.

```c
cmp %ebx, %eax   # Compare %eax with %ebx (unsigned comparison)
setb %al         # Set %al to 1 if %eax < %ebx, otherwise set it to 0
```

### General Syntax of an Assembly Instruction

In x86 assembly, an instruction like `repe cmpsb %es:(%edi), (%esi)` can be broken down into the following parts:

1. **Prefix (optional)**: Modifies the behavior of the core instruction.
2. **Operation/Mnemonic**: The core instruction that tells the CPU what to do.
3. **Operands**: The arguments or inputs for the instruction, such as registers or memory locations.
4. **Segment Override (optional)**: Specifies a particular memory segment to use, if needed.

```
[prefix] operation segment_override:operand1, operand2
```

**Segment Override (optional)**: This is used to explicitly specify which segment register to use when accessing memory. Normally, instructions default to using certain segments:

- `ds` (Data Segment) for most data accesses.
- `es` (Extra Segment) for destination addresses in string instructions.

If you want to access memory using a different segment register, you can use a **segment override**. In your example, `%es:(%edi)` uses the `es` segment explicitly for the memory address.

### rep stosl %eax, %es:(%edi)

#### Instruction Breakdown:

1. **`stosl %eax, %es:(%edi)`**:
    
    - **`stosl`** stands for **"Store String Long"**. It stores the 32-bit value in the **`eax`** register into the memory location pointed to by **`%edi`**.
    - **`%edi`** is the destination index register, which points to the memory location where the value in **`%eax`** will be stored. The memory segment used is determined by the **`%es`** segment register.
    - After each store operation, the value in `%edi` is automatically incremented (or decremented, depending on the direction flag) by 4 (since it's storing a 32-bit value, or "long" word).
2. **`rep`**:
    
    - **`rep`** is a **repeat prefix**. It means that the following `stosl` instruction will be repeated a number of times specified by the **`%ecx`** register.
    - After each repetition, the **`%ecx`** register is decremented by 1. The instruction will repeat until `%ecx` reaches 0.

```c
unsigned int *dest = (unsigned int *)edi;  // Pointer to memory at edi
unsigned int value = eax;  // Value to be stored
unsigned int count = ecx;  // Number of times to store

for (unsigned int i = 0; i < count; i++) {
    *dest = value;  // Store the value in memory
    dest++;  // Move to the next 32-bit memory location
}
```

### rep movsl (%esi), %es:(%edi) ;

#### Instruction Breakdown:

1. **`movsl`**:
    
    - **`movsl`** stands for **"Move String Long"**.
    - This instruction moves a **32-bit value** (a "long" in x86 terms) from the source memory location (pointed to by **`%esi`**) to the destination memory location (pointed to by **`%edi`**).
    - It does this by copying the 32-bit value at the address `%esi` points to into the memory location `%edi` points to.
    - After the move, the **`%esi`** (source index) and **`%edi`** (destination index) are both incremented by 4, because a "long" is 4 bytes (32 bits).
2. **`rep`**:
    
    - **`rep`** is a **repeat prefix**. It tells the processor to repeat the following instruction (in this case, **`movsl`**) for **`%ecx` times**.
    - Each time **`movsl`** is executed, **`%esi`** and **`%edi`** are incremented by 4 (moving to the next 32-bit value), and **`%ecx`** is decremented by 1.
    - The operation will continue until **`%ecx`** reaches zero.

```c
void move_data(int *src, int *dest, int count) {
	for (int i = 0; i < count; i++) 
	{
		dest[i] = src[i];
	}
}
```