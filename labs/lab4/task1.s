.global _start

.equ HEX3_HEX0_BASE, 0xFF200020

_start:
    LDR R4, =5621       
	//Bu sayiyi bolup o kadar index artiricam

    MOV R0, R4  //Bolum = R0        
    MOV R1, #10 
    BL DIVIDE           
    MOV R4, R0          
    MOV R0, R1          
    BL hex_gosterim
    MOV R5, R0          

	
    MOV R0, R4
    MOV R1, #10
    BL DIVIDE
    MOV R4, R0
    MOV R0, R1
    BL hex_gosterim
    LSL R0, #8     //Hexlerde gosermek icin shift left     
    ORR R5, R5, R0      

    MOV R0, R4
    MOV R1, #10
    BL DIVIDE
    MOV R4, R0
    MOV R0, R1
    BL hex_gosterim
    LSL R0, #16         
    ORR R5, R5, R0

    MOV R0, R4
    MOV R1, #10
    BL DIVIDE
    MOV R0, R1          
    BL hex_gosterim
    LSL R0, #24         
    ORR R5, R5, R0

    LDR R6, =HEX3_HEX0_BASE
    STR R5, [R6]        

END_LOOP:
    B END_LOOP          

DIVIDE:
    MOV R2, #0          
DIV_LOOP:
    CMP R0, R1          
    BLT DIV_END
    SUB R0, R0, R1      
    ADD R2, R2, #1      
    B DIV_LOOP
DIV_END:
    MOV R1, R0          
    MOV R0, R2          
    BX LR               

hex_gosterim:
    LDR R1, =SEVEN_SEG_TABLE
    LDRB R0, [R1, R0]   
    BX LR               

SEVEN_SEG_TABLE:
    .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67