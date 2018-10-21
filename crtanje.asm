include externs.inc

.code

Draw PROC USES AX ECX EBX,
	bafer: PTR BYTE, pocKoord: COORD, hnd:DWORD, vrste:DWORD, kolone:DWORD
	
	mov EBX, bafer
	mov ECX, vrste
loop1:
	push ECX
	INVOKE SetConsoleCursorPosition, hnd, pocKoord
	INVOKE WriteConsole, hnd, EBX, kolone, 0,0
	add EBX, kolone
	mov AX, pocKoord.y
	add AX, 1
	mov pocKoord.y, AX
	pop ECX
	loop loop1
	ret
Draw ENDP

Delete PROC USES AX ECX EBX,
	 pocKoord: COORD, hnd:DWORD, vrste:DWORD, kolone:DWORD

	mov ECX, kolone
loop2:

push ' '
loop loop2

	mov EBX, ESP
	mov ECX, vrste
loop1:
	push ECX
	INVOKE SetConsoleCursorPosition, hnd, pocKoord
	INVOKE WriteConsole, hnd, EBX, kolone, 0,0
	mov AX, pocKoord.y
	add AX, 1
	mov pocKoord.y, AX
	pop ECX
	loop loop1
	ret
Delete ENDP


end

		

	