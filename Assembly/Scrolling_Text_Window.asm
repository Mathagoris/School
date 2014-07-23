INCLUDE Irvine32.inc
 
 NumOutput = 50

.data
stdOutHandle HANDLE ?
textString BYTE ": This line of text was written to the screen buffer",0dh,0ah,0
consoleInfo CONSOLE_SCREEN_BUFFER_INFO <>

.code
scroll PROC   

	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov stdOutHandle,eax
	INVOKE GetConsoleScreenBufferInfo, stdOutHandle, ADDR consoleInfo

	mov ecx,NumOutput
	mov eax,1
	mov edx,OFFSET textString
L1:
	call WriteDec
	call WriteString
	inc eax
	loop L1

	INVOKE SetConsoleWindowInfo, stdOutHandle, TRUE, 
		ADDR consoleInfo.srWindow
	mov ecx,NumOutput
	mov consoleInfo.srWindow.Top,1
	mov consoleInfo.srWindow.Bottom,1
	mov consoleInfo.srWindow.Left,0
	mov consoleInfo.srWindow.Right,0

L2:
	mov ebx,ecx
	INVOKE Sleep,500
	INVOKE SetConsoleWindowInfo, stdOutHandle, FALSE, 
		ADDR consoleInfo.srWindow
	mov ecx,ebx
	loop L2
    exit
scroll ENDP
END  ;scroll