TITLE Symbolic Integer Constants		 (Symbolic_Integer_Constants.asm)
; Program Description:	This program defines symbolic constants then
;						creates an array that uses those constants
; Author:	Matt Dohlen
; Creation Date: 2/18/2014
; Revisions: N/A
; Date:		Modified by:

INCLUDE Irvine32.inc
.data
sun = 0
mon = 1
tue = 2
wed = 3
thu = 4
fri = 5
sat = 6

week WORD sun, mon, tue, wed, thu, fri, sat
listSize = ($ - week) / 2

.code
mainB PROC
	mov ax, listSize

	exit
mainB ENDP

END ;mainB