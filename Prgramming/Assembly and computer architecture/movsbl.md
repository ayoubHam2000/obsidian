```c
movsbl %al, %eax
```

The instruction `movsbl %al, %eax` is an **x86 assembly** instruction that performs a **sign extension** when moving data from an 8-bit register (`%al`) to a 32-bit register (`%eax`). Let’s break down its components:

**`movsb`**: This stands for "Move **Sign-Extended Byte**." It moves a byte (8 bits) from one register or memory location to another and **sign-extends** it to a larger size. Specifically, it takes the sign bit (the most significant bit) of the source operand and extends it into the higher bits of the destination register.

**`movsbl`**: The suffix `bl` here means:

- `b` = byte (8-bit source).
- `l` = long (32-bit destination).

#### Example 2 (Negative Number):

Suppose `%al = 0xF2` (which is `-14` in decimal):

- Binary form: `11110010`
- Sign bit (most significant bit): `1` (indicating a negative number in two's complement)

When `movsbl %al, %eax` is executed:

- The value in `%al` is `11110010` (8 bits).
- Since the sign bit is `1`, the upper 24 bits of `%eax` will be filled with `1`s.
- `%eax` will become: `11111111 11111111 11111111 11110010`
    - This is `0xFFFFFFF2` (which is `-14` in decimal when interpreted as a 32-bit signed integer).