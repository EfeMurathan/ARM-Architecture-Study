ValidIDs:
.word 0x3F, 0x1F, OxF, 0x7, 0x3, 0x1, .. // 93 valid IDs.
Voted:
.word 0,1,1,0,0,0, . // 93 entries.
VoteCount:
.word 0,3,0,1 // There are only 4 candidates


.global _start
_start:
	//KEY GELDIGI ZAMANKI SWITCH KOMBINASYONUNU AL
	//BU SWITCH VALID MI DONGUSUNDE BAK, HANGI OGRENCI
	// HANGI OGRENCIYSE ONUN VOTEDINI 1 YAP
	//HANGI KEYE BASILDIGINA BAK VE ONU BIR ARTTIR
	//KEY CONFIG YAPILDI MI ASSUME EDIYORUM?
	
KEY_ISR:
	PUSH {R0-R12,LR}
	LDR R0,=0xFF200040 //SWITCH
	LDR R1,=0xFF200050 //PUSH BUTTON
	LDR R9,=Voted
	LDR R10,=VoteCount
	
	LDR R2,[R0] //SWITCH ID
	
	LDR R3,=ValidIDs
	MOV R4,#0
	MOV R5,#93
	
find_valid:	
	LDR R6,[R3,R4,LSL #2] //ADDRESS ICIN X4
	CMP R6,R2
	BEQ finded
	
	ADD R4,R4,#1
	CMP R4,R5
	BNE find_valid
	
	B exit_isr
	
finded:
	MOV R3,#1
	STR R3,[R9,R4,LSL #2] //Yine address

count_vote:
	LDR R7,[R1,#12]
	STR R7,[R1,#12] //ACKNOWLEDGE
	TST R7,#0b0001
	MOVNE R8,#0
	TST R7,#0b0010
	MOVNE R8,#1
	TST R7,#0b0100
	MOVNE R8,#2
	TST R7,#0b1000
	MOVNE R8,#3

increase_vote:
	LDR R11,[R10,R8,LSL #2]
	ADD R11,R11,#1
	STR R11,[R10,R8,LSL #2]

exit_isr:	
	POP {R0-R12, PC}
	


	