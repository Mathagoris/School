TITLE DOS File Time              (DOS_File_Time.asm)

; Program:     Chapter 7 Pr 3
; Description: Convert a four digit hex number into DOS File Time
; Student:     Matt Dohlen
; Date:        03/19/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.data
prompt1 BYTE "Please enter 16-bit hexadecimal (4-digit, e.g., 1207): ",0
prompt2 BYTE "Your equivalent binary is ",0
prompt3 BYTE "Your DOS file time is ",0
prompt4 BYTE "Sorry, invalid entry...", 0dh, 0ah, 0dh, 0ah, 0

.code
DOS PROC
	
	mov edx,OFFSET prompt1
	call WriteString
	call ReadHex				
	call CheckFormat			;check format before outputting anything else
	jz Error					;ZF=0 if valid
	mov edx,OFFSET prompt2
	call WriteString
	mov ebx,TYPE WORD
	call WriteBinB
	call crlf
	mov edx,OFFSET prompt3
	call WriteString
	call ShowFileTime
	call crlf
	call crlf
	exit
Error:
	mov edx,OFFSET prompt4
	call WriteString
	exit

DOS ENDP

;------------------------------------------------------------
CheckFormat PROC USES eax
;
; Checks to see if a hex number fits DOS file time format
; Receives: EAX hex number to be analyzed
; Returns: sets zero flag if format is incorrect
;------------------------------------------------------------

	mov ecx,eax
	cmp eax,65535
	ja Set
	and ax,001Fh
	cmp ax,29
	ja Set
	mov eax,ecx
	and ax,07D0h
	cmp ax,1888
	ja Set
	mov eax,ecx
	and ax,0F800h
	cmp ax,49152
	ja Set
	ret
Set:
	and ecx,0
	ret

CheckFormat ENDP
;------------------------------------------------------------
ShowFileTime PROC
;
; Displays file time in proper format
; Receives: EAX time to be displayed
; Returns: nothing
;------------------------------------------------------------
	
	mov ecx,eax
	mov edx,eax
	shr ecx,11
	call LeadingZero
	
	mov al,':'
	call WriteChar
	mov ecx,edx
	shr cx,5
	and cx,3Fh
	call LeadingZero
	
	mov al,':'
	call WriteChar
	mov ecx,edx
	and ecx,001Fh
	mov eax,ecx
	mov bx,2
	mul bx
	mov ecx,eax
	call LeadingZero
	
	
	ret
ShowFileTime ENDP
;------------------------------------------------------------
LeadingZero PROC
;
; Check if a number needs a leading zero and write it to the
; screen if it does
; Receives: ECX the number to be checked
; Returns: nothing
;------------------------------------------------------------

	cmp ecx,9
	ja L1
	mov eax,0
	call WriteDec
	
L1:	mov eax,ecx
	call WriteDec
	ret
LeadingZero ENDP
END DOS