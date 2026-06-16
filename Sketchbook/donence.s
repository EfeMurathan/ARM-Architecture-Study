.data
.equ HEX_BASE, 0xFF200020
num_array: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F

.text
.global _start
_start:
	LDR R0,=HEX_BASE 
	LDR R1, =num_array
	MOV R3,#0 //Array basla
	MOV R4,#10 //Array son
	MOV R5,#1
	
loop:
	LDR R2,[R1,R3,LSL #2]
	STR R2,[R0]
	ADD R3,R3,#1
	CMP R3,R4
	BNE loop
	
decimal:
	MOV R3,#0
	STR R3,[R0]
	

	
	STR R1,[R0]

	
	