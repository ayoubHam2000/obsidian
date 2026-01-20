**`leal` (Load Effective Address)**: This instruction calculates the effective address of the source operand and stores the result in the destination operand. Unlike a typical load instruction, `leal` does not actually load data from memory. Instead, it computes the address and stores that address in the specified register.

```c
leal var_7ch, %eax
<=>
int *eax = &var_7ch;
```