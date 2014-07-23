TITLE Ch 6, Pr 11						(Multiple_Byte_Key_Encryption)

; Program:     Chapter 6, Pr 11
; Description: This program demonstrates simple Symmetric-key Encryption using
;			   the XOR instruction with a multi-byte key entered by the user.
; Student:     Matt Dohlen	
; Date:        03/12/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding

BUFMAX = 128

INCLUDE Irvine32.inc
.data
prompt1  BYTE  "Enter the plain text: ",0
prompt2  BYTE  "Enter the encryption key: ",0
sEncrypt BYTE  "Cipher text:         ",0
sDecrypt BYTE  "Decrypted:           ",0

keyStr   BYTE   BUFMAX+1 DUP(0)
buffer   BYTE   BUFMAX+1 DUP(0)

.code
main11 PROC
    mov edx,OFFSET prompt1  ; display buffer prompt
	call WriteString
    mov ebx,OFFSET buffer   ; point to the buffer
    call InputTheString

    mov edx,OFFSET prompt2  ; display key prompt
	call WriteString
    mov ebx,OFFSET keyStr   ; point to the key
    call InputTheString
	
	mov ebx,OFFSET buffer	; encrypt
	mov edx,OFFSET keyStr	
	call TranslateBuffer	

	mov edx,OFFSET sEncrypt ; display encrypted message
	call WriteString
	mov edx,OFFSET buffer
	call WriteString
	call crlf
	
	mov ebx,OFFSET buffer	; decrypt
	mov edx,OFFSET keystr
	call TranslateBuffer

	mov edx,OFFSET sDecrypt	; display encrypted message
	call WriteString
	mov edx,OFFSET buffer
	call WriteString
	call crlf

	exit
main11 ENDP



;------------------------------------------------------------
InputTheString PROC
;
; Reads a string from the user and puts it in to a buffer
; Receives: ebx points to a buffer
; Returns: nothing
;------------------------------------------------------------
	pushad
	mov edx,ebx
	mov ecx,BUFMAX
	call ReadString
	call crlf
	popad
	ret
InputTheString ENDP

;------------------------------------------------------------
TranslateBuffer PROC
;
; Encrypts of decrypts a string using a multi-byte key
; Receives: ebx points to a string
;			edx points to the key
; Returns: nothing
;------------------------------------------------------------
	pushad
	mov edx,0
	mov esi,0
L1:	mov bl,keyStr[edx]
	xor buffer[esi],bl
	inc esi
	inc edx
	cmp buffer[esi],0
	je quit
	cmp keyStr[edx],0
	jne L1
	mov edx,0
	jmp L1

quit:
	popad
	ret
TranslateBuffer ENDP


END ;main11