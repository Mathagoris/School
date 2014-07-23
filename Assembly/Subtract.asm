TITLE Subtract		(Subtract.asm)
; Program Description: This program subtracts 16-bit intetegers
; Author: Matthew Dohlen
; Creation Date: 2/14/2014
; Revisions: N/A
; Date:			Modified by:

INCLUDE Irvine32.inc

.code
mainA PROC

	mov	eax,00000000h
	mov	ax,0FFFFh		; AX = FFFFh
	sub	ax,2000h		; AX = DFFFh
	sub	ax,0001h		; AX = DFFEh
	sub  ax,0F00h		; AX = D0FEh
	call	DumpRegs

	exit
mainA ENDP
END ;mainA