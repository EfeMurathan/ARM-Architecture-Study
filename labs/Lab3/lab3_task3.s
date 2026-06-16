.text
.global start

start:
    LDR R1, TEST_NUM       MOV R2, R1         

    EOR R2, R2, R2, LSR #16
    EOR R2, R2, R2, LSR #8
    EOR R2, R2, R2, LSR #4
    EOR R2, R2, R2, LSR #2
    EOR R2, R2, R2, LSR #1

    AND R2, R2, #1    

    MOV R8, R2          

    EOR R3, R2, #1      
    LSL R3, R3, #31     
    ORR R8, R8, R3     
END: 
    B END
TEST_NUM: 
    .word 0x10110b01  

.end