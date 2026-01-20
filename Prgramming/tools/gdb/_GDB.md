
## Commands

### General

```css
run args: Start the program

disassemble main

thread: Chose thread to operate on.

q: Quit

kill:  Terminate the program being debugged

n /ni: Step over (next) — Executes the current line and moves to the next one, skipping function calls.

s / si: Step into (step) — Executes the current line and steps **into** function calls.

c: Continue — Resumes program execution until the next breakpoint or program termination.

finish: Continue execution until the current function returns.

b [function/line]: Set a breakpoint at a function or a line.
	break foo.c:5
	break 5

d [breakpoint number]: Delete a breakpoint.

info: display help for info (it has many useful commands)

info breakpoints: List all breakpoints.

info registers: Display the values of CPU registers

info local: Display local variables of the current function

info watchpoints

info threads

info signals

info sharedlibrary

show directories

clear [function/line]: Clear a breakpoint at a specific location.

watch [expression]: Set a watchpoint to stop execution when the value of an expression changes.

rwatch: rwatch [expression] # Read watch
awatch: awatch [expression] # Access watch (read/write)

disable [watch point number]: Temporarily disable a watchpoint

delete [watch point number]

print[expression]: Print the value of an expression.

bt: Backtrace show the call stack

frame[n]: Switch to a specific frame in the call stack

help [command]

display [expr]: automatically print value of expression expr at each halt in execution

undisplay [display id]

whatis $eax Print type of named variable.

```

### Access to memory

### `x/`

```bash
`x/` is a command used to examine memory, where `x` stands for "examine."
```

```css
x/[count][format][size] [address]
```
- `[count]`: (Optional) The number of memory units to display.
- `[format]` :(Optional) Specifies the format in which to display the memory.
	- `x`: Hexadecimal
	- `d`: Decimal (signed)
	- `u`: Unsigned decimal
	- `o`: Octal
	- `t`: Binary
	- `f`: Floating-point
	- `s`: String
	- `i`: Instructions (disassemble memory as machine code)
- `size`: (Optional) Specifies the size of the memory unit to display.
	- `b`: Byte (1 byte)
	- `h`: Halfword (2 bytes)
	- `w`: Word (4 bytes)
	- `g`: Giant word (8 bytes)

### Layout

```css
layout [name]

- layout src
- layout asm
- layout split
- layout regs
- tui enable
- tui disable
- refresh
- Ctrl + x a => to turn off/on tui
- Ctrl + L => refresh tui
- Ctrl + P / Ctrl + N => Scrol through command history
- set disassembly-flavor intel
- set disassembly-flavor att
```

### print

```lua
print [expression]
print 5 + 10
print *ptr
print struct.member
print struct->member
print arr[2]
print *arr@len
print a+b, c

print/x var display the value in hex
	/d
	/t

print (char *)var
```

### Altering Execution

```lua
set variable [variable_name] = [new_value]
set {int}0x8040010 = 30
set $eax = 20

jump [location] jump and continue execution
	jump main A function
	jump 42 A line
	jump *0x400abc An address

call [function_name]([args])

signal [signal_name]

return [expr]: return from current function at this point, with return value expr
```



## Other

set the default behavior of gdb

```c
# file: ~/.gdbinit

set debuginfod enabled off
set disassembly-flavor intel
```

```c
# file: .gdb_local
# gdb -x ~/.gdb_local

set debuginfod enabled off
set disassembly-flavor intel
layout asm     # Switch to assembly TUI layout

```

#### **External GUI Frontends**

##### 🔹 **GDB Dashboard** (modern CLI add-on)

- Fancy, modular TUI experience.
    
- Colorful, readable CLI dashboard.
    
- Easy to install with `.gdbinit` plugin.
    

🔗 [https://github.com/cyrus-and/gdb-dashboard](https://github.com/cyrus-and/gdb-dashboard)

##### **GDBgui**

- Web-based graphical frontend for GDB.
    
- Start a web server to inspect memory, set breakpoints, and step through code.

```bash
pip install gdbgui
gdbgui ./myprogram
```
🔗 [https://www.gdbgui.com](https://www.gdbgui.com)


### Shortcuts

```css
- Ctrl + x a => to turn off/on tui
- Ctrl + L => refresh the screen
- Ctrl + X followed by o => Toggle between TUI mode (you can use it to switch focus to gdb command line)
- Ctrl + P / Ctrl + N => Scrol through command history
```


### Cheat sheet


![[GDB-cheat-sheet.pdf]]


![[GDB Cheat Sheet.pdf]]