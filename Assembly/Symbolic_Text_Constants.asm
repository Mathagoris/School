TITLE Symbolic Text Constants		 (Symbolic_Text_Constants.asm)
; Program Description:	This program defines symbolic names then
;						creates variables that uses these symbolic names
; Author:	Matt Dohlen
; Creation Date: 2/18/2014
; Revisions: N/A
; Date:		Modified by:

INCLUDE Irvine32.inc
.data
hello		EQU <"Hello world", 0dh, 0ah, 0>
goodbye		EQU <"This is the end of the program, goodbye.", 0dh, 0ah, 0>
wed			EQU <"Today is wednesday", 0dh, 0ah, 0>
redundant	EQU <"This message is redundant", 0dh, 0ah, 0>

open	BYTE hello
close	BYTE goodbye
day		BYTE wed
again	BYTE redundant

.code
mainC PROC
	
	mov edx,OFFSET open
	call WriteString
	mov edx,OFFSET day
	call Writestring
	mov edx,OFFSET again
	call Writestring
	mov edx,OFFSET close
	call Writestring
	exit

mainC ENDP

END ;mainC