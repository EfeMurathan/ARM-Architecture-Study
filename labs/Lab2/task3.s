.include    "address_map_arm.s"
                       
.global     _start          
_start: 
LDR R0, =LOC // pseudo-inst.
LDRB R1, [R0]
LDRB R2, [R0, #1]
STRB R2, [R0]
STRB R1, [R0, #1]
END: B END
LOC: .word 0x12AB
.end