# EE/CS Department - Computer Architecture & Systems
## Lab 3: Using Logic Instructions with the ARM Processor

### 1. Objectives
The main objectives of this laboratory session are to:
* Understand the implementation and behavior of logic instructions in the ARMv7 processor architecture.
* Master bit-level data manipulation, including bit string analysis, masking, and bit shifting techniques.
* Learn to efficiently handle input/output (I/O) tasks and binary data transformations at the bit level.
* Analyze the execution behavior of bitwise operations (AND, OR, MVN, LSR, LSL) within a simulator environment.

### 2. Theoretical Background
Logic instructions are fundamental in embedded applications for manipulating bit strings and dealing with data at the bit level where only specific bits are of interest. Unlike standard arithmetic operations, logic instructions allow precise control over individual bits, making them essential for hardware interfacing, status register checking, and input/output tasks.

Key operations and concepts utilized in this laboratory include:
1. **Bitwise AND (AND):** Extensively used for bit-masking to isolate specific bits or clear unwanted bits in a register while preserving others.
2. **Logical Shift Right (LSR) & Left (LSL):** Used to move bit positions across a register, which is crucial for isolating bits or performing rapid multiplication/division by powers of two.
3. **Bitwise NOT / Bit Inversion (MVN):** Inverts all bits of the operand. This is highly useful for transforming complementary problems, such as turning a 0-chain detection problem into a 1-chain problem.
4. **Manual Bit Rotation:** A process where bits shifted out from one end of a byte are reinserted into the opposite end. Since ARMv7 lacks a direct single-byte rotation instruction for sub-word fields, manual extraction, shifting, and bitwise reconstruction are required to manipulate lower byte structures.

### 3. Laboratory Tasks
The lab assignment requires implementing and evaluating the following core routines:
* **Task 3.1 - Longest 1-Chain Detection:** Implement an assembly routine utilizing a logical shift right (LSR) and bitwise AND-based algorithm to dynamically determine the length of the longest consecutive string of 1s in a given 32-bit data word.
* **Task 3.2 - Longest 0-Chain Detection:** Design an assembly program to find the length of the longest consecutive string of 0s in a data word. The solution leverages bit inversion (transforming 0s to 1s) and stores the final cumulative result in register R7 without utilizing arithmetic addition.
* **Task 3.3 - Even and Odd Parity Bit Generation:** Write an assembly routine to analyze a binary sequence and compute its parity bits. The program must isolate and place the computed even parity bit into the Least Significant Bit (LSB) of register R8, and the odd parity bit into the Most Significant Bit (MSB) of register R8.
* **Task 3.4 - Manual Byte Decryption via Right Rotation:** Create a custom cryptographic bit-manipulation routine to decrypt a 4-byte word sequence (`0xCEC2D88C`). The algorithm manually extracts, shifts, and recombines the lowest 8 bits of each byte to perform a manual 1-bit right rotation, revealing the hidden ASCII message in memory.

### 4. Lab Deliverables & Requirements
* Correctly structured assembly source code files (`.s` or `.asm`) utilizing clean directives (`.global`, `.text`, `.word`).
* Implementation of bit-bound manipulation loops without relying on forbidden arithmetic addition instructions.
* Well-documented source code files explaining the bit-masking, bit isolation, and shift logic step-by-step.