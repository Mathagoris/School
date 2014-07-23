TITLE Chapter 7 Exercise 8              (Packed_BCD_to_ASCII.asm)

Comment !
Description: Write a procedure named PackedToAsc that converts a
4-byte packed decimal number to a string of ASCII decimal digits.
Pass the packed number to the procedure in EAX, and pass a pointer
to a buffer that will hold the ASCII digits. Write a short test
program that demonstrates several conversions and displays the
converted numbers on the screen.
!
; Student:     Matt Dohlen	
; Date:        03/27/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc

.data
numbers DWORD 87654321h, 45346894h, 193492h, 123h, 3h
buffer BYTE 8 DUP(1), 0   ; 8 digits plus null character

.code
main8stub PROC

   mov ecx,LENGTHOF numbers		; Prepare for LOOP
   mov esi,OFFSET numbers
L1:
   ; Prepare pointer to buffer and packed decimal number
   mov edx,OFFSET buffer
   mov eax,[esi]
   
   ; Call _PackedToAsC to convert to ASCII digits
   call _PackedToAsC
   
   ; Display string of digits
   mov edx,OFFSET buffer
   call WriteString
   call crlf

   ; Get next number
   add esi,4
   loop L1

main8stub ENDP

;----------------------------------------------------------------
_PackedToAsc PROC USES ecx esi
;
; procedure that converts a 4-byte packed decimal number
; to a string of ASCII decimal digits
; Receives: EAX, packed decimal number
;           EDX, pointer to a buffer with ASCII returned
; Returns: String of ASCII digits in buffer pointed by EDX
;------------------------------------------------------------------
	add edx,7
	mov ecx,8

L2:	
	mov ebx,eax
	and ebx,0fh
	add ebx,30h
	mov [edx],bl
	dec edx
	shr eax,4
	loop L2

	ret

_PackedToAsc ENDP


END main8stub