The sub instruction stores in the value of its second operand the result of subtracting the value of its first operand from the value of its second operand. As with add, whereas both operands may be registers, at most one operand may be a memory location.

```c
sub <reg>, <reg>  
sub <mem>, <reg>  
sub <reg>, <mem>  
sub <con>, <reg>  
sub <con>, <mem>  
```

```c
Examples  
sub %ah, %al — AL is set to AL - AH  
sub $216, %eax — subtract 216 from the value stored in EAX
```

```c
subb %al, %cl
```

**`b`**: The `b` (in `subb`) stands for **byte**. This indicates that the operation is working on **8-bit operands** (1 byte). In x86 assembly, the size of the operation is sometimes suffixed to the instruction mnemonic:

- `b` = byte (8 bits)
- `w` = word (16 bits)
- `l` = long (32 bits)
- `q` = quadword (64 bits)