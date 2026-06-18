.global _start

.equ KEYS_BASE, 0xFF200050
.equ SW_BASE, 0xFF200040
.equ HEX3_HEX0_BASE, 0xFF200020

_start:
    LDR R10, =KEYS_BASE
    LDR R11, =HEX3_HEX0_BASE
    LDR R12, =SW_BASE

MAIN_LOOP:
    LDR R1, [R10, #0xC]      //Edgecapture
    CMP R1, #0
    BEQ MAIN_LOOP           //Polling until a key is pressed

    STR R1, [R10, #0xC]      //Acknowledge

    TST R1, #1               
    BNE SHOW_PRICE

    MOV R0, #0              
    STR R0, [R11]
    B MAIN_LOOP

SHOW_PRICE:
    LDR R2, [R12]            
    AND R2, R2, #0xF         //F ile ilk 4 biti aliyorum

    LDR R3, =PRICE_LIST
    LDR R0, [R3, R2, LSL #2] // ADDRESS ICIN X4

    BL DISPLAY_4DIGIT        

    B MAIN_LOOP

DISPLAY_4DIGIT:
    PUSH {R0-R7, LR}   //Subroutine girerken push pop yap      

    MOV R4, R0          
    
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
    LSL R0, #8     //Lsl lazim hex yeri icin     
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

    STR R5, [R11]            // Yine ekran adresi bas

    POP {R0-R7, PC}          

//Buralar bi onceki taskden alinmisti
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
    LDR R2, =SEVEN_SEG_TABLE
    LDRB R0, [R2, R0]       
    BX LR

.data
PRICE_LIST:
    .word 120, 250, 375, 999
    .word 430, 85,  760, 1500
    .word 60,  45,  888, 321
    .word 1550, 700, 42, 510

SEVEN_SEG_TABLE:
    .byte 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x67