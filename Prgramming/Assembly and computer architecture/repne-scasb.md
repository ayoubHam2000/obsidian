## Related

[[repe-seta-setb-repz-cmps
[[cld]]

## Main

```c
repne scasb %es:(%edi), %al
```

- **`repne`**: This stands for "Repeat while Not Equal." It repeats the following instruction (`scasb`) as long as the bytes being compared are **not equal** and the counter (`ecx`) is not zero. If a match is found or the counter reaches zero, the loop stops.
    
- **`scasb`**: This stands for "Scan String Byte." It compares the byte in the `al` register with the byte at the memory address pointed to by `%edi` (with the segment register `es` usually defaulting to the data segment `ds`).
    
    After each comparison:
    
    - `%edi` is incremented (or decremented depending on the direction flag) to point to the next byte.
    - The flags (Zero Flag, Carry Flag, etc.) are updated based on the result of the comparison.


```c
while (ecx > 0 && *esi != al)
{
	ecx--;
	esi++;
}
```


```c
cld                     ; Search forward
mov rdi, mystr          ; RDI = address of string
mov rcx, 11             ; RCX = length to search
mov al, 'e'             ; AL = character to search for
repne scasb             ; search until match or end
```


```
rcx controls how many comparisons to do.

rep	    Repeat        Repeat while rcx != 0	no flags
repe	Repeat Equal  Repeat while ZF = 1 and rcx != 0	Zero Flag = 1
repz	Repeat Zero	  Same as repe	Zero Flag = 1
repne	Repeat Not Equal	Repeat while ZF = 0 and rcx != 0	Zero Flag = 0
repnz	Repeat Not Zero	    Same as repne	Zero Flag = 0

cmpsb byte (8-bit) rsi++, rdi++
cmpsw byte (16-bit) rsi+=2, rdi+=2
cmpsd byte (32-bit) rsi+=4, rdi+=4
cmpsq byte (64-bit) rsi+=8, rdi+=8

scasb	byte (8-bit)	AL vs byte [rdi]	rdi++
scasw	word (16-bit)	AX vs word [rdi]	rdi+=2
scasd	dword (32-bit)	EAX vs dword [rdi]	rdi+=4
scasq	qword (64-bit)	RAX vs qword [rdi]	rdi+=8
```