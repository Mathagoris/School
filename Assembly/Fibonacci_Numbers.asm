TITLE Fibonacci Numbers					(Fibonacci_Numbers.asm)

; Program:     Chapter 4 Pr 6
; Description: Calculate, Store, and display the first 12 values of the
;			   Fibonacci number sequence
; Student:     Matt Dohlen
; Date:        02/26/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
	array	BYTE 12 DUP(?)

.code
Fib PROC
	mov eax, 1
	mov ebx, 0
	mov ecx, 12
	mov esi, 0
L1:
	mov [array + esi], al
	inc esi
	mov edx, eax
	add eax, ebx
	mov ebx, edx
	loop L1

	mov esi, OFFSET array
	mov ebx, 1
	mov ecx, SIZEOF array
	call DumpMem
	
	exit
Fib ENDP

END ;Fib