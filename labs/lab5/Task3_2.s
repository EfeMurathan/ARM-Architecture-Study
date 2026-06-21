.include    "address_map_arm.s"
.equ        SEG_MID,          0x40
.equ        DELAY,            20000000

.text
.global     _start

_start:
        LDR     R0, =HEX3_HEX0_BASE
        LDR     R1, =MPCORE_PRIV_TIMER
        LDR     R7, =HEX5_HEX4_BASE

        LDR     R2, =DELAY
        STR     R2, [R1]
        MOV     R2, #0b011
        STR     R2, [R1, #0x8]

        MOV     R4, #SEG_MID

// LEFT
MOVE_LEFT:
        MOV     R5, #0
        MOV     R2, #0
        STR     R2, [R7]                // Clear Hex45

LEFT_HEX30:
        MOV     R2, R4, LSL R5          // Start with Hex0
        STR     R2, [R0]
        BL      TIMER_WAIT
        ADD     R5, R5, #8
        CMP     R5, #32
        BLT     LEFT_HEX30              // HEX3e gelince Hex4e devam edicez

        MOV     R2, #0
        STR     R2, [R0]                // Clear Hex3_0
        MOV     R5, #0

LEFT_HEX54:
        MOV     R2, R4, LSL R5          // Start with HEX4
        STR     R2, [R7]
        BL      TIMER_WAIT
        ADD     R5, R5, #8
        CMP     R5, #16
        BLT     LEFT_HEX54              // HEX5ten sonra saga gidicez

// Right left ile ayni mantik
MOVE_RIGHT:
        MOV     R5, #8
        MOV     R2, #0
        STR     R2, [R0]               

RIGHT_HEX54:
        MOV     R2, R4, LSL R5          
        STR     R2, [R7]
        BL      TIMER_WAIT
        SUBS    R5, R5, #8
        BGE     RIGHT_HEX54             

        MOV     R2, #0
        STR     R2, [R7]                
        MOV     R5, #24

RIGHT_HEX30:
        MOV     R2, R4, LSL R5          
        STR     R2, [R0]
        BL      TIMER_WAIT
        SUBS    R5, R5, #8
        BGE     RIGHT_HEX30             

        B       MOVE_LEFT


TIMER_WAIT:
        LDR     R3, [R1, #0xC]          // Interrupt Status 
        CMP     R3, #0                  
        BEQ     TIMER_WAIT              // Polling
        STR     R3, [R1, #0xC]          // Acknowledge
        BX      LR                      

.end