TITLE Chapter 6 Pr 10				(Print_Fibonacci_Until_Overflow.asm)

; Program:     Chapter 6 Pr 10
; Description: Calculate and display the Fibonacci number sequence until 
;			   overflow flag is set
; Student:     Matt Dohlen
; Date:        03/18/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
prompt BYTE ": "

.code
Fib PROC
	mov eax, 1
	mov ebx, 0
	mov esi, 1
	mov edx, 0
L1:	

	call PrintFib
	inc esi
	mov edx, eax
	add eax, ebx
	mov ebx, edx
	jno L1

	exit
Fib ENDP


;------------------------------------------------------------
PrintFib PROC
;
; Write a fibonacci number to screen in a formatted way.
; Receives: ESI holds the index number, 
;           EAX = fib number
; Returns: nothing
;------------------------------------------------------------
	pushad
	xchg eax, esi
	call WriteDec
	xchg eax, esi
	mov edx,OFFSET prompt
	call WriteString
	call WriteDec
	call crlf
	popad
	ret
PrintFib ENDP

END Fib