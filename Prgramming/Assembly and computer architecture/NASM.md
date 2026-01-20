**NASM (Netwide Assembler)** is a widely used assembler for the **x86 and x86-64** architectures. It supports the **Intel syntax** and is known for its clarity, portability, and performance.

- Supports 16-bit, 32-bit, and 64-bit modes (`bits 16`, `bits 32`, `bits 64`)
    
- Outputs ELF, COFF, Mach-O, binary, and other formats
    
- Works well for Linux system programming and OS development
    
- Highly scriptable with a powerful macro and preprocessor system

## 🧱 2. Structure of a NASM Assembly File

A NASM file is composed of **sections**, **directives**, **labels**, **instructions**, and optional **preprocessor elements**. These elements are combined to produce an object file which can then be linked into an executable.

```c
section .data
    helloMsg db "Hello, world!", 0xA  ; 
    count    dq 5                     ; 64-bit integer initialized to 5

section .bss
    buffer resb 64     ; reserve 64 bytes
    array  resq 10     ; reserve 10 quadwords (64-bit)

section .text
global _start         ; Entry point for the linker

_start:
    mov rax, 60       ; syscall: exit
    xor rdi, rdi      ; exit code 0
    syscall

```

- the `0xA` is a **hexadecimal literal** representing the ASCII value **10**, which corresponds to a **newline character (`\n`)** in ASCII.
### 2.1 The `.text` Section

This is the **code section**—it holds the program's logic and instructions.

- The `global` keyword is used to **declare symbols (labels) as globally accessible**, meaning they can be referenced **outside the current file** — usually by the linker or other modules.  ... Then in `file2.asm`, you can access it using `extern my_function`.
### 2.2 The `.data` Section

This section contains **static data that is initialized before runtime**. It is embedded in the binary file, meaning values here occupy space on disk and in memory. Data in `.data` is stored in the **read-write data segment** of the final executable.

- `db` = define byte
    
- `dw` = define word (2 bytes)
    
- `dd` = define doubleword (4 bytes)
    
- `dq` = define quadword (8 bytes)

### 2.3 The `.dss` section

This section declares **variables that are reserved but not initialized**. They will be zero-filled at runtime.

- **Used for:** Large buffers or uninitialized variables.
- `resb` Reserve bytes
- `resw` Reserve words
- `resd` Reserve dwords
- `resq` Reserve qwords

## 2.4 Other sections

