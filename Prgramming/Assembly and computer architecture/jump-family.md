## JA anf JG

**JUMP IF ABOVE** AND **JUMP IF GREATER**

JG interprets the flags as though the comparison was signed, and JA interprets the flags as though the comparison was unsigned

- `ja` jumps if `CF = 0` and `ZF = 0` (unsigned Above: no carry and not equal)
- `jg` jumps if `SF = OF` and `ZF = 0` (signed Greater, excluding equal)

```c
cmp eax, edx
ja somewhere ; will go "somewhere" if eax >u edx
             ; where >u is "unsigned greater than"

cmp eax, edx
jg somewhere ; will go "somewhere" if eax >s edx
             ; where >s is "signed greater than"
```


```
jmp Unconditional

Mnemonic	Synonym(s)	Condition	For...

je	jz	Zero flag = 1 (ZF=1)	equal
jne	jnz	Zero flag = 0 (ZF=0)	not equal
jg	jnle	Greater (signed)	signed
jge	jnl	Greater or equal (signed)	signed
jl	jnge	Less than (signed)	signed
jle	jng	Less or equal (signed)	signed
ja	jnbe	Above (unsigned)	unsigned
jae	jnb, jnc	Above or equal (unsigned)	unsigned
jb	jnae, jc	Below (unsigned)	unsigned
jbe	jna	Below or equal (unsigned)	unsigned

jc	Jump if carry	CF = 1
jnc	Jump if not carry	CF = 0
jo	Jump if overflow	OF = 1
jno	Jump if not overflow	OF = 0
js	Jump if sign	SF = 1
jns	Jump if not sign	SF = 0
jp	Jump if parity even	PF = 1
jnp	Jump if parity odd	PF = 0

jcxz	Jump if cx = 0 (32-bit: ecx, 64-bit: rcx)
jecxz	Jump if ecx = 0 (32-bit only)
jrcxz	Jump if rcx = 0 (64-bit only)
Used especially in loop or string ops.

CF = 0 && ZF = 0	ja	First > Second (strict above)
CF = 0	jae	First ≥ Second (above or equal)
CF = 1	jb	First < Second (strict below)
CF = 1 or ZF = 1	jbe	A ≤ B (Below or Equal)
ZF = 1	je / jz	A == B
ZF = 0	jne / jnz	A ≠ B

```

```c
Above (unsigned) and Above or equal (unsigned)

mov rax, 5
mov rbx, 2
cmp rbx, rax      ; 2 < 5
ja label          ; will jump: 2 is below 5 → CF=0, ZF=0
```