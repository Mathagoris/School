TITLE iMove_with_Control_Keys 					(iMove_with_Control_Keys.asm)


; Program:     iMove_with_Control_Keys
; Description: Use arrow keys and other control keys to move a character 
;			   within the rectangle area
; Student:     Matt Dohlen	
; Date:        05/07/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding



INCLUDE Irvine32.inc

DrawChar PROTO charToWrite:BYTE, x:BYTE, y:BYTE, clr:BYTE

MinY = 5
MaxY = 17
MinX = 3
MaxX = 75
StartX = ((MaxX - MinX)/2) + MinX
StartY = ((MaxY - MinY)/2) + MinY

.data
clrToShow BYTE ?
clrToHide BYTE ?
orgClr	  BYTE ?
chToMove BYTE "I"
prevX	BYTE StartX
prevY	BYTE StartY
nextX	BYTE StartX
nextY	BYTE StartY
menuState BYTE 0

stdOutHandle HANDLE ?
consoleInfo CONSOLE_SCREEN_BUFFER_INFO <>
cursor CONSOLE_CURSOR_INFO <1,0>

.code
iMove PROC
	
	;Inintialize screen
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov stdOutHandle, eax
	INVOKE SetConsoleCursorInfo,stdOutHandle, ADDR cursor
	INVOKE GetConsoleScreenBufferInfo, stdOutHandle, ADDR consoleInfo
	INVOKE SetConsoleTextAttribute, stdOutHandle, consoleInfo.wAttributes
	mov ax,consoleInfo.wAttributes
	mov clrToShow,al
	mov clrToHide,al
	shr al,4
	and clrToHide,0F0h
	or clrToHide,al
	call DrawRectangle
	call ToggleHelp
	INVOKE DrawChar, chToMove, nextX, nextY, clrToShow
	
L1:
	call ProcessKey
	jc quit
	INVOKE GetConsoleScreenBufferInfo, stdOutHandle, ADDR consoleInfo
	mov ax,consoleInfo.wAttributes
	mov clrToShow,al
	mov clrToHide,al
	shr al,4
	and clrToHide,0F0h
	or clrToHide,al
	INVOKE DrawChar, chToMove, prevX, prevY, clrToHide    ; previous 'I' at dx
	INVOKE DrawChar, chToMove, nextX, nextY, clrToShow    ; current  'I' at bx
	jmp L1
quit:
	mov dh,MaxY + 1
	mov dl,0
	call Gotoxy
	INVOKE SetConsoleTextAttribute, stdOutHandle, consoleInfo.wAttributes
	exit
iMove ENDP

;===============================================================================================
DrawChar PROC charToWrite:BYTE, x:BYTE, y:BYTE, clr:BYTE
; Draws a character at a given position. 
; Receives: charToWrite - the character used to represent
;           x, y - position at coordinate x, y (Col, Row)
;           clr - the color used to draw char
;===============================================================================================

	mov al,clr
	call SetTextColor
	mov al,charToWrite

	;test if next position is out of bounds
	mov dl,x
	mov dh,y
	cmp dl,MinX
	jbe bad
	cmp dl,MaxX
	jae bad
	cmp dh,MinY
	jbe bad
	cmp dh,MaxY
	jae bad

	;good coord so write it out
	call Gotoxy
	call WriteChar
	mov prevX,dl
	mov prevY,dh
	jmp ex

bad:
	;bad coord so write out previous
	mov dl,prevX
	mov dh,prevY
	mov nextX,dl
	mov nextY,dh
	call Gotoxy
	call WriteChar
	mov al,7h
	call WriteChar
	
ex:
	
	ret
DrawChar ENDP

;===============================================================================================
DrawRectangle PROC
; Draws a boarder rectangle from MinX, MinY to MaxX MaxY. 
; Receives: Constant symbols: MinX, MinY to MaxX MaxY
;===============================================================================================

	mov dh, MinY
	mov dl, MinX
	mov ecx,MaxX - MinX + 1
	mov al,0CDh
D1:
	call Gotoxy
	call WriteChar
	inc dl
	loop D1
	
	inc dh
	mov dl,MinX
	mov al,0BAh
	mov ecx,MaxY - (MinY + 1)
