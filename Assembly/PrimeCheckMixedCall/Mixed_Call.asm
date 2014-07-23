TITLE C_Assembly_Mixed_Call    (Mixed_Call.asm)

// Program:     C_Assembly_Mixed_Call
// Description: Check whether an integer entered by the user is
//				prime or not
// Student:     Matt Dohlen
// Date:        05/20/2014
// Class:       CSCI 241
// Instructor:  Mr. Ding


.386
.model flat, C
intSqrt PROTO C, n:DWORD
.code
isPrimeASM PROC, inVal:DWORD

	INVOKE intSqrt, inVal
	mov ebx,eax
	mov ecx,2
next:
	cmp ecx,ebx
	jle L1
	mov eax,1
	jmp quit
L1:
	mov edx,0
	mov eax,inVal
	div ecx
	cmp edx,0
	jne L2
	mov eax,0
	jmp quit
L2:
	inc ecx
	jmp next
quit:
    ret                   
isPrimeASM ENDP
end