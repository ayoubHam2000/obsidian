**Endianness** refers to the way a computer system stores and interprets multi-byte data, such as integers or floating-point numbers, in memory

There are two main types of endianness:

1. **Little Endian**: The **least significant byte (LSB)** is stored at the lowest memory address, and the **most significant byte (MSB)** is stored at the highest address.
2. **Big Endian**: The **most significant byte (MSB)** is stored at the lowest memory address, and the **least significant byte (LSB)** is stored at the highest address.

Consider the 32-bit hexadecimal number **`0x12345678`** (which is 4 bytes in size):

Memory Address | Value
---------------|-------
0x00           | 78
0x01           | 56
0x02           | 34
0x03           | 12
In **big endian**, the most significant byte (`12`) is stored at the lowest memory address, and the least significant byte (`78`) is stored at the highest address:

Memory Address | Value
---------------|-------
0x00           | 12
0x01           | 34
0x02           | 56
0x03           | 78
### **Use Cases and Impact on Systems:**

- **Little Endian**:
    - Widely used in **Intel x86/x86_64** architectures.
    - Easier to read and process multi-byte values in sequential order, as you can start with the least significant byte.
- **Big Endian**:
    - Common in older **Motorola** processors and **network protocols** (like TCP/IP), where transmitting the most significant byte first makes sense for serialized data streams.
    - Easier to interpret numbers directly as they are written "left to right" (highest significance first).

### **Endianness and Multi-Byte Access:**

- When accessing multi-byte data in memory, the processor needs to know the **endianness** to correctly interpret the bytes.
- If a program written for a **little-endian** system is run on a **big-endian** system (or vice versa) without considering endianness, the data could be interpreted incorrectly.
- **Big endian** is often referred to as **network byte order** because many network protocols (like TCP/IP) use big endian for transmitting data. When systems communicate over a network, they must agree on the byte order. Therefore, on **little-endian machines**, values are often **converted** to big endian before transmission, and back to little endian when received.

To detect the **endianness** of a system, you can use a simple C program:

```c
#include <stdio.h>

int main() {
    unsigned int x = 1;
    char *c = (char*)&x;

    if (*c) {
        printf("Little Endian\n");
    } else {
        printf("Big Endian\n");
    }

    return 0;
}
```