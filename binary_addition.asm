.ORIG x3000 
;1ST LINE 
AND R6, R6, #0 
AND R5, R5, #0 
AND R4, R4, #0 

ADD R6, R6, #15 ;counter for reading 16 bits in 1 line 
ADD R6, R6, #1 
ADD R4, R4, #1 ;POWER

TRAP 0x31 ;get player location
ADD R2, R2, #1 ;ADD 1 TO Z AXIS  

READ1 ;TOTAL STORED IN R5
    ADD R0, R0, #1 ;add 1 to x axis 
    TRAP 0x33 ;get block 
    ADD R3, R3, #0 
    BRz SKIPTOTAL1
    ADD R5, R5, R4
    SKIPTOTAL1
    ADD R4, R4, R4 
    ADD R6, R6, #-1 ;minus 1 from 16 counter 
BRp READ1 
;2ND LINE 
AND R6, R6, #0
AND R4, R4, #0 

ADD R6, R6, #15 ;counter for reading 16 bits in 1 line 
ADD R6, R6, #1 
ADD R4, R4, #1 ;POWER

TRAP 0x31 ;get player location
ADD R2, R2, #2 ;ADD 2 TO Z AXIS

READ2 ;TOTAL STORED IN R5
    ADD R0, R0, #1 ;add 1 to x axis 
    TRAP 0x33 ;get block 
    ADD R3, R3, #0 
    BRz SKIPTOTAL2
    ADD R5, R5, R4
    SKIPTOTAL2
    ADD R4, R4, R4 
    ADD R6, R6, #-1 ;minus 1 from 16 counter 
BRp READ2 

STI R5, TOTAL

;MINECRAFT
AND R5, R5, #0 
AND R4, R4, #0
TRAP 0x31 ;GET COORDS 
ADD R4, R4, #15 ;16 COUNTER 
ADD R4, R4, #1
ADD R5, R5, #1 ;STARTING POWER 
ADD R2, R2, #3 ;ADD 3 TO Z 

WRITE 
    LDI R6, TOTAL
    ADD R0, R0, #1 ;ADD 1 TO X 
    AND R6, R6, R5 ;CHECK THE BIT  
    BRnp POSITIVE ;IF 1 PRINT BLOCK IF 0 PRINT AIR 
    LD R3, BLOCK_ID_1
    TRAP 0x34
    BR SKIPPOS

    POSITIVE
    LD R3, BLOCK_ID_2
    TRAP 0x34
    SKIPPOS

    ADD R5, R5, R5 ;TIMES BY 2 TO GET NEXT BIT  
    ADD R4, R4, #-1 ;LOOP 16 TIMES 
BRp WRITE 

HALT 

TOTAL .FILL x3102 ;TOTAL OF BINARY TO INT 

BLOCK_ID_1 .FILL #0 ;AIR 
BLOCK_ID_2 .FILL #1 ;COBBLESTONE 

.END 