TITLE Chapter 11, Pr 9					(Show_Date_Time_of_File.asm)

; Program:     Chapter 11 Pr 9
; Description: 
; Student:     Matt Dohlen
; Date:        05/12/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

WriteDateTime PROTO, dateTime:SYSTEMTIME
SystemTimeToTzSpecificLocalTime PROTO,
    lpTimeZone:DWORD,    
    lpUniversalTime:PTR SYSTEMTIME,
    lpLocalTime:PTR SYSTEMTIME
    
Len_filename = 64

.data
filename BYTE Len_filename Dup(0)
sysTimeCreated SYSTEMTIME <>
sysTimeLastWritten SYSTEMTIME <>
input BYTE "Input your file name: ",0
created BYTE " was created on: ",0
written BYTE "And it was last written on: ",0
fileDNE BYTE " does not exist in directory.",0dh,0ah,0

.code
mainz PROC
	
	mov edx, OFFSET input
	call WriteString
		
	mov	edx, OFFSET filename
    mov	ecx, Len_filename-1
    call ReadString

    mov	esi, OFFSET sysTimeCreated
    mov	edi, OFFSET sysTimeLastWritten
    call	AccessFileDateTime
    jc badFile
    
    mov edx, OFFSET filename
    call WriteString
    mov edx, OFFSET created
    call WriteString
    INVOKE WriteDateTime, sysTimeCreated
	mov edx, OFFSET written
	call WriteString
	INVOKE WriteDateTime, sysTimeLastWritten
	jmp quit
	
badFile:
	mov edx, OFFSET filename
    call WriteString
	mov edx, OFFSET fileDNE
	call WriteString
quit:
	exit
mainz ENDP

; Receives: EDX offset of filename, 
;           ESI points to a SYSTEMTIME structure of sysTimeCreated
;           EDI points to a SYSTEMTIME structure of sysTimeLastWritten
; Returns: If successful, CF=0 and two SYSTEMTIME structures contain the file's date/time data. 
;          If it fails, CF=1.
AccessFileDateTime PROC
.data
fileHandle HANDLE ?
whenCreated FILETIME <>
lastWritten FILETIME <>
tempSysTime SYSTEMTIME <>

.code
	call OpenInputFile
	cmp eax,INVALID_HANDLE_VALUE
	jne good
	
	stc
	jmp en
	
good:
	mov fileHandle,eax
	INVOKE GetFileTime, fileHandle, ADDR whenCreated, NULL, ADDR lastWritten
	INVOKE FileTimeToSystemTime, ADDR whenCreated, ADDR tempSysTime
	INVOKE SystemTimeToTzSpecificLocalTime, NULL, ADDR tempSysTime, esi
	INVOKE FileTimeToSystemTime, ADDR lastWritten, ADDR tempSysTime
	INVOKE SystemTimeToTzSpecificLocalTime, NULL, ADDR tempSysTime, edi
	mov eax,fileHandle
	call CloseFile
	clc
en:
	ret
AccessFileDateTime ENDP

WriteDateTime PROC USES eax edx, dateTime:SYSTEMTIME
.data
colonStr BYTE ":",0
slashStr BYTE "/",0
spaceStr BYTE " ",0
.code
	movzx eax,dateTime.wMonth	; month
	call  WriteDec
	mov   edx,OFFSET slashStr	; "/"
	call  WriteString		
	movzx eax,dateTime.wDay		; day
	call  WriteDec
	call  WriteString			; "/"
	movzx eax,dateTime.wYear	; year
	call  WriteDec
	mov	  edx,OFFSET spaceStr	; " "
	call  WriteString
	movzx eax,dateTime.wHour	; hours
	call  WriteDec
	mov   edx,offset colonStr	; ":"
	call  WriteString
	movzx eax,dateTime.wMinute	; minutes
	call  WriteDec
	call  WriteString			; ":"
	movzx eax,dateTime.wSecond	; seconds
	call  WriteDec
	call Crlf
	ret
WriteDateTime ENDP

END ;mainz
