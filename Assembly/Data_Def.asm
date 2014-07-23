TITLE Data Definitions		 (Data_Def.asm)
; Program Description:	This program defines many different types of 
;					of data and move them to a register if possible
; Author:	Matt Dohlen
; Creation Date: 2/14/2014
; Revisions: N/A
; Date:		Modified by:

INCLUDE Irvine32.inc
.data
str1		BYTE		"ABC"
val1		SBYTE	-12
val2		WORD		"AB"
val3		SWORD	0FFFFh
val4		DWORD	20000000h
val5		SDWORD	-12345
val6		FWORD	4141414h
val7		QWORD	99999999
val8		TBYTE	1h
rVal1	REAL4	-2.1
rVal2	REAL8	3.2E-260
rVal3	REAL10	4.6E+4096

.code
main PROC
	
	mov	al,str1
	mov	al,val1
	mov	bx,val2
	mov	bx,val3
	mov	eax,val4
	mov	eax,val5
	mov	ebx,rVal1
	exit
main ENDP

END ;main