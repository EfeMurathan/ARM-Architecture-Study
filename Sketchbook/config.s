config_interrupt:
    push {R1-R7,LR}
    LDR R3,=0xFFFED100
    MOV R1,#73
    MOV R2,#1
    
    //ICDISER KISMINA 1 YAZMA
    AND R4,R1,#0x1F //R4 KALAN
    LSR R5,R1,#5 //R5 BOLUM
    LSL R5,R5,#2 //Address x4

    ADD R3,R3,R5 //ARRAY OF ICDICER
    LSL R2,R2,R4 //SOLA KAYDIRDIM 1i
    
    LDR R6,[R3]
    ORR R6,R6,R2
    STR R6,[R3]

    //ICDPTR KISMINDAN CPU SECICEZ
    LDR R3,=0xFFFED800
    MOV R2,#1

    LSR R5,R1,#2 //R5de bolen
    LSL R5,R5,#2 //Address icin

    AND R4,R1,#0b011 //R4de kalan
    ADD R3,R3,R5 //Bolumu ekle
    ADD R3,R3,R4 //Kalani da ekle 

    STRB R2,[R3] //cpu 1i calistir
    pop {R1-R7,PC}

Config_CIG:
    push {R1-R7,LR}
    //ICCPMRye 0xFFFF ata
    LDR R0,=0xFFFEC100
    MOV R1,#0xFFFF
    STR R1,[R0,#4]
    //ICCICR ve ICDDCRa 1 yazicam

