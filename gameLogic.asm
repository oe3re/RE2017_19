include externs.inc

.code
;vraca da li je red popunjen u EAX
_checkLine PROC USES ECX ESI,
	tmp:PTR BYTE

	mov ecx,TEREN_WIDTH
	mov esi,tmp
loop1:
	mov al,BYTE PTR [esi]
	cmp al,0
	jz izlaz
	inc esi
	loop loop1
izlaz:
	ret
_checkLine ENDP

_clearLine PROC USES ECX ESI,
	tmp:PTR BYTE

	mov ecx,TEREN_WIDTH
	mov esi,tmp
loop1:
	mov (BYTE PTR [esi]),0
	inc esi
	loop loop1
	ret
_clearLine ENDP

;Slaze tablicu kada se red popuni, Vraca broj obrisanih redova u EAX, top predstavlja optimizaciju 0 pregleda sve, 5 ne pregleda prvih 5 redova
ClearLines PROC USES EBX ECX ESI,
	table:PTR BYTE, top:DWORD

	mov eax,0
	mov al,TEREN_WIDTH
	mul BYTE PTR top
	mov esi,table
	add esi,eax
	mov ecx,TEREN_HEIGHT
	sub ecx,top 
	mov ebx,0
loop1:
	INVOKE _checkLine, esi
	cmp eax,0
	jz skip
	INVOKE _clearLine, esi
	mov eax, esi  ; koliko ima elemenata do vrha (table[0])
	sub eax, table
	CALL _sort
	add ebx,1
skip:
	add esi,TEREN_WIDTH*TYPE BYTE
	loop loop1
	mov eax,ebx
	ret
ClearLines ENDP

;uzima esi i broj ciklusa u eax
_sort PROC USES EAX ECX ESI EDI,

	mov ecx,eax
	dec esi
	mov edi,esi
	add edi, TEREN_WIDTH
	loop1:
		mov al,(BYTE PTR[esi])
		mov (BYTE PTR[edi]),al
		dec edi
		dec esi
	loop loop1
	ret
_sort ENDP

;prebacuje sadrzaj  tabele u baffer karaktera
Table2Graphics PROC USES EAX ECX ESI EDI,
	table:PTR BYTE, graphT:PTR BYTE

	mov ecx,TEREN_WIDTH*TEREN_HEIGHT
	mov esi,table
	mov edi,graphT
loop1:
	mov al,(BYTE PTR[esi])
	cmp al,0
	jz skok
	mov (BYTE PTR[edi]),254
	jmp uslov
skok:
	mov (BYTE PTR[edi]),' '
uslov:
	inc esi
	inc edi
	loop loop1

	ret
Table2Graphics ENDP

;upisuje gObj u tabelu
Transfer2Table PROC USES EAX EBX ECX EDI ESI,
	coords:PTR COORD, table:PTR BYTE
	
	mov ecx,4
	mov esi,coords
	
loop1:
	mov eax,TEREN_WIDTH
	mov ebx,0
	mov bx,(COORD PTR [esi]).y
	add bx,2;zbog 220
	mul bx
	add ax,(COORD PTR [esi]).x
	mov ebx,eax
	cmp eax,220
	jge skip
	add ebx,table
	mov (BYTE PTR [ebx]), 1
skip:
	add esi,TYPE COORD
	loop loop1
	ret
Transfer2Table ENDP

ColisionLeft PROC USES ECX ESI,
	coords: PTR COORD
	
	mov eax,0
	mov ecx,4
	mov esi,coords
loop1:
	;levo
	mov ax, (COORD PTR [esi]).x
	sub ax,1
	cmp ax,-1
	jle hit

	add esi,TYPE COORD
	loop loop1

	mov eax,1
	ret
hit:
	mov eax,0
	ret

ColisionLeft ENDP

ColisionRight PROC USES ECX ESI,
	coords: PTR COORD
	LOCAL desno:WORD

	mov eax,0
	mov ecx,4
	mov esi,coords
loop1:
	;desno
	mov ax, (COORD PTR [esi]).x
	add ax,1
	cmp ax,TEREN_WIDTH
	jge hit

	add esi,TYPE COORD
	loop loop1

	mov eax,1
	ret
hit:
	mov eax,0
	ret

ColisionRight ENDP

ColisionBottom PROC USES ECX ESI,
	coords: PTR COORD

	mov eax,0
	mov ecx,4
	mov esi,coords
loop1:
	;dole
	mov ax, (COORD PTR [esi]).y
	add ax,1
	cmp ax,TEREN_HEIGHT-2
	jge hit

	add esi,TYPE COORD
	loop loop1

	mov eax,1
	ret
hit:
	mov eax,0
	ret

ColisionBottom ENDP

;vraca sudar u eax!=0
ColisionHit PROC USES EBX ECX ESI EDI,
	table:PTR BYTE, coords:PTR COORD

	mov edi, coords
	mov ecx, 4

