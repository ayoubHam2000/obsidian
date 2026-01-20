In the **x86/x86-64** architecture, **Vector Registers** are specialized registers used to perform **SIMD** (Single Instruction, Multiple Data) operations. These registers allow a CPU to process multiple data elements (such as integers or floating-point numbers) in parallel within a single instruction, significantly improving performance for tasks like multimedia processing, scientific computations, encryption, and more.

Here’s a summary of the main vector register sizes and their corresponding SIMD extensions:

| **Vector Register**  | **Width** | **Instruction Set** | **Purpose**                       |
| -------------------- | --------- | ------------------- | --------------------------------- |
| **MMX (MM0-MM7)**    | 64 bits   | **MMX**             | Integer SIMD                      |
| **XMM (XMM0-XMM15)** | 128 bits  | **SSE/SSE2/SSE3**   | Floating-point and integer SIMD   |
| **YMM (YMM0-YMM15)** | 256 bits  | **AVX/AVX2**        | Wider SIMD for better parallelism |
| **ZMM (ZMM0-ZMM31)** | 512 bits  | **AVX-512**         | High-performance SIMD operations  |

Each element in the vector register is processed independently by the same instruction. For example, an addition operation (`ADDPS`) on two XMM registers containing 4 floats will add the corresponding float values in parallel.

### Instructions

1. **Floating-Point Arithmetic Instructions**

**`VADDPS`**: Add packed single-precision floating-point values.
```
vaddps ymm1, ymm2, ymm3   ; ymm1 = ymm2 + ymm3 (packed single-precision floats)
```
**`VADDPD`**: Add packed double-precision floating-point values.
```
vaddpd ymm1, ymm2, ymm3   ; ymm1 = ymm2 + ymm3 (packed double-precision floats)
```
**`VSUBPS`**: Subtract packed single-precision floating-point values.
```
vsubps ymm1, ymm2, ymm3   ; ymm1 = ymm2 - ymm3
```
**`VMULPS`**: Multiply packed single-precision floating-point values.
```
vmulps ymm1, ymm2, ymm3   ; ymm1 = ymm2 * ymm3
```
**`VDIVPS`**: Divide packed single-precision floating-point values.
```
vdivps ymm1, ymm2, ymm3 ; ymm1 = ymm2 / ymm3
```
**`VSQRTPS`**: Compute square root of packed single-precision floating-point values.
```
vsqrtps ymm1, ymm2 ; ymm1 = sqrt(ymm2)
```

2. **Integer Arithmetic Instructions (AVX2)**

**`VPADDD`**: Add packed 32-bit integers.
```
vpaddd ymm1, ymm2, ymm3 ; ymm1 = ymm2 + ymm3 (packed 32-bit integers)
```
**`VPADDQ`**: Add packed 64-bit integers.
```
vpaddq ymm1, ymm2, ymm3 ; ymm1 = ymm2 + ymm3 (packed 64-bit integers)
```
**`VPMULUDQ`**: Multiply packed unsigned 32-bit integers, producing 64-bit results.
```
vpmuludq ymm1, ymm2, ymm3   ; ymm1 = ymm2 * ymm3 (unsigned 32-bit multiply)
```
**`VPAND`**: Bitwise AND for packed integers.
```
vpand ymm1, ymm2, ymm3 ; ymm1 = ymm2 & ymm3
```
**`VPSLLD`**: Shift packed 32-bit integers left by an immediate value.
```
vpslld ymm1, ymm2, imm8 ; ymm1 = ymm2 << imm8 (logical shift left)
```

3. **Data Movement Instructions**

**`VMOVAPS`**: Move aligned packed single-precision floating-point values.
**`VMOVDQA`**: Move aligned packed integers (AVX2).
**`VMOVUPS`**: Move unaligned packed single-precision floating-point values.
4. **Logical Operations**
**`VPAND`**: Bitwise AND.
**`VPOR`**: Bitwise OR.
**`VPXOR`**: Bitwise XOR.
**`VPCMPEQD`**: Compare packed 32-bit integers for equality.

6. **Blending and Masking Instructions**
These instructions combine data from two registers based on a mask, allowing for conditional operations within SIMD.
**`VBLENDPS`**: Blend packed single-precision floating-point values using an immediate mask.
**`VPBLENDD`**: Blend packed 32-bit integers using an immediate mask.
**`VMASKMOVPS`**: Conditional store of packed single-precision floating-point values based on a mask.

8. Permutation and Shuffling Instructions
These instructions rearrange data elements within registers.
**`VPERM2F128`**: Permute floating-point values in two 128-bit lanes.
**`VSHUFPS`**: Shuffle packed single-precision floating-point values.
**`VPUNPCKLQDQ`**: Unpack and interleave lower double-precision or quadword integers.

10. Comparison Instructions
**`VCMPPS`**: Compare packed single-precision floating-point values.
**`VPCMPGTQ`**: Compare packed 64-bit integers for greater than.

12. Fused Multiply-Add (FMA) Instructions
**`VFMADD132PS`**: Fused multiply and add of packed single-precision floating-point values.
**`VFMADD213PS`**: Another variant of fused multiply-add for packed floats.
13. Miscellaneous Instructions
**`VCVTDQ2PS`**: Convert packed 32-bit integers to packed single-precision floating-point values.

