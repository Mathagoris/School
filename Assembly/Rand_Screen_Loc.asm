TITLE  Chapter 5, Pr  (Rand_Screen_Loc.asm)

; Program:     Chapter 5, Pr 7
; Description: Display a single char randomly on the screen
; Student:     Matt Dohlen	
; Date:        03/12/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc
.data

.code
rand PROC
	
	mov  ecx, 100

L1:	mov  eax, 0
	call GetMaxXY
	call RandomRange
	mov  bx,dx
	mov  dh,al
	mov  ax,bx
	call RandomRange
	mov  dl,al
	call Gotoxy
	mov  eax,'A'
	call WriteChar
	mov  eax,300
	call Delay


	loop L1
	mov edx,0
	call Gotoxy
	exit
rand ENDP

END ;rand