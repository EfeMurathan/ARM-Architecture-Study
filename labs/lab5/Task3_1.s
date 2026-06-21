.include    "address_map.s"
.equ        SEG_MID,          0x40
.equ        DELAY,            20000000

.text
.global     _start

_start:
        LDR     R0, =HEX3_HEX0_BASE
        LDR     R1, =MPCORE_PRIV_TIMER

        LDR     R2, =DELAY
        STR     R2, [R1]
        MOV     R2, #0b011
        STR     R2, [R1, #0x8]

        MOV     R4, #SEG_MID
        MOV     R5, #0

// Left
MOVE_LEFT:
        MOV     R2, R4, LSL R5
        STR     R2, [R0]
WAIT_LEFT:
        LDR     R3, [R1, #0xC]
        CMP     R3, #0
        BEQ     WAIT_LEFT
        STR     R3, [R1, #0xC]
        ADD     R5, R5, #8
        CMP     R5, #24         //Are we at the end?
        BLE     MOVE_LEFT

// Right
MOVE_RIGHT:
        MOV     R2, R4, LSL R5
        STR     R2, [R0]
WAIT_RIGHT:
        LDR     R3, [R1, #0xC]
        CMP     R3, #0
        BEQ     WAIT_RIGHT
        STR     R3, [R1, #0xC]
        SUB     R5, R5, #8
        CMP     R5, #0
        BGE     MOVE_RIGHT

        B       MOVE_LEFT

.end