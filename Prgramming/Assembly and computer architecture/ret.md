The **`ret`** (return) instruction in assembly is used to return control from a function (or subroutine) back to the calling function.

The **`ret`** instruction performs the following steps:

1. **Pop the return address** from the stack (incrementing the **RSP**)
2. **Jump to the return address** (changing **RIP**)

When a function is called using the `call` instruction, the **return address**  is **pushed onto the stack** and It **jumps** to the `some_function` code.