D2:
	call Gotoxy
	call WriteChar
	mov dl,MaxX
	call Gotoxy
	call WriteChar
	mov dl,MinX
	inc dh
	loop D2
	
	mov dh, MaxY
	mov dl, MinX
	mov ecx,MaxX - MinX + 1
	mov al,0CDh
D3:
	call Gotoxy
	call WriteChar
	inc dl
	loop D3
	
	ret
DrawRectangle ENDP

;===============================================================================================
ToggleHelp PROC
; Turns on/off the help text when F1 pressed
;===============================================================================================
.data
	prompt1 BYTE "iMove Guide:",0dh,0ah
			BYTE "Press F1 key for help...                                  ",0dh,0ah
			BYTE "                                                                       ",0dh,0ah
			BYTE "                                                         ",0
	prompt2 BYTE "iMove Guide:",0dh,0ah
			BYTE "1. Directly use four arrow keys for Up, Right, Down, Left.",0dh,0ah
			BYTE "2. ^Up: Up-Right, ^Right: Down-Right, ^Down: Down-Left, ^Left: Up-Left.",0dh,0ah
			BYTE "3. Home: back to center. ESC: Exit. F1: Toggle Help Text.",0
.code

	mov dx,0
	call Gotoxy
	mov al,menuState
	cmp al,0
	jne N1
	mov edx,OFFSET prompt1
	call WriteString
	jmp N2
N1:	mov edx,OFFSET prompt2
	call WriteString
N2:	
	not menuState
	ret
ToggleHelp ENDP

;===============================================================================================
ProcessKey PROC
; By reading a char, checks its scan code to recognize 
; Arrow, Control Arrow, Home, ESC, and F1 keys. Then take 
; the action accordingly
; Return: carry flage set if ESC pressed, else cleared
;===============================================================================================

PK1:
	mov eax,10
	call Delay
	call ReadKey
	jz PK1
	
	INVOKE GetKeyState, VK_LCONTROL
	test al,80h
	.IF !Zero?
		;============================
		;crtl-left
		;============================
		INVOKE GetKeyState, VK_LEFT
		test al,80h
		.IF !Zero?
			dec nextX
			dec nextY
		.ENDIF

		;============================
		;crtl-right
		;============================
		INVOKE GetKeyState, VK_RIGHT
		test al,80h
		.IF !Zero?
			inc nextX
			inc nextY
		.ENDIF
		
		;============================
		;crtl-up
		;============================
		INVOKE GetKeyState, VK_UP
		test al,80h
		.IF !Zero?
			inc nextX
			dec nextY
		.ENDIF
		
		;============================
		;crtl-down
		;============================
		INVOKE GetKeyState, VK_DOWN
		test al,80h
		.IF !Zero?
			dec nextX
			inc nextY
		.ENDIF
	
	.ELSE
		;============================
		;left
		;============================
		INVOKE GetKeyState, VK_LEFT
		test al,80h
		.IF !Zero?
			dec nextX
		.ENDIF

		;============================
		;right
		;============================
		INVOKE GetKeyState, VK_RIGHT
		test al,80h
		.IF !Zero?
			inc nextX
		.ENDIF

		;============================
		;up
		;============================
		INVOKE GetKeyState, VK_UP
		test al,80h
		.IF !Zero?
			dec nextY
		.ENDIF

		;============================
		;down
		;============================
		INVOKE GetKeyState, VK_DOWN
		test al,80h
		.IF !Zero?
			inc nextY
		.ENDIF
	.ENDIF
	;============================
	;home
	;============================
	INVOKE GetKeyState, VK_HOME
	test al,80h
	.IF !Zero?
		mov nextX,StartX
		mov nextY,StartY
	.ENDIF

	;============================
	;F1
	;============================
	INVOKE GetKeyState, VK_F1
	test al,80h
	.IF !Zero?
		call ToggleHelp
	.ENDIF

	;============================
	;escape
	;============================
	INVOKE GetKeyState, VK_ESCAPE
	test al,80h
	.IF !Zero?
		stc
	.ELSE
		clc
	.ENDIF
	
	ret
ProcessKey ENDP

END ;iMove