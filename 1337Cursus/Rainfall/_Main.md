
## What is SUID

On Unix-like operating systems, the SUID (Set User ID) flag is a special file permission bit that allows an executable to run with the privileges of the file’s owner

### Setting the SUID Bit

```bash
chmod u+s filename
```

```bash
chmod u-s filename
```



## Buffer overflow

A buffer overflow occurs when a program writes more data into a buffer (fixed-size memory space) than it can hold, causing it to overwrite adjacent memory. This can lead (in out case) to overwrite the return address on the stack.

By overwrite the return address we can redirect the execution to our own code that has been written on the stack by get using user input.

  
Modern systems prevent such attacks using:

1. NX (Data Execution Prevention) → Prevents execution of shellcode in writable memory.

2. ASLR (Address Space Layout Randomization) → Randomizes memory addresses.

3. Stack Canaries → Detects buffer overflows before returning.

`checksec` command for checking these flags


## Ref

`checksec`  command
[[Stack]]
[[Endianness]]

## TODO

- buffer overflow
- buffer overflow protection
- [[GOT-PLT]]
	- [9: Overwriting Global Offset Table (GOT) Entries with printf() - Intro to Binary Exploitation (Pwn)](https://www.youtube.com/watch?v=KgDeMJNK5BU)
	- [Global Offset Table (GOT) and Procedure Linkage Table (PLT) - Binary Exploitation PWN101](https://www.youtube.com/watch?v=B4-wVdQo040&list=PLchBW5mYosh_F38onTyuhMTt2WGfY-yr7&index=12&t=1013s)
- endianness
- Format String Exploits
	- (https://www.youtube.com/watch?v=QOgD3jPHyRY)
	- https://codearcana.com/posts/2013/05/02/introduction-to-format-string-exploits.html
	- https://axcheron.github.io/exploit-101-format-strings/
	- The use of `env -i` is also suggested to ensure that the environment is clean and the exploit is executed with the expected conditions.
- Virtual memory
- ELF file
- read about other binary exploitation subjects
### commands

- checksec
	- RELRO (Relocation Read-Only)
	- Stack Canary (Stack)
	- NX (No-eXecute)
	- PIE (Position Independent Executable)
	- RWX Segments
	- Fortify: Enabled
	- ASLR (Address Space Layout Randomization)
	- RPATH (Runtime Library Search Path)
RUNPATH (Runtime Search Path)
- objdump
	- objdump -t ./myprogram
	- objdump -R
	- `objdump -h <binary>	List sections in the ELF file.`
	- 
- readelf
	- readelf -S
	- `readelf -S <binary>`
- ldd

## Software

https://cutter.re/
https://ghidra-sre.org/
https://vscodium.com/


