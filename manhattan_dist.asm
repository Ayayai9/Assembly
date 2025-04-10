.ORIG x3000
;store player pos in posx posy posz 
TRAP 0x31 
STI R0, posx 
STI R1, posy 
STI R2, posz

;load values
LD R1, G_X 
LDI R2, posx 

;|(playerPos.x - G_X)| STORE IN R3 
NOT R1, R1 
ADD R1, R1, #1 
ADD R2, R2, R1 
BRp POS
NOT R2, R2 
ADD R2, R2, #1 
POS 

AND R3, R3, #0 
ADD R3, R3, R2

;load values
LD R1, G_Y
LDI R2, posy 

;(playerPos.y - G_Y)| STORE IN R4
NOT R1, R1 
ADD R1, R1, #1 
ADD R2, R2, R1 
BRp POS1 
NOT R2, R2 
ADD R2, R2, #1 
POS1

AND R4, R4, #0 
ADD R4, R4, R2

;LOAD values
LD R1, G_Z
LDI R2, posz 

;|(playerPos.z - G_Z)| STORE IN R5
NOT R1, R1 
ADD R1, R1, #1 
ADD R2, R2, R1 
BRp POS2
NOT R2, R2 
ADD R2, R2, #1 
POS2 

AND R5, R5, #0 
ADD R5, R5, R2

;dmanhattan = |(playerPos.x - G_X)| + |(playerPos.y - G_Y)|+ |(playerPos.z - G_Z)| STORED IN R6
AND R6, R6, #0 
ADD R6, R6, R3
ADD R6, R6, R4
ADD R6, R6, R5

;CHECK IF WITHIN BOUNDS 
LD R1, GOAL_DIST 
NOT R6, R6 
ADD R6, R6, #1 
ADD R6, R1, R6 
BRzp INBOUNDS

LEA R0, OUTSIDE 
TRAP 0x30 
BR END 

INBOUNDS 
LEA R0, WITHIN 
TRAP 0x30 

END

HALT

; Note: Please do not change the names of the constants below
posx .FILL x3100
posy .FILL x3101 
posz .FILL x3102 

G_X .FILL #10
G_Y .FILL #10
G_Z .FILL #10
GOAL_DIST .FILL #10

OUTSIDE .STRINGZ "The player is outside the goal bounds"
WITHIN .STRINGZ "The player is within Manhattan distance of the goal"

.END