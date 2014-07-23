TITLE Greatest Common Divisor          (GCD.asm)

; Program:     Chapter 7 Pr 6
; Description: Find the greatest common divisor of two integers entered by the
;			   user.
; Student:     Matt Dohlen
; Date:        03/20/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc


.data
prompt1		BYTE "Enter a 32 bit integer: ",0
prompt2		BYTE "Greatest common divisor is ",0
promptBad	BYTE "Input invalid, try again: ",0

.code
GCD PROC
	
	call GetInt
	mov ebx, eax
	call GetInt
	call CalcGcd
	mov edx,OFFSET prompt2
	call WriteString
	call WriteDec
	call crlf

	exit
GCD ENDP

;------------------------------------------------------------
GetInt PROC
;
; Prompts user for an integer and reads it into eax and checks input
; Receives: nothing
; Returns: eax = value entered
;------------------------------------------------------------
	
	mov edx,OFFSET prompt1
	call WriteString
read:  
	call ReadInt
    jno  good
	
    mov  edx,OFFSET promptBad
    call WriteString
    jmp  read        ;go input again

good:
	jns pos
	neg eax
pos:
	ret
GetInt ENDP

;------------------------------------------------------------
CalcGcd PROC
;
; Prompts user for an integer and reads it into eax and checks input
; Receives: nothing
; Returns: eax = value entered
;------------------------------------------------------------


next:
	mov edx,0
	div ebx
	mov eax,ebx
	mov ebx,edx
	cmp edx,0
	ja next
	
	ret
CalcGcd ENDP
END ;GCD