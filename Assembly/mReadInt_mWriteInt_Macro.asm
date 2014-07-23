TITLE Chapter 10 Exercise 5 and 6             (mReadInt_mWriteInt_Macro.asm)

; Program:     Chapter 10 Pr 5
; Description: Create 2 macros on for reading 32 and 16 bit integers and another
;			   for writing 8, 16, or 32 bit integers
; Student:     Matt Dohlen
; Date:        05/01/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc
INCLUDE Macros.inc

;---------------------------------------------
mReadInt MACRO intVal:REQ
;---------------------------------------------
	
	IF (TYPE intVal) EQ 4
L1:		call readInt
		jo L1
		mov intVal, eax
	ELSEIF (TYPE intVal) EQ 2
L2:		call readInt
		jo L3
		cmp eax,32767
		jg L3
		cmp eax,-32768
		jl L3
		mov intVal, ax
		jmp L4
L3:		mWrite " <16-bit integer overflow>"
		call crlf
		jmp L2
L4:
	ELSE
		ECHO error: ***************************************************************************
		ECHO error: Argument &intVal passed to mReadInt must be either 16 or 32 bits.
		ECHO error: &intVal must be of 16 or 32-bit data type.
		ECHO error: ***************************************************************************
		EXITM
	ENDIF
ENDM

;-------------------------------------------------------
mWriteInt MACRO intVal:REQ
;-------------------------------------------------------

	IF (TYPE intVal EQ 2) OR (TYPE intVal EQ 1)
		mWrite "&intVal = "
		movsx eax, intVal
		call WriteInt
	ELSEIF (TYPE intVal) EQ 4
		mWrite "&intVal = "
		mov eax,intVal
		call WriteInt
	ELSE
		ECHO warning : ************************************************************************
		ECHO warning : Argument &intVal passed to mWriteInt must be 8, 16, or 32 bits.
		ECHO warning : ************************************************************************
		EXITM
	ENDIF
	call crlf
ENDM
.data
bVal SBYTE -2
wVal SWORD -122
dVal DWORD 1234567
qVal QWORD 11

.code
read PROC

	mWrite "Enter a 32-bit integer: "
	mReadInt dVal
	mWriteInt dVal
	mWrite "Enter a 16-bit integer: "
	mReadInt BX
	mWriteInt BX
	;mReadInt AL
	mWriteInt bVal
	mWriteInt wVal
	mWriteInt AX
	mWriteInt ebx

; Test the macro's error message
	mWriteInt qVal

	exit
read ENDP

END ;read