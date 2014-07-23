TITLE  Chapter 6, supplied (ColorMatrix2.asm)

; Program:     Chapter 6, supplied
; Description: Display a single char in all possible color arrangements
; Student:     Matt Dohlen	
; Date:        03/12/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc
.data

.code
matrix PROC
	
	mov eax, 0
	mov ecx, 256

L1: call SetTextColor
	inc al
	push eax
	mov eax, 'X'
	call WriteChar
	pop eax
	test al,00001111b
	jnz L2
	call crlf
L2:
	LOOP L1

	
	mov eax,white + (black * 16)
	call SetTextColor
	exit
matrix ENDP

END ;matrix