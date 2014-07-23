TITLE Chapter 9, Pr 2					(Str_concat.asm)

; Program:     Chapter 9 Pr 2
; Description: Designs and implements a procedure called Str_concat that
;			   concatenates a source string to the end of a target string.
; Student:     Matt Dohlen
; Date:        04/07/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

Str_concat PROTO target:PTR BYTE, source:PTR BYTE

.data
sourceStr	BYTE	64 Dup(0)
targetStr	BYTE	64 Dup(0)
enterStr	BYTE	"Enter a string: ",0
concatStr	BYTE	"The string concatenated: ",0
invalidSz	BYTE	"Not enough space to store string...",0dh,0ah,0

.code
main1 PROC
	
	mov edx,OFFSET enterStr
	call WriteString
	mov edx,OFFSET targetStr
	mov ecx,SIZEOF targetStr
	call ReadString

	mov edx,OFFSET enterStr
	call WriteString
	mov edx,OFFSET sourceSTr
	mov ecx,SIZEOF sourceStr
	call ReadString

	INVOKE Str_concat, ADDR targetStr, ADDR sourceStr
	jz L1

	mov edx,OFFSET concatStr
	call WriteString
	mov edx,OFFSET targetStr
	call WriteString
	call crlf
	jmp L2

L1:	mov edx,OFFSET invalidSz
	call WriteString
L2:	exit
main1 ENDP

;------------------------------------------------------------------------------
Str_concat PROC target:PTR BYTE, source:PTR BYTE
;
; Concatenates one string on to the end of another and also checks to make sure
; the target string is large enough to fit both strings
; Receives: The address of the source and target string
; Returns: Nothing
;------------------------------------------------------------------------------

	mov edi,target
	mov esi,source
	
	INVOKE Str_length, esi
	mov ecx,eax
	mov ebx,eax
	INVOKE Str_length, edi
	add ebx,eax
	inc ebx
	mov edx,SIZEOF targetStr
	cmp ebx,edx
	ja L3

	add edi,eax
	rep movsb
	jmp L4

L3: test al,0
L4:	ret
Str_concat ENDP

END main1
