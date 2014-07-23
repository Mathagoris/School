TITLE  Chapter 11, Pr 4 (Random_Color_Char_Screen_Fill.asm)

; Program:     Chapter 11, Pr 4
; Description: Fill each screen cell with a random character in a random color
; Student:     Matt Dohlen	
; Date:        05/07/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc
.data
outHandle HANDLE ?
xyPos COORD <0,0>
MAXCOL = 50
bufColor WORD MAXCOL DUP(0)
bufChar	 BYTE MAXCOL DUP(0)
cellsWritten DWORD ?
.code
main2 PROC
	
	INVOKE GetStdHandle,STD_OUTPUT_HANDLE
	mov outHandle,eax
	mov ecx,20
L1:	push ecx
	mov ecx,50
	mov esi,OFFSET bufColor
	mov edi,OFFSET bufChar

L2:	call ChooseColor
	mov [esi],ax
	call ChooseChar
	mov [edi],al
	add esi,2
	inc edi
	loop L2
	
	INVOKE WriteConsoleOutputAttribute, outHandle, ADDR bufColor,
		MAXCOL, xyPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, outHandle, ADDR bufChar, 
		MAXCOL, xyPos, ADDR cellsWritten
	inc xyPos.Y
	pop ecx
	loop L1
	
	mov dh,21
	mov dl,0
	call Gotoxy
	exit
main2 ENDP

; Selects a color with a 50% probability of red, a 25% of green and 25% of yellow
; Receives: nothing
; Returns:  EAX = randomly selected color
ChooseColor PROC
	mov eax,4
	call RandomRange
	.IF eax == 0		
	  mov eax,GREEN
	.ELSEIF eax == 1
	  mov eax,YELLOW
	.ELSE
	  mov eax,RED
	.ENDIF
	ret
ChooseColor ENDP

; Randomly selects an ASCII character
; Receives: nothing
; Returns:  AL = randomly selected character, from ASCII code 20h to 07Ah 
ChooseChar PROC
	mov eax,91
	call RandomRange
	add eax,20h
	ret
ChooseChar ENDP


END ;main2