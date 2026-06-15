.include    "address_map_arm.s"
                       
.global     _start          
_start: 
// Use register addressing or pre-indexed addressing modes
LDR R0, =LOCA // pseudo-inst.
LDR R1, [R0]
LDR R2, [R0, #4]
STR R2, [R0]
STR R1, [R0, #4]
// Use register addressing or post-indexed addressing modes
LDR R0, =LOCA // pseudo-inst.
LDR R1, [R0]
LDR R2, [R0], #4
STR R2, [R0,#-4]!
STR R1, [R0,#4]!
// Use register addressing or pre-indexed with write-back addressing modes
LDR R0, =LOCA
LDR R1, [R0] 
LDR R2, [R0]   
STR R2, [R0, #-4]! 
STR R1, [R0]  
END: B END
LOCA: .word 0xA
LOCB: .word 0xB     
.end    