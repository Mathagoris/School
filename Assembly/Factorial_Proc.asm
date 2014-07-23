TITLE Chapter 8 Exercise 4              (Factorial_Proc.asm)

Comment !
Description: Write a nonrecursive version of the Factorial procedure
(Section 8.5.2) that uses a loop. Write a short program that
interactively tests your Factorial procedure. Let the user enter
the value of n. Display the calculated factorial.
!

; Student:     Matt Dohlen
; Date:        04/01/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc

.data
msgInput BYTE "Enter the value of n to calculate " 
	BYTE "the factorial (-1 to quit): ",0
msgOutput BYTE "The factorial is: ",0
factorialError  BYTE "Error: Result does not fit "
	BYTE "in 32 bits.",0

.code
main3stub PROC

L1:
	; message to display
	mov edx,OFFSET msgInput
	call WriteString
	; get an integer n from the user
	call ReadInt
	; if n is -1, go quit
	cmp eax,0
	jl quit
	
	call _FactorialIterative	
	; EAX = factorial(n)
	cmp eax,0
	jnz good
	; if error, show factorialError message
	mov edx,OFFSET factorialError
	call WriteString
	jmp Done
	; if OK, display factorial
good:
	mov edx,OFFSET msgOutput
	call WriteString
	call WriteDec
Done:
	; go back to L1
	call crlf
	call crlf
	jmp L1
quit: 
	exit
main3stub ENDP

;---------------------------------------------------
_FactorialIterative PROC USES ecx edx
;
; Calculates a factorial nonrecursively
; Receives: eax = value of n to calculate factorial
; Returns: eax = calculated factorial
;---------------------------------------------------
.code

	; deal with base case 
	cmp eax,1
	ja next
	mov eax,1
	jmp end_factorial
next:
	; init
	mov ecx,eax
	
Factorial_loop:

	; n - 1
	dec ecx
	; n * (n - 1) 
	mul ecx
	; if out of range occurs
	; go end_factorial
	jnc InRan
	mov eax,0
	jmp end_factorial
InRan:
	; if counter > 1, go Factorial_loop	
	cmp ecx,1
	ja Factorial_loop

end_factorial:

	ret
_FactorialIterative ENDP

END ;main3stub