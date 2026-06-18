# EE/CS Department - Computer Architecture & Systems
## Lab 4: Input/Output Operations and Parallel Port Interfacing

### 1. Objectives
The main objectives of this laboratory session are to:
* Investigate program-controlled polling approaches for managing Input/Output (I/O) devices.
* Understand the concepts of memory-mapped I/O registers and parallel port hardware interfaces on the Altera DE1-SoC board.
* Design and implement modular subroutines in ARM assembly language for mathematical division and hardware-level data conversion.
* Master the configuration and manipulation of Data, Direction, and Edge-Capture registers to handle asynchronous hardware events (pushbutton presses and switch states).

### 2. Theoretical Background
Input/Output operations bridge the gap between the processor core and peripheral hardware. In this laboratory, the parallel port structures are interacted with via **Program-Controlled Polling**, which continually queries the status of peripheral devices instead of relying on interrupt-driven mechanisms.

Key hardware structures and memory-mapped register subsets used include:
1. **Parallel Port Registers:** Each interface contains distinct registers mapped to specific addresses with defined byte offsets:
   * **Data Register (Offset 0):** Holds the direct input/output bits transferred between the processor and hardware.
   * **Direction Register (Offset 4):** Configures the pin lines as either inputs or outputs (if bidirectional).
   * **Edge-Capture Register (Offset 12 / 0xC):** Automatically asserts a bit when a specific logic transition (edge) is detected on an input line. These bits remain set until explicitly cleared by writing a '1' back to the corresponding position (acknowledgment mechanism).
2. **Subroutine Architecture & Link Register (`LR`):** Implementing complex tasks requires modular code blocks. Subroutines utilize the `BL` (Branch with Link) instruction to automatically save the return address in the Link Register (`LR`), requiring deliberate stack operations (`PUSH`/`POP`) when nesting routines to avoid overwriting return paths.

### 3. Laboratory Tasks
The assignment consists of three progressive tasks combining hardware display techniques and polled control logic:
* **Task 4.1 - Seven-Segment Display and Subroutines:** Develop a modular program to read a 4-digit decimal value (0–9999) from memory, dissect it into individual digits using a custom repeated-subtraction division subroutine (`Division`), translate each digit into a 7-segment representation via a lookup table subroutine (`BIN_TO_7SEG`), and merge them into a single word to drive the `HEX3-0` displays at base address `0xFF200020`.
* **Task 4.2 - Polled KEY Interaction:** Create an interface for the pushbutton keys (`KEY3-0`) at base address `0xFF200050`. The program continuously polls the Edge-Capture register to detect tactile input: `KEY0` initializes the display with '5', `KEY1` increments the value, `KEY2` decrements the value, and `KEY3` clears (blanks) the display, followed immediately by writing to the capture register to acknowledge the event.
* **Task 4.3 - Dynamic Item Price Display System:** Combine the subroutines from Task 4.1 and the polling infrastructure from Task 4.2. The program reads a 4-bit index value from the slide switches (`SW`), maps it to a predefined compilation array (`PRICE_LIST`) upon a valid `KEY0` press, and renders the specific item cost dynamically using a nested four-digit segment display macro (`DISPLAY_4DIGIT`). Any other button press resets and clears the screens.

### 4. Lab Deliverables & Requirements
* Structured ARM assembly implementation utilizing modular subroutines with clear parameter passing conventions (`R0-R2`).
* Robust polling loops preventing execution race conditions or frozen state captures through correct Edge-Capture bit clearing practices.
* Comprehensive data allocation directives (`.word`, `.byte`) defining the lookup segment topologies and application state matrices.