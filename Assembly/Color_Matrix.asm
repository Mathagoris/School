TITLE  Chapter 5, Pr 8 (ColorMatrix.asm)

; Program:     Chapter 5, Pr 8
; Description: Display a single char in all possible color arrangements
; Student:     Matt Dohlen	
; Date:        03/06/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc
.data

.code
main PROC
	
	mov eax, 0
	mov ecx, 16

L1: push ecx
	mov ecx, 16

L2: call SetTextColor
	inc al
	push eax
	mov eax, 'X'
	call WriteChar
	pop eax
	loop L2

	call crlf
	pop ecx
	loop L1
	
	mov eax,white + (black * 16)
	call SetTextColor
	exit
main ENDP

END main