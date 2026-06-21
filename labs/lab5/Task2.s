.include    "address_map_arm.s"
.equ        bit_24_pattern, 0x01000000

.text
.global     _start

_start:
        LDR     R0, =HPS_GPIO1_BASE         //GPIO1 base address
        LDR     R1, =KEY_BASE               //KEY base address (0xFF200050)

        LDR     R2, =bit_24_pattern
        STR     R2, [R0, #0x4]              

        MOV     R2, #0                      //LEDG off 
        STR     R2, [R0]                    //write to data register

KEYEE:
        LDR     R3, [R1, #0xC]              //Edgecapture
        CMP     R3, #0
        BEQ     KEYEE                       //polling

        STR     R3, [R1, #0xC]              //acknowledge

        EOR     R2, R2, #bit_24_pattern     // toggle
        STR     R2, [R0]                    

        B       KEYEE

.end
