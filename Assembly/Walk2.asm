TITLE Drunkard's Walk 					(Walk2.asm)


; Program:     Drunkard's walk program
; Description: The drunkard starts at coordinates 39,10 and wanders 
;			   around the immediate area.
; Student:     Matt Dohlen	
; Date:        04/15/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding



INCLUDE Irvine32.inc
WalkMax = 50
StartX = 39
StartY = 10

DrunkardWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed WORD 0
DrunkardWalk ENDS



.data
aWalk DrunkardWalk <>
prompt BYTE "How many steps should the Drunkard move: ",0
invalid BYTE "Number of steps invalid, range is 0 to 50.",0dh,0ah,0
.code
Walk2 PROC
L1:	
	mov edx,OFFSET prompt
	call WriteString
	call ReadDec
	jc L2
	cmp eax,1
	jb L2
	cmp eax,WalkMax
	ja L2
	jmp L3
L2:
	mov edx,OFFSET invalid
	call WriteString
	jmp L1
L3:
	mov aWalk.pathsUsed, ax
	mov	esi,OFFSET aWalk
	call	TakeDrunkenWalk2
	call WaitMsg
	call ShowPath
	exit
Walk2 ENDP

;-------------------------------------------------------
TakeDrunkenWalk2 PROC
LOCAL currX:WORD, currY:WORD
;
; Take a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
; Returns:  the structure is initialized with random values
;-------------------------------------------------------
	pushad

; Use the OFFSET operator to obtain the address of
; path, the array of COORD objects, and copy it to EDI.
	mov	edi,esi
	add	edi,OFFSET DrunkardWalk.path
	movzx	ecx,aWalk.pathsUsed		; loop counter
	mov	currX,StartX		; current X-location
	mov	currY,StartY		; current Y-location

Again:
	; Insert current location in array.
	mov	ax,currX
	mov	(COORD PTR [edi]).X,ax
	mov	ax,currY
	mov	(COORD PTR [edi]).Y,ax

	mov bx,currX
	mov dx,currY
	call DisplayPosition2

	call NextChar
	.IF eax == 0		; North
	  dec currY
	.ELSEIF eax == 1	; South
	  inc currY
	.ELSEIF eax == 2	; West
	  dec currX
	.ELSE			; East (EAX = 3)
	  inc currX
	.ENDIF

	mov bx,currX
	mov dx,currY
	call CompInit
	jnz good
	.IF eax == 0		; North
	  inc currY
	.ELSEIF eax == 1	; South
	  dec currY
	.ELSEIF eax == 2	; West
	  inc currX
	.ELSE			; East (EAX = 3)
	  dec currX
	.ENDIF
	jmp Again
good:
	add	edi,TYPE COORD		; point to next COORD
	loop	Again

Finish:
	call crlf
	mov (DrunkardWalk PTR [esi]).pathsUsed, WalkMax
	popad
	ret
TakeDrunkenWalk2 ENDP

;-------------------------------------------------------
DisplayPosition2 PROC
; Display the current X and Y positions.
;-------------------------------------------------------
.data
commaStr	BYTE ",",0
startPara	BYTE "(",0
endPara		BYTE ") ",0

.code
	pushad
	movzx eax,bx
	mov bx,dx
	mov	edx,OFFSET startPara
	call WriteString
	call	 WriteDec
	mov	 edx,OFFSET commaStr	; "," string
	call	 WriteString
	movzx eax,bx			; current Y position
	call	 WriteDec
	mov edx,OFFSET endPara
	call WriteString
	popad
	ret
DisplayPosition2 ENDP

;--------------------------------------------------------
ShowPath PROC
; Show the path that the drunkard took on his walk
;--------------------------------------------------------
.data
oh	BYTE "O",0
ast	BYTE "*",0

.code
	mov	edi,esi
	add	edi,OFFSET DrunkardWalk.path
	movzx	ecx,aWalk.pathsUsed
	dec ecx
	mov	dx,(COORD PTR [edi]).Y
	shl dx,8
	mov ax,(COORD PTR [edi]).X
	or dx,ax
	call Gotoxy
	mov eax,gray + (white * 16)
	call SetTextColor
	mov eax,'O'
	call WriteChar
	mov eax,500
	call delay
	call Gotoxy
	mov eax,lightGray + (black * 16)
	call SetTextColor
	mov eax,'O'
	call WriteChar
	add edi,TYPE COORD
	
go:
	mov	dx,(COORD PTR [edi]).Y
	shl dx,8
	mov ax,(COORD PTR [edi]).X
	or dx,ax
	call Gotoxy
	mov eax,gray + (white * 16)
	call SetTextColor
	mov eax,'*'
	call WriteChar
	mov eax,500
	call delay
	call Gotoxy
	mov eax,lightGray + (black * 16)
	call SetTextColor
	mov eax,'*'
	call WriteChar
	add edi,TYPE COORD
	loop go
	
	mov dx,1800h
	call Gotoxy
	ret
ShowPath ENDP

;--------------------------------------------------------
CompInit PROC
; Compares X and Y to the initial values, turns zero flag on if they are equal
;--------------------------------------------------------

	cmp bx,startX
	jne good
	cmp dx,startY
good:
	ret
CompInit ENDP

;--------------------------------------------------------
NextChar PROC
; Get a random int from 0-3 (I needed 4 bytes to fit the jump)
;--------------------------------------------------------
	mov	eax,4		; choose a direction (0-3)
	call	RandomRange
	ret
NextChar ENDP

END ;Walk2