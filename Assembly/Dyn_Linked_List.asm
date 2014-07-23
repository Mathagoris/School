TITLE Dynamically allocated linked list          (Dyn_Linked_List.asm)

; Program:     Dynamically Linked List
; Description: Create a linked list that is dynamically created and
;			   filled by the user
; Student:     Matt Dohlen
; Date:        05/14/2014
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc


NODE STRUCT
  intVal SDWORD ?
  pNext  DWORD ?
NODE ENDS
PNODE TYPEDEF PTR NODE

NULL = 0

.data
head NODE <0,NULL> ; Dummy head
prompt1 BYTE "Number of integers to enter? ",0
prompt2 BYTE "Signed integer node value? ",0
contents BYTE "Contents of linked list:",0dh,0ah,0
dummy BYTE "Dummy Head",0
point BYTE " -> ",0
hHeap HANDLE ?

.code
dyn PROC
	
	mov esi,OFFSET head		;current ptr
	mov edi,esi				;tail ptr
	INVOKE GetProcessHeap
	.IF eax == NULL
		call WriteWindowsMsg
		jmp quit
	.ELSE
		mov hHeap,eax
	.ENDIF
	
I1:	mov edx,OFFSET prompt1
	call WriteString
	call ReadInt
	jo I1
	cmp eax,1
	jl I1
	mov ecx,eax
	
L1: mov edx,OFFSET prompt2
	call WriteString
	call ReadInt
	jo L1

	call CreateNode
	jc quit
	loop L1

	call crlf
	mov esi,OFFSET head
	call DisplayList
	mov esi,OFFSET head
	call DestroyList
quit:
	exit
dyn ENDP

;-------------------------------------------------------------
CreateNode PROC uses ecx
;
; Allocates a new node, fills it with a value, and points the
; previous node at it.
; Recieves: ESI and EDI pointing to a node
; Returns: CF = 0 if the memory allocationn succeeds.
;------------------------------------------------------------- 
	mov ebx,eax
	INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY, TYPE NODE
	.IF eax == NULL
		stc
	.ELSE
		mov edi,eax
		mov (NODE PTR [esi]).pNext,edi
		mov (NODE PTR [edi]).intVal,ebx
		mov (NODE PTR [edi]).pNext,NULL
		mov esi,edi
		clc
	.ENDIF
	ret
CreateNode ENDP

;-------------------------------------------------------------
DisplayList PROC
; Display all the nodes in the list
; Recieves: ESI pointing to head node
;-------------------------------------------------------------

	mov edx,OFFSET dummy
	call WriteString
	mov edi,(NODE PTR [esi]).pNext
	cmp edi,NULL
	je done
	mov esi,edi
	mov edx,OFFSET point

next:
	call WriteString
	mov eax,(NODE PTR [esi]).intVal
	call WriteInt
	mov edi,(NODE PTR [esi]).pNext
	cmp edi,NULL
	je done
	mov esi,edi
	jmp next
done:
	call crlf
	ret
DisplayList ENDP

;-------------------------------------------------------------
DestroyList PROC
; Display all the nodes in the list
; Recieves: ESI pointing to head node
;-------------------------------------------------------------

	mov edi,(NODE PTR [esi]).pNext
	cmp edi,NULL
	je destroyed
	mov esi,edi

L2:
	mov edi,(NODE PTR [esi]).pNext
	INVOKE HeapFree, hHeap, NULL, esi
	cmp edi,NULL
	je destroyed
	mov esi,edi
	jmp L2

destroyed:
	ret
DestroyList ENDP
END dyn