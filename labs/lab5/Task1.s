.include    "address_map_arm.s"     
.equ        bit_24_pattern, 0x01000000
.text                               
.global     _start                  
_start:                                 
        LDR     R0, =HPS_GPIO1_BASE     // GPIO1 base address
        LDR     R1, =MPCORE_PRIV_TIMER  // MPCore private timer base address

        LDR     R2, =bit_24_pattern     
        STR     R2, [R0, #0x4]          
                                        
        LDR     R3, =200000000          // timeout = 1/(200 MHz) x 200x10^6 = 1 sec
        STR     R3, [R1]              
        MOV     R3, #0b011              // set bits: mode = 1 (auto), enable = 1
        STR     R3, [R1, #0x8]          
LOOP:                                   
        STR     R2, [R0]                // turn on/off LEDG
WAIT:                                   
        LDR     R3, [R1, #0xC]          // read timer status
        CMP     R3, #0                  
        BEQ     WAIT                    // wait for timer to expire

        STR     R3, [R1, #0xC]          // Acknowledge
        EOR     R2, R2, #bit_24_pattern // Toggle (Bitwise or) 
        B       LOOP                    

.end                                