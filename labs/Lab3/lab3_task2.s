.text
.global start

start:
    LDR R1, TEST_NUM   
    MVN R1, R1        
    
    MOV R7, #0         

LOOP:
    CMP R1, #0          
    BEQ END            
    
    LSR R2, R1, #1   
    AND R1, R1, R2        
    ADD R7, R7, #1      
    B LOOP

END: 
    B END

TEST_NUM: 
    .word 0x10110b01   
.end