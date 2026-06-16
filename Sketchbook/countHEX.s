.data
num_array: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.equ HEX_BASE, 0xff200020

.text
.global _start
_start:
	LDR R0,=HEX_BASE //seven segment addresim
	LDR R1,=num_array //Array baslangic addresim
	MOV R5,#0 //Onlar sayaci
	MOV R3,#0 //Birler sayaci
	
loop:
	LDR R6,[R1,R5,LSL #2]
	LSL R6,#8
	
	LDR R2,[R1,R3,LSL #2]
	ORR R2,R2,R6
	
	STR R2,[R0]
	
	ADD R3,R3,#1
	CMP R3,#10
	BNE loop
	
	MOV R3,#0
	ADD R5,R5,#1
	
	CMP r5,#10
	MOVEQ R5,#0
	
	B loop
	
	
	
	
	
	
	