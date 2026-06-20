.global _start
_start:
	LDR R0,=0xFF200020
	LDR R2,=0xFFFEC600
	
config_timer:
	LDR R3,=200000000
	STR R3,[R2]
	
	MOV R3,#0b011
	STR R3,[R2,#8]
	
	MOV R4,#0

sol:
	MOV R1,#0b1000000
	
sola_kaydir:
	STR R1,[R0]
	BL delay
	CMP R1,#0x40000000
	BEQ sag	
	LSL R1,R1,#8
	
	B sola_kaydir

sag:
	MOV R1,#0b1000000
	LSL R1,R1,#16
		
sag_loop:
	STR R1,[R0]
	BL delay
	LSR R1,R1,#8
	CMP R1,#0b1000000
	BEQ sol
	b sag_loop

delay:
	LDR R3,[R2,#12]
	ANDS R3,#1
	BEQ delay
	MOV R3,#1
	STR R3,[R2,#12]
	BX LR
	
	