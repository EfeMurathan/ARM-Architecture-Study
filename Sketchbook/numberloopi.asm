/* --- BELLEK ADRESLERİ --- */
.equ  LED_BASE,             0xFF200000
.equ  HEX3_HEX0_BASE,        0xFF200020
.equ  KEY_BASE,              0xFF200050
.equ  MPCORE_GIC_CPUIF,     0xFFFEC100
.equ  MPCORE_GIC_DIST,      0xFFFED000
.equ  ICCIAR,               0x0C
.equ  ICCEOIR,              0x10
/* --- VECTOR TABLE --- */
.section    .vectors, "ax" 
            B       _start                  // Reset
            B       SERVICE_UND             // Undefined
            B       SERVICE_SVC             // Software Interrupt
            B       SERVICE_ABT_INST        // Prefetch Abort
            B       SERVICE_ABT_DATA        // Data Abort
            .word   0                       // Boş
            B       SERVICE_IRQ             // IRQ (Bizimki bu!)
            B       SERVICE_FIQ             // FIQ

.text        
.global     _start 
_start:                                     
            MOV     R1, #0b11010010         // IRQ Modu
            MSR     CPSR_c, R1              
            LDR     SP, =0x3FFFFFFC         // DDR3'ün sonu, 4'ün tam katı!
            
            MOV     R1, #0b11010011         // SVC  Modu
            MSR     CPSR_c, R1                
            LDR     SP, =0x3FFFFFF0         

            BL      CONFIG_GIC              

            // Buton Interrupt Mask 
            LDR     R0, =KEY_BASE           
            MOV     R1, #0xF               
            STR     R1, [R0, #0x8]          

            /* İşlemci Interrupt Şalterini Aç */
            MOV     R0, #0b01010011         
            MSR     CPSR_c, R0              

IDLE:       B       IDLE                   


SERVICE_IRQ:                                
            PUSH    {R0-R7, LR}             
            LDR     R4, =MPCORE_GIC_CPUIF   
            LDR     R5, [R4, #ICCIAR]       

            CMP     R5, #73                
            BEQ     CALL_KEY_ISR
UNEXPECTED: BNE     UNEXPECTED              

CALL_KEY_ISR:
            BL      KEY_ISR                 
            STR     R5, [R4, #ICCEOIR]     
            POP     {R0-R7, LR}             
            SUBS    PC, LR, #4              

/* --- KEY_ISR (TASK II: SAYICI) --- */
KEY_ISR:
	PUSH {R0-R6,LR}
	LDR R0,=KEY_BASE
	MOV R1,#0xF
	//STR R1,[R0,#8] Enable mask yapilmis zaten basta
	LDR R2,[R0,#12] //Burda basilan ledin bitini bulcam
	
	STR R1,[R0,#12] //Acknowledge
	//Burdan sonra asil olay olucak, memoryde count degerini aliyorum 1 arttiriyorum eger 10 ise
	//0a ceviriyorum ondan sonra array tablosunda o kadar bit gidiyorum. Sonra 7 segment
	LDR	R2,=COUNT
	LDR R3,[R2] //Hangi sayi vardi
	ADD R3,R3,#1 //Bir arttir
	CMP R3,#10
	MOVEQ R3,#0
	STR R3,[R2]
	
	//Arrayde donme
	LDR R4,=SEG_TABLE
	LDRB R5,[R4,R3]
	
	//7 segment display
	LDR R6,=HEX3_HEX0_BASE
	STR R5,[R6]
	POP {R0-R6,PC}
	
			
			
/* --- GIC CONFIGURATION (Basitleştirilmiş) --- */
CONFIG_GIC:
            PUSH    {LR}
            // ID 73'ü (Keys) CPU0'a yönlendir
            LDR     R0, =0xFFFED848         // ICDIPTR18 adresi
            MOV     R1, #1
            STRB    R1, [R0, #1]            // ID 73 için 2. byte'ı set et
            
            // ID 73'ü Aktif Et
            LDR     R0, =0xFFFED108         // ICDISER2 adresi
            MOV     R1, #0x200              // 9. bit (73-64 = 9)
            STR     R1, [R0]
            
            // Interface ve Distributor'ı aç
            LDR     R0, =0xFFFEC100         // CPUIF
            MOV     R1, #1
            STR     R1, [R0]                // ICCICR
            LDR     R1, =0xFFFF
            STR     R1, [R0, #0x4]          // ICCPMR
            
            LDR     R0, =0xFFFED000         // Distributor
            MOV     R1, #1
            STR     R1, [R0]                // ICDDCR
            POP     {PC}

/* --- DİĞER EXCEPTION'LAR (Boş) --- */
SERVICE_UND: B SERVICE_UND
SERVICE_SVC: B SERVICE_SVC
SERVICE_ABT_DATA: B SERVICE_ABT_DATA
SERVICE_ABT_INST: B SERVICE_ABT_INST
SERVICE_FIQ: B SERVICE_FIQ

.data
.align
COUNT:      .word   0
SEG_TABLE:  .byte   0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.end