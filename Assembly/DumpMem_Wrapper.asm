TITLE MASM Template						(main.asm)

TITLE Chapter 8 Exercise 3             (DumpMem_Wrapper.asm)

Comment !
Description: Write a program that call the procedure
DumpMemory that is a wrapper procedure modeled after
DumpMem that accepts 3 parameters
!

; Student:     Matt Dohlen
; Date:        04/03/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding



INCLUDE Irvine32.inc

DumpMemory PROTO,
	address:PTR BYTE,
	len:BYTE,
	typeOfArray:BYTE

.data
array DWORD 1,2,3,4,5,6,7,8,9,0Ah,0Bh,0Ch,0Dh,0Eh,0Fh
array1 WORD 0,9,8,7,6,5,4,3,2,1
array2 BYTE '1','2','3','4','5'
space BYTE ' ',' ',0
prompt1 BYTE "Dump of offset ",0
prompt2	BYTE "------------------------------",0dh,0ah,0
.code
main PROC
	
	INVOKE DumpMemory, 
	OFFSET array,
	LENGTHOF array,
	TYPE array
	
	INVOKE DumpMemory, 
	OFFSET array1,
	LENGTHOF array1,
	TYPE array1
	
	INVOKE DumpMemory, 
	OFFSET array2,
	LENGTHOF array2,
	TYPE array2

	exit
main ENDP

;---------------------------------------------------
DumpMemory PROC,
	address:PTR BYTE,
	len:BYTE,
	typeOfArray:BYTE
;
; Calculates a factorial nonrecursively
; Receives: eax = value of n to calculate factorial
; Returns: eax = calculated factorial
;---------------------------------------------------
	mov edx,OFFSET prompt1
	call WriteString
	mov eax,address
	call WriteHex
	call crlf
	mov edx,OFFSET prompt2
	call WriteString
	
	mov ecx,0
	mov cl,len
	mov ebx,0
	mov bl,typeOfArray
	mov esi,0
	mov edi,address
L1:
	mov eax,[edi]
	call WriteHexB
	add address,ebx
	mov edx,OFFSET space
	call WriteString
	add edi,ebx
	cmp esi,8
	jb L2
	call crlf
	mov esi,0
L2:
	loop L1
	call crlf
	call crlf

	ret
DumpMemory ENDP
END main