loop2:
	mov esi, table
	mov eax,0
	mov eax,TEREN_WIDTH
	mov ebx,0
	mov bx,(COORD PTR [edi]).y
	add bx,2;zbog 220
	mul bl
	add ax,(COORD PTR [edi]).x
	add esi,eax
	mov al,BYTE PTR [esi]
	cmp al,0
	jnz hit
	add edi,TYPE COORD
	loop loop2

	mov eax,0
	ret
hit:
	mov eax,1
	ret
ColisionHit ENDP

OutOfBounds PROC USES ECX ESI,
	coords:PTR COORD

	mov esi,coords
	mov ecx,4
loop1:
	mov ax, (COORD PTR [esi]).x
	cmp ax, -1
	jle hit
	mov ax, (COORD PTR [esi]).x
	cmp ax, TEREN_WIDTH
	jge hit
	mov ax, (COORD PTR [esi]).y
	cmp ax, TEREN_HEIGHT-2
	jge hit
	add esi,TYPE COORD
	loop loop1

	mov eax,0
	ret
hit:
	mov eax,1
	ret

OutOfBounds ENDP

MoveLeft PROC USES EAX EBX ECX ESI,
	objCent: PTR COORD, coords:PTR COORD, points:PTR POINT, table:PTR BYTE
	LOCAL temp[4]:COORD

	mov esi,objCent
	mov ax,(COORD PTR [esi]).x
	sub ax,1
	mov (COORD PTR [esi]).x,ax

	INVOKE PointsToCoords, points, ADDR temp, COORD PTR [esi]

	INVOKE ColisionHit, table, ADDR temp
	cmp eax,0
	jnz hit

	INVOKE PointsToCoords, points, coords, COORD PTR [esi]

	ret
hit:
	mov esi,objCent
	mov ax,(COORD PTR [esi]).x
	add ax,1
	mov (COORD PTR [esi]).x,ax
	ret

MoveLeft ENDP

MoveRight PROC USES EAX EBX ECX ESI,
	objCent: PTR COORD, coords:PTR COORD, points:PTR POINT, table:PTR BYTE
	LOCAL temp[4]:COORD

	mov esi,objCent
	mov ax,(COORD PTR [esi]).x
	add ax,1
	mov (COORD PTR [esi]).x,ax

	INVOKE PointsToCoords, points, ADDR temp, COORD PTR [esi]

	INVOKE ColisionHit, table, ADDR temp
	cmp eax,0
	jnz hit

	INVOKE PointsToCoords, points, coords, COORD PTR objCent

	ret
hit:
	mov esi,objCent
	mov ax,(COORD PTR [esi]).x
	sub ax,1
	mov (COORD PTR [esi]).x,ax
	ret

MoveRight ENDP

MoveDown PROC USES EBX ECX ESI,
	objCent: PTR COORD, coords:PTR COORD, points:PTR POINT, table:PTR BYTE
	LOCAL temp[4]:COORD

	mov esi,objCent
	mov ax,(COORD PTR [esi]).y
	add ax,1
	mov (COORD PTR [esi]).y,ax

	INVOKE PointsToCoords, points, ADDR temp, COORD PTR [esi]

	INVOKE ColisionHit, table, ADDR temp
	cmp eax,0
	jnz hit

	INVOKE PointsToCoords, points, coords, COORD PTR objCent

	mov eax,0
	ret
hit:
	mov esi,objCent
	mov ax,(COORD PTR [esi]).y
	sub ax,1
	mov (COORD PTR [esi]).y,ax
	mov eax,1
	ret

MoveDown ENDP

BottomStop PROC USES EBX ECX ESI EDI,
	table:PTR BYTE, coords:PTR COORD

	mov edi, coords
	mov ecx, 4
loop2:
	mov eax,0
	mov ax,(COORD PTR [edi]).y
	add eax,1
	cmp eax,TEREN_HEIGHT-2
	jz	hit

	mov esi, table
	mov eax,0
	mov eax,TEREN_WIDTH
	mov ebx,0
	mov bx,(COORD PTR [edi]).y
	add bx,3;zbog 220+jedna nize test
	mul bl
	add ax,(COORD PTR [edi]).x
	add esi,eax
	mov al,BYTE PTR [esi]
	cmp al,0
	jnz hit
	add edi,TYPE COORD
	loop loop2

	mov eax,0
	ret
hit:
	mov eax,1
	ret

BottomStop ENDP

GameEnd PROC USES ECX ESI,
	coords:PTR COORD

		mov esi,coords
	mov ecx,4
loop1:
	mov ax, (COORD PTR [esi]).y
	cmp ax, -2
	jz hit
	add esi,TYPE COORD
	loop loop1

	mov eax,0
	ret
hit:
	mov eax,1
	ret
GameEnd ENDP

InitTable PROC USES EAX ECX ESI,
	table:PTR BYTE

	mov ecx,TEREN_WIDTH*TEREN_HEIGHT
	mov esi,table
loop1:
	mov eax,0
	mov BYTE PTR[esi],al
	inc esi
loop loop1

	ret
InitTable ENDP

end