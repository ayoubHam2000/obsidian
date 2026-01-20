### How the `pop` Instruction Works:

1. **Read the value at the current top of the stack**, where the stack pointer (**ESP** in 32-bit or **RSP** in 64-bit) is pointing.
2. **Move this value into the specified register or memory location**.
3. **Increment the stack pointer** to point to the next value below the top of the stack.