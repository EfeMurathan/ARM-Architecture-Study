.equ  bit24,0x01000000
.equ bit25,0x02000000

config:
	LDR R0,=0xFF709000
	LDR R1,=bit24
	LDR R2,=bit25
	
	STR R1,[R0,#4] //Output for 24. bit input for 25. bit
	STR R1,[R0] //Yansin basta

toggle:
	EOR R1,R1,#bit24
	STR R1,[R0] //Toggle
	BL wait_for_5
	ANDS R2,R0,#bit25 //data registerin 25. biti 0 mi
	BEQ toggle //0sa tekrar bak

end: b end