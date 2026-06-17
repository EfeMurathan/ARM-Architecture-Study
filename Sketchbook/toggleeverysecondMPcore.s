//Her saniyede toggle yapan led MPCore ile
.data
.equ bit24,0x01000000

.text
config:
	LDR R0,=0xFFFEC600 //Timer address
	LDR R1,=0xFF709000 //GPIO address
	LDR R2,=bit24
	STR R2,[R1,#4] //Setup Output for led
	STR R2,[R1] //Turn on the led 

	//Now config the timer
	LDR R3,=200000000
	STR R3,[R0]
	MOV R3,#0b011
	STR R3,[R0,#8]

loop:
    BL wait_for_1sec
	EOR R2,R2,#bit24 //toggle icin hazirlik
	STR R2,[R1] //toggle
	B loop

wait_for_1sec:
	LDR R3,[R0,#12]
	ANDS R3,R3,#0b01
	BEQ wait_for_1sec

    MOV R3,#1
    STR R3,[R0,#12] //Acknowledge
	BX LR	
	
	 