include externs.inc



.data 

	
.code

;----------------POMOCNI MAKROI----------------------
_rotl MACRO 
	
ENDM
;kopira pointe
InitShape PROC USES EAX ESI EDI,
	 orgShp:PTR POINT, destShp:PTR POINT

	mov ecx,4
	mov esi,orgShp
	mov edi,destShp
loop1:
	mov ax,(POINT PTR [esi]).x
	mov (POINT PTR [edi]).x,ax
	mov ax,(POINT PTR [esi]).y
	mov (POINT PTR [edi]).y,ax
	add esi,TYPE orgShp
	add edi,TYPE destShp
	loop loop1

	ret
InitShape ENDP

PointsToCoords PROC USES EAX ESI EDI, 
		points:PTR POINT, coords:PTR COORD, center:COORD

	mov ecx,4
	mov esi,points
	mov edi,coords
loop2:
	mov ax,(POINT PTR [esi]).x
	sar ax,1
	add ax,center.x
	mov (COORD PTR [edi]).x,ax

	mov ax,(POINT PTR [esi]).y
	sar ax,1
	neg ax
	add ax,center.y
	mov (COORD PTR [edi]).y,ax

	add esi,TYPE points
	add edi,TYPE coords
	loop loop2

	ret
PointsToCoords ENDP

ROTL PROC USES EAX EBX ECX ESI EDI,
		points:PTR POINT, coords:PTR COORD, center:COORD, table:PTR BYTE
		LOCAL temp[4]:POINT, ctemp[4]:COORD

	mov esi,points
	lea edi, temp
	mov ecx,4
loop1:
	mov bx,(POINT PTR [esi]).x
	mov ax,(POINT PTR [esi]).y
	neg ax
	mov (POINT PTR [edi]).x,ax
	mov (POINT PTR [edi]).y,bx
	add esi,TYPE POINT
	add edi,TYPE POINT
	loop loop1

;-------------------Da li moze da se rotira---------------
	INVOKE PointsToCoords, ADDR temp, ADDR ctemp, center
	INVOKE ColisionHit, table, ADDR ctemp
	cmp eax,0
	jnz hit
	INVOKE OutOfBounds, ADDR ctemp
	cmp eax,0
	jnz hit


	INVOKE PointsToCoords, ADDR temp, coords, center

	lea esi,temp
	mov edi, points
	mov ecx,4
loop2:
	mov ax,(POINT PTR [esi]).x
	mov (POINT PTR [edi]).x,ax
	mov ax,(POINT PTR [esi]).y
	mov (POINT PTR [edi]).y,ax;moguca greska COORD UMESTO POINT
;
	add esi,TYPE POINT
	add edi,TYPE COORDS
	loop loop2
hit:
	ret
ROTL ENDP

DrawShape PROC USES EAX EBX ECX EDI,
		coords:PTR COORD, hnd:DWORD, poc:COORD
		LOCAL temp[4]:COORD
	
	mov ecx,4
	mov ebx,coords
	lea edi,temp
loop2:
	mov ax,(COORD PTR [ebx]).x
	add ax,poc.x
	mov (COORD PTR [edi]).x,ax
	mov ax,(COORD PTR [ebx]).y
	add ax,poc.y
	mov (COORD PTR [edi]).y,ax
	add ebx,TYPE COORD
	add edi,TYPE COORD
	loop loop2

	mov ecx,4
	lea ebx,temp
loop1:
	push ecx
	mov eax,0
	mov ax,(COORD PTR [ebx]).y
	sub ax,poc.y
	cmp ax,0
	jl skip
	INVOKE SetConsoleCursorPosition, hnd, COORD PTR [ebx]
	mov al, 254
	call WriteChar
skip:
	add ebx,type COORD
	pop ecx
	loop loop1
	ret
DrawShape ENDP

DeleteShape PROC USES EAX EBX ECX EDI,
		coords:PTR COORD, hnd:DWORD,poc:COORD
		LOCAL temp[4]:COORD

	mov ecx,4
	mov ebx,coords
	lea edi,temp
loop2:
	mov ax,(COORD PTR [ebx]).x
	add ax,poc.x
	mov (COORD PTR [edi]).x,ax
	mov ax,(COORD PTR [ebx]).y
	add ax,poc.y
	mov (COORD PTR [edi]).y,ax
	add ebx,TYPE COORD
	add edi,TYPE COORD
	loop loop2

	mov ecx,4
	lea ebx,temp
loop1:
	push ecx
	mov ax,(COORD PTR [ebx]).y
	sub ax,poc.y
	cmp ax,0
	jl skip
	INVOKE SetConsoleCursorPosition, hnd, COORD PTR [ebx]
	
	mov al, ' '
	call WriteChar
skip:
	add ebx,type COORD
	pop ecx
	loop loop1
	ret
DeleteShape ENDP

end
