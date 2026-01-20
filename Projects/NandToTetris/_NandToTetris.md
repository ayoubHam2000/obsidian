
##  Module 1: Boolean Logic

**Key concepts:** Boolean algebra, Boolean functions, gate logic, elementary logic gates, Hardware Description Language (HDL), hardware simulation.

Any boolean function can be represented using an expression containing AND, OR and Not operations.
Any boolean function can be represented using an expression containing AND and Not operations.
because `Not[Not(x) And Not(y)] = x Or y`
Any boolean function can be represented using an expression containing NAND operations.
because `NAND(x, x) = Not(x)` and `Not[NAND(x, y)] = AND(x, y)`

## Module 2: ALU

### 2s Complement

we can represent negative numbers by this formula $2^n -x$ 

$2^n-x = 1 + (2^n - 1) - x = 1 + neg(x)$
 
$neg(x)$ is the operation when you flip all the bit of $x$

- Positive numbers are stored normally in binary.
- Negative numbers stored as $neg(x) + 1$
- It simplifies hardware circuits: addition, subtraction, and comparison can all use the same circuitry.
- It eliminates the need for a separate negative sign bit.
- You can directly add two 2’s complement numbers.
## Ref

[[Ready set boole]]