- 1. section `.rodata`
	 Sometimes used to place constants or strings that should be **read-only** (if you're compiling with `gcc`, for example). since NASM doesn't enforce read-only protections the same way ELF compilers might.


## 3. Macros

#### `%define`
```c
%define EXIT_SYSCALL 60        ; constant
%define zero     xor eax, eax  ; code snippet alias

zero           ; expands to:  xor eax, eax
mov   rax, EXIT_SYSCALL
```

#### Multi-line parameterised macros – `%macro`

```c
%macro  name  paramCount  [min-max]|[n+]     ; paramCount can be 0
    ; macro body – you may reference %1, %2 … %0
%endmacro

;%0 expands to the actual count passed by the caller.

```

```c
%macro  write 2               ; %1 = address, %2 = length
        mov     rax, 1        ; sys_write
        mov     rdi, 1        ; fd = stdout
        mov     rsi, %1
        mov     rdx, %2
        syscall
%endmacro

section .data
msg     db  "Hello!", 0xA
msglen  equ $-msg

section .text
global  _start
_start:
        write   msg, msglen   ; expands into five instructions
        mov     rax, 60
        xor     rdi, rdi
        syscall
```
- Must sit **by itself at the start of a line** (optionally after a label).
- A `%macro` can _generate_ any instruction you like, including `jmp`, `call`, `je`, etc., that point at a label—so the code produced by the macro can alter the program’s runtime control-flow exactly the same as handwritten assembly.
#### `%imacro` – “inline macros” that look like mnemonics
```c
%imacro   pushstr  1
        db  %1
        db  0
%endimacro

pushstr  "ERROR"   ; feels like an instruction
```

- **Parameter handling (`%1`, `%2`, …, `%0`) is identical** between `%macro` and `%imacro`.
- **Only the invocation rules differ**: an `%imacro` can share its line with other tokens just like an instruction mnemonic. `loop_start:   rep  movi  rdi, 0`
- Use ranges (`1-3`) or the plus sign (`0+`) if you want optional or variable-length argument lists.
```c
%imacro  logmsg  1-3      ; 1 to 3 operands allowed
        ; %0 is the actual count supplied by the caller
        ; %1, %2, %3 are the operands (if present)
%endimacro

%imacro  bytes   0+       ; any number of operands (0 or more)
        db      %1-%?
%endimacro
```
- Use **`%macro`** when the expansion represents a “statement” that logically replaces a whole line (system-call stubs, function prologues, data generators, etc.).
    
- Use **`%imacro`** when you want something that behaves like a single instruction and can sit comfortably inside normal code flow.
- A `%macro` can _generate_ any instruction you like, including `jmp`, `call`, `je`, etc., that point at a label—so the code produced by the macro can alter the program’s runtime control-flow exactly the same as handwritten assembly.
####  Each macro invocation gets its own private labels if you prefix them with **`%%`**:
```c
%macro spinlock 1
%%retry:
        lock bts  [%1], 0
        jc  %%retry
%endmacro
```

#### Conditional assembly inside macros
NASM’s pre-processor directives (`%if`, `%elif`, `%else`, `%endif`) can live within macros to generate code only under certain build-time conditions.
```c
%macro  dbgprint 2
%ifdef DEBUG
        write   %1, %2
%endif
%endmacro
```

####  Undefining and re-defining
```c
%undef   EXIT_SYSCALL
%define  EXIT_SYSCALL  231    ; switch to x86-64 “exit_group”
```

## 4.Directives
### `times` directive

**repeat a value, instruction, or block** a specified number of times.

```c
times <count> <value or instruction>
```

```
section .data
zero_bytes times 16 db 0      ; 16 zero bytes
pattern     times 4 db 0xAA   ; 4 bytes with 0xAA
```

 **Repeat Instructions (code generation)**

```
section .text
global _start

_start:
    times 5 nop               ; Insert 5 NOPs
```

### `equ`

It stands for **“equate”**, and it works like `#define` in C or `const` in other languages.

```c
NAME equ value

- `NAME` becomes a symbolic constant.
- `value` is any constant expression or address (no variables or labels that change).
```

```c
STDOUT  equ 1
EXIT_SYSCALL equ 60
```

- Arithmetic

```c
ROWS     equ 4
COLUMNS  equ 8
TOTAL    equ ROWS * COLUMNS
```

`equ` values are **resolved at assembly time**. They're pure constants — you **cannot assign to them**.

### include

`%include` is a **preprocessor directive** that tells NASM to **insert the contents of another file** into the current source file **at compile time**, as if you had copied and pasted it there.

```c
%include "filename.asm"
```

### xdefine

`%xdefine` is a NASM **preprocessor directive** used to define **text substitutions**, just like `%define`, **but with delayed evaluation**.

```
%define  A  10
%define  B  A + 5     ; A is replaced immediately

mov eax, B            ; becomes: mov eax, 10 + 5 → mov eax, 15
```

```
%xdefine  A  10
%xdefine  B  A + 5     ; A is kept as a symbolic reference

mov eax, B            ; becomes: mov eax, A + 5 → mov eax, 10 + 5
```

## assign

`%assign` is a **NASM preprocessor directive** that defines a **numeric constant** — specifically for **integer values** — at **compile time**.

```c
%assign name value
```

```c
%assign counter 0

%rep 5
    ; do something
    ; each time we can use counter
    ; for example, define labels or constants
    %assign counter counter + 1
%endrep
```

```c
; Define symbolic key codes
%assign ID 0
KEY_UP     equ ID
%assign ID ID + 1
KEY_DOWN   equ ID
%assign ID ID + 1
KEY_LEFT   equ ID
%assign ID ID + 1
KEY_RIGHT  equ ID
```

Now:

- `KEY_UP` = 0
- `KEY_DOWN` = 1
- `KEY_LEFT` = 2
- `KEY_RIGHT` = 3

This is like a C-style enum — but done at **assembly time** using `%assign`.

### struct

`struc, endstruc, istruc, iend, at`
A **pattern of bytes** in memory that you organize and access using labels or pointers.

```c
struc Rectangle
    .x      resd 1
    .y      resd 1
    .width  resd 1
    .height resd 1
endstruc

section .bss
rect1 resb Rectangle_size
```

```c
mov eax, [rect1 + Rectangle.width]
```

```c
section .bss
rects resb Rectangle_size * 10
```

To access the 3rd rectangle:
```c
lea rsi, [rects + Rectangle_size * 2]
mov eax, [rsi + Rectangle.height]
```

Create an initialized instance using `istruc`
```c
section .data
person1:
    istruc Person
        at Person.name,   db "Alice", 0, 0, 0, 0, 0   ; total 10 bytes
        at Person.age,    db 25
        at Person.height, dw 165
    iend
```
## More
| Category | Key Directives |
| -------- | -------------- |
|          |                |

|           |                             |
| --------- | --------------------------- |
| Constants | `equ`, `%define`, `%assign` |

|   |   |
|---|---|
|Repetition/Alignment|`times`, `align`|

|   |   |
|---|---|
|Sections & Binaries|`section`, `org`, `bits`|

|   |   |
|---|---|
|Structures|`struc`, `istruc`, `endstruc`, `at`|

|   |   |
|---|---|
|Symbols & Linking|`global`, `extern`|

|   |   |
|---|---|
|Preprocessing|`%macro`, `%if`, `%include`, `%rep`|

|                      |                                  |
| -------------------- | -------------------------------- |
| Metadata & Debugging | `default rel`, `.note.GNU-stack` |
|                      |                                  |

```





%deftok
%rep
%align

%ifmacro
%ifidn
%ifnidn

%exitmacro
%push
%pop
%error
%warning

section
segment
org
bits


```
### 📦 **Data Definition Macros**

Used to define initialized or reserved data.

- `db` – Define byte(s)
    
- `dw` – Define word(s) (2 bytes)
    
- `dd` – Define double word(s) (4 bytes)
    
- `dq` – Define quad word(s) (8 bytes)
    
- `dt` – Define 10-byte floating-point data
    
- `do` – Define octaword (16 bytes)
    
- `dy` – Define 32-byte data

- `equ` - Stands for "equate" — used to define constants in NASM
    
- `dz` – Define 64-byte data
    
- `resb` – Reserve byte(s)
    
- `resw` – Reserve word(s)
    
- `resd` – Reserve double word(s)
    
- `resq` – Reserve quad word(s)
    
- `rest` – Reserve 10 bytes
    
- `reso`, `resy`, `resz` – Reserve 16, 32, 64 bytes

### 🧠 **Macro & Preprocessor Control**

- `%define` – Define a constant or macro

- `%include` - insert the content of other file
    
- `%undef` – Undefine a name
    
- `%xdefine` – Like `%define`, but delayed evaluation
    
- `%assign` – Assign a numeric value to a symbol
    
- `%deftok` – Define a token (rare)
    
- `%macro` – Define a multi-line macro
    
- `%imacro` – Define an inline macro (instruction-like)
    
- `%endmacro` – Ends a macro or imacro
    
- `%rep` – Repeat a block N times
    
- `%endrep` – Ends `%rep` block

### 🧾 **Conditional Assembly**

- `%if`, `%elif`, `%else`, `%endif` – Conditional assembly
    
- `%ifdef`, `%ifndef`, `%ifmacro`, `%ifidn`, `%ifnidn` – Condition based on symbol/macro existence or equality

### 🔄 **Flow Control Inside Macros**

- `%exitmacro` – Exit a macro early
    
- `%push`, `%pop` – Save/restore preprocessor context
    
- `%error` – Emit a custom error during preprocessing
    
- `%warning` – Emit a warning

### 🧩 **Code and Segment Management**

- `global` – Make a symbol accessible to the linker
    
- `extern` – Declare a symbol defined in another file
    
- `section`, `segment` – Define a code or data section
    
- `org` – Set starting address (useful for bootloaders)
    
- `bits` – Specify code mode: `bits 16`, `bits 32`, `bits 64`

### 🛠️ **Useful Constants and Built-ins**

- `__FILE__`, `__LINE__` – Current file name and line number
    
- `$` – Current address in section (e.g., `msglen equ $ - msg`)
    
- `$$` – Section start address

### Struct

`struc, endstruc, istruc, iend, at`


## Extra

### X86 Fundamental Data Types


- **Byte (8 bits)**
    
    - Used for: Characters, small integers, Binary Coded Decimal (BCD) values
        
- **Word (16 bits)**
    
    - Used for: Characters, integers
        
- **Double Word (32 bits)**
    
    - Used for: Integers, single-precision floating-point numbers
        
- **Quad Word (64 bits)**
    
    - Used for: Integers, double-precision floating-point numbers, packed integers
        
- **Quint Word (80 bits)**
    
    - Used for: Double extended-precision floating-point numbers, packed BCD
        
- **Double Quad Word (128 bits)**
    
    - Used for: Packed integers, packed floating-point values
        
- **Quad Quad Word (256 bits)**
    
    - Used for: Packed integers, packed floating-point values

### Reserved words

Declaration Directives
- `global`
- `extern`
Section Directives
 - `section .text` – Code section (executable instructions)
 - `section .data` – Initialized data
 - `section .bss` – Uninitialized data
 Data Definition Directives
 - `db` – Define byte
- `dw` – Define word (2 bytes)
- `dd` – Define double word (4 bytes)
- `dq` – Define quad word (8 bytes)
- `dt` – Define 10 bytes (for 80-bit floats)
Instruction Keywords
`mov`, `add`, `sub`, `jmp`, `call`, `ret`, `int`, etc.
Macros and Control Directives
`%define`, `%if`, `%else`, `%endif`, `%macro`, `%endmacro`
Other Directives
- `equ` – Constant definition
- `times` – Repeat an instruction or data
- `resb`, `resw`, `resd`, `resq` – Reserve uninitialized space in `.bss`
register names (`eax`, `rax`, `esp`)