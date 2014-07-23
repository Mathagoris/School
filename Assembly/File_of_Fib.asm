TITLE Chapter 5 Exercise 2              (File_of_Fib.asm)

; Program:     Chapter 5 Pr 2
; Description: 
;	Using Programming Exercise 6 in Chapter 4 as a starting point, 
;	write a program that generates the first 47 values in the Fibonacci 
;	series, stores them in an array of doublewords, and writes the 
;	doubleword array to a disk file.
; Student:     Matt Dohlen
; Date:        03/02/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc

FIB_COUNT = 47	; number of values to generate

.data
fileHandle DWORD ?
filename BYTE "fibonacci.bin",0
array DWORD FIB_COUNT DUP(?)

.code
fibFile PROC

; Generate the array of values
	
	mov ecx,FIB_COUNT
	mov esi,OFFSET array
	call generate_fibonacci

; Create the file, call CreateOutputFile

	mov edx,OFFSET filename
	call CreateOutputFile
	mov fileHandle,eax

; Write the array to the file, call WriteToFile

	mov eax,fileHandle
	mov edx,OFFSET array
	mov ecx,SIZEOF array
	call WriteToFile


; Close the file, call CloseFile	

	mov eax,fileHandle
	call CloseFile

	exit
fibFile ENDP

;------------------------------------------------------------
generate_fibonacci PROC USES eax ebx ecx edx
;
; Generates fibonacci values and stores in an array.
; Receives: ESI points to the array, 
;           ECX = count
; Returns: nothing
;------------------------------------------------------------

	mov eax, 1
	mov ebx, 0

L1:
	call WriteDec
	call crlf
	mov [esi], eax
	add esi, 4
	mov edx, eax
	add eax, ebx
	mov ebx, edx
	loop L1

	ret
generate_fibonacci ENDP

END ;fibFile