### **1. Instruction Suffixes**

Suffixes are added to the instruction mnemonics to specify certain details such as data types, element sizes, and vector operations.

#### **Suffixes for Data Types**

- **`PS`**: Single-Precision Floating-Point (32-bit).
    - **Example**: `VADDPS` (Add packed single-precision floating-point values).
- **`PD`**: Double-Precision Floating-Point (64-bit).
    - **Example**: `VADDPD` (Add packed double-precision floating-point values).
- **`SD`**: Scalar Double-Precision Floating-Point (64-bit) – operates on a single value.
    - **Example**: `VSQRTSD` (Square root of a scalar double-precision value).
- **`SS`**: Scalar Single-Precision Floating-Point (32-bit) – operates on a single value.
    - **Example**: `VMULSS` (Multiply scalar single-precision value).
- **`DQ`**: Quadword (64-bit integer).
    - **Example**: `VPADDQ` (Add packed 64-bit integers).
- **`PS` / `PD`** (depending on integer size) in AVX-512 for support in mixed types.
#### **Common Arithmetic Suffixes**

- **`ADD`**: Addition.
    - **Example**: `VADDPS` (Add packed single-precision floats).
- **`SUB`**: Subtraction.
    - **Example**: `VSUBPS` (Subtract packed single-precision floats).
- **`MUL`**: Multiplication.
    - **Example**: `VMULPS` (Multiply packed single-precision floats).
- **`DIV`**: Division.
    - **Example**: `VDIVPS` (Divide packed single-precision floats).
- **`SQRT`**: Square root.
    - **Example**: `VSQRTPS` (Square root of packed single-precision floats).

#### **Comparison Suffixes**

- **`CMP`**: Compare.
    - **Example**: `VCMPEQPS` (Compare packed single-precision floating-point values for equality).
#### **Summary of Common AVX Instruction Suffixes and Prefixes**

|**Suffix**|**Description**|**Example**|
|---|---|---|
|`PS`|Single-precision float (32-bit)|`VADDPS`, `VMULPS`|
|`PD`|Double-precision float (64-bit)|`VADDPD`, `VSQRTPD`|
|`SD`|Scalar double-precision float (64-bit)|`VSQRTSD`, `VFMADD132SD`|
|`SS`|Scalar single-precision float (32-bit)|`VMULSS`, `VADDSS`|
|`DQ`|Quadword (64-bit integer)|`VPADDQ`, `VPMULUDQ`|
|`L`|Doubleword (32-bit)|`VPMULLD`, `VPADDD`|
|`Q`|Quadword (64-bit)|`VPADDQ`, `VPMULQ`|
|`B`|Byte (8-bit)|`VPSLLB`|
|`W`|Word (16-bit)|`VPSLLW`|
|`YMM`, `ZMM`|AVX register sizes (256-bit for YMM, 512-bit for ZMM)|`VADDPS YMM1, YMM2, YMM3`, `VADDPS ZMM1, ZMM2, ZMM3`|

### **Instruction Examples**
- **SSE** example:
```c
movaps xmm1, [src1]   ; Load 128 bits (four 32-bit floats) into xmm1
movaps xmm2, [src2]   ; Load another 128 bits into xmm2
addps  xmm1, xmm2     ; Add the packed floats in xmm1 and xmm2
movaps [dest], xmm1   ; Store the result
```
-**AVX** example:
```c
vmovaps ymm1, [src1]  ; Load 256 bits (eight 32-bit floats) into ymm1
vmovaps ymm2, [src2]  ; Load another 256 bits into ymm2
vaddps  ymm1, ymm1, ymm2  ; Add the packed floats in ymm1 and ymm2
vmovaps [dest], ymm1  ; Store the result
```

**AVX Instruction for 64-bit floating-point addition**: `VADDPD` (Add Packed Double-Precision Floating-Point)

```c
vmovapd ymm1, [src1]  ; Load four 64-bit double-precision floats from memory into ymm1
vmovapd ymm2, [src2]  ; Load another four 64-bit floats from memory into ymm2
vaddpd  ymm1, ymm1, ymm2 ; Add the packed 64-bit floats in ymm1 and ymm2
vmovapd [dest], ymm1  ; Store the result back into memory
```

```c
vmovapd zmm1, [src1]   ; Load eight 64-bit double-precision floats into zmm1
vmovapd zmm2, [src2]   ; Load another eight 64-bit floats into zmm2
vaddpd  zmm1, zmm1, zmm2 ; Add the packed 64-bit floats in zmm1 and zmm2
vmovapd [dest], zmm1   ; Store the result back into memory
```

**AVX2 Instruction for 64-bit integer addition**: `VPADDQ` (Add Packed Quadword Integers)

```c
vmovdqa ymm1, [src1]   ; Load four 64-bit integers from memory into ymm1
vmovdqa ymm2, [src2]   ; Load another four 64-bit integers from memory into ymm2
vpaddq  ymm1, ymm1, ymm2 ; Add the packed 64-bit integers in ymm1 and ymm2
vmovdqa [dest], ymm1   ; Store the result back into memory
```
