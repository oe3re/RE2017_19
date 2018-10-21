

include externs.inc

.data

tabela BYTE 220 DUP(0)
tabelaG BYTE 220 DUP(?)

pocKoord COORD <11,2>
pocKoord1 COORD <12,3>

prompt BYTE "PRESS ENTER TO START/ESC TO QUIT...",0
prompt2 BYTE "PRESS ANY KEY TO CONTINUE...",0
promptK2 COORD <1,25>
introK COORD <1,1>
introK2 COORD <1,7>
intro	BYTE 178,177,178,176,254, 32,178,254,254,178, 32,178,176,178,178,254, 32,178,176,176, 32, 32,254,254,177, 32, 32, 32,178,254,176,178
		BYTE  32, 32,178, 32, 32, 32,176, 32, 32, 32, 32, 32, 32,254, 32, 32, 32,177, 32, 32,178, 32, 32,178, 32, 32, 32,178, 32, 32, 32, 32
		BYTE  32, 32,176, 32, 32, 32,176,177,254, 32, 32, 32, 32,254, 32, 32, 32,177,254,177, 32, 32, 32,176, 32, 32, 32, 32,176,178,254, 32
		BYTE  32, 32,178, 32, 32, 32,178, 32, 32, 32, 32, 32, 32,178, 32, 32, 32,176, 32,254, 32, 32, 32,177, 32, 32, 32, 32, 32, 32, 32,254
		BYTE  32, 32,254, 32, 32, 32,177,177,254,178, 32, 32, 32,178, 32, 32, 32,254, 32, 32,177, 32,178,176,178, 32, 32,178,176,254,178, 32
		;5X32

teren	BYTE 201,205,205,205,205,205,205,205,205,205,205,187; 22x12
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
		BYTE 200,205,205,205,205,205,205,205,205,205,205,188

scoreK1 COORD <25,2>
scoreK2 COORD <26,5>
rez DWORD ?
score BYTE 201,205,205,205,205,205,205,205,205,205,205,187	;8x12
	  BYTE 186, 83, 67, 79, 82, 69, 58,' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',186
	  BYTE 200,205,205,205,205,205,205,205,205,205,205,188

buduciK COORD <1,2>
buduci BYTE 201,205,205,205,205,205,205,187	;8x8
	  BYTE 186,' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',186
	  BYTE 186,' ',' ',' ',' ',' ',' ',186
	  BYTE 200,205,205,205,205,205,205,188

Ishape POINT <-3,0>,<-1,0>,<1,0>,<3,0>
Zshape POINT <-1,-2>,<-1,0>,<1,0>,<1,2>
Sshape POINT <1,-2>,<1,0>,<-1,0>,<-1,2>
Lshape POINT <0,2>,<0,0>,<0,-2>,<2,-2>
Jshape POINT <0,2>,<0,0>,<0,-2>,<-2,-2>
Tshape POINT <-2,0>,<0,0>,<2,0>,<0,2>
Oshape POINT <-1,-1>,<-1,1>,<1,1>,<1,-1>


sADDR EQU OFFSET Ishape

gObjX2 POINT 4 DUP(<>)
gObj COORD 4 DUP(<>)
gObjCenter COORD <5,-2>

gObjBuduciX2 POINT 4 DUP(<>)
gObjBuduci COORD 4 DUP(<>)
gObjCenterB COORD <4,4>

consHandle DWORD ?
cInfo CONSOLE_CURSOR_INFO <>

ranNum DWORD ?



clear BYTE 500 DUP(' '),0


time DWORD 0
Tick=1000

.code
main proc			
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consHandle, EAX

	INVOKE GetConsoleCursorInfo, consHandle,ADDR cInfo
	mov eax,0
	mov cInfo.bVisible,eax
	INVOKE SetConsoleCursorInfo, consHandle, ADDR cInfo



	;---------------------intro-------------------------
introLabel:
	call Clrscr
	INVOKE Draw, ADDR intro, introK, consHandle, 5, 32
	INVOKE SetConsoleCursorPosition, consHandle, introK2
	mov  edx,OFFSET prompt
    call WriteString
w1:
	mov eax,20				;wait 20ms
	call Delay
	call ReadKey			; look for keyboard input
	
	cmp ah,ENTER_KEY
	jz newGame
	cmp ah,ESC_KEY
	jz izl
	jmp w1

	;---------------------Iscrtavanje terena----------------------------
newGame:
	
	INVOKE InitTable,ADDR tabela
	mov eax,5
	mov gObjCenter.x,ax
	mov eax,-2
	mov gObjCenter.y,ax

	call Clrscr
	INVOKE Draw, ADDR teren, pocKoord, consHandle, 22, 12
	INVOKE Draw, ADDR buduci, buduciK, consHandle, 8, 8

	;---------------------Inicijacija Scora---------------------------------
	INVOKE Draw, ADDR score, scoreK1, consHandle, 8, 12
	mov eax,0
	mov rez,eax
	INVOKE SetConsoleCursorPosition, consHandle, scoreK2
	mov eax,rez
	call WriteInt
	;----------------------Inicijalizacija prvog oblika------------------------
	;call Randomize zabada funkcija
	mov eax,7;		;prvi shape
	call RandomRange ;
	sal eax,4
	add eax, sADDR
	mov  ranNum,eax
	INVOKE InitShape, ranNum, ADDR gObjX2
	INVOKE PointsToCoords, ADDR gObjX2, ADDR gObj, gObjCenter

	;----------------------Inicijalizacija buduceg oblika--------------------
	mov eax,7;		;prvi shape
	call RandomRange ;
	sal eax,4
	add eax, sADDR
	mov  ranNum,eax
	INVOKE InitShape, ranNum, ADDR gObjBuduciX2
	INVOKE PointsToCoords, ADDR gObjBuduciX2, ADDR gObjBuduci, gObjCenterB
	INVOKE DrawShape, ADDR gObjBuduci, consHandle, buduciK

	jmp start
	
	;INVOKE Draw, ADDR intro, pocKoord, consHandle, 5, 32
	;invoke Delete, pocKoord, consHandle, 22, 11
	;INVOKE Table2Graphics,ADDR tabela, ADDR tabelaG
	INVOKE Draw, ADDR tabelaG+20, pocKoord1, consHandle, 20, 10
	;INVOKE Transfer2Table,ADDR gObj,ADDR tabela
	;INVOKE ClearLines, ADDR tabela, 20

	INVOKE Table2Graphics,ADDR tabela, ADDR tabelaG
	INVOKE Draw, ADDR tabelaG+20, pocKoord1, consHandle, 20, 10

newShape:
	INVOKE Transfer2Table,ADDR gObj,ADDR tabela
	INVOKE ClearLines, ADDR tabela, 0
	;score++
	add eax,rez
	mov rez,eax
	INVOKE SetConsoleCursorPosition, consHandle, scoreK2
	mov eax,rez
	call WriteInt
		;crtanje tabele
	INVOKE Table2Graphics,ADDR tabela, ADDR tabelaG
	INVOKE Draw, ADDR tabelaG+20, pocKoord1, consHandle, 20, 10

	mov eax,5
	mov gObjCenter.x,ax
	mov eax,-2
	mov gObjCenter.y,ax

	INVOKE InitShape, ADDR gObjBuduciX2, ADDR gobjX2
	;----------------------Inicijalizacija buduceg oblika--------------------
	mov eax,7;		;prvi shape
	call RandomRange ;
	sal eax,4
	add eax, sADDR
	mov  ranNum,eax
	INVOKE DeleteSHAPE, ADDR gObjBuduci, consHandle, buduciK
	INVOKE InitShape, ranNum, ADDR gObjBuduciX2
	INVOKE PointsToCoords, ADDR gObjBuduciX2, ADDR gObjBuduci, gObjCenterB
	INVOKE DrawShape, ADDR gObjBuduci, consHandle, buduciK
	jmp start

timer:
	

	INVOKE BottomStop, ADDR tabela, ADDR gObj
	cmp eax,0
	jz skip
lbl:
	INVOKE GameEnd, ADDR gObj
	cmp eax,0
	jnz kraj
	jmp newShape
skip:
	;crtanje oblika
	INVOKE DeleteSHAPE, ADDR gObj, consHandle, pocKoord1
	mov ax,gObjCenter.y
	inc ax
	mov gObjCenter.y,ax
start:
	INVOKE PointsToCoords, ADDR gObjX2, ADDR gObj, gObjCenter
	INVOKE DrawShape, ADDR gObj, consHandle, pocKoord1

waiting:

;-----------------------input resovling----------------------
	mov eax,20				;wait 20ms
	call Delay
	call ReadKey			; look for keyboard input
    jz   NoKey				; no key pressed yet
	
	cmp ah,UP_ARROW
	jz up
	cmp ah,DOWN_ARROW
	jz down
	cmp ah,LEFT_ARROW
	jz left
	cmp ah,RIGHT_ARROW
	jz right
	cmp ah,ESC_KEY
	jz introLabel
	jmp NoKey				;wrong key go to nokey

up:
	INVOKE DeleteSHAPE, ADDR gObj, consHandle, pocKoord1
	INVOKE ROTL, ADDR gObjX2, ADDR gObj, gObjCenter,ADDR tabela
	jmp keyFound	
	
down:
	;check can move down
	INVOKE ColisionBottom, ADDR gObj
	jz NoKey

	INVOKE DeleteSHAPE, ADDR gObj, consHandle, pocKoord1
	INVOKE MoveDown, ADDR gObjCenter, ADDR gObj, ADDR gObjX2, ADDR tabela
	cmp eax,0
	jnz lbl
	jmp keyFound	
left:
	; check can move left
	INVOKE ColisionLeft, ADDR gObj
	jz NoKey

	INVOKE DeleteSHAPE, ADDR gObj, consHandle, pocKoord1
	INVOKE MoveLeft, ADDR gObjCenter, ADDR gObj, ADDR gObjX2, ADDR tabela
	jmp keyFound

right:
	; check can move right
	INVOKE ColisionRight, ADDR gObj
	jz NoKey
	
	INVOKE DeleteSHAPE, ADDR gObj, consHandle, pocKoord1
	INVOKE MoveRight, ADDR gObjCenter, ADDR gObj, ADDR gObjX2, ADDR tabela
	jmp keyFound
	
	jmp NoKey		;wrong key
keyFound:
	INVOKE PointsToCoords, ADDR gObjX2, ADDR gObj, gObjCenter
	INVOKE DrawShape, ADDR gObj, consHandle, pocKoord1
NoKey:
	


;------------timeing logic------------------
	call GetTickCount
	mov ebx,eax
	sub eax,time
	cmp eax,Tick
	JB waiting
	mov time,ebx
	jmp timer

kraj:
	INVOKE SetConsoleCursorPosition, consHandle, promptK2
	mov  edx,OFFSET prompt2
    call WriteString
w2:
	mov eax,20				;wait 20ms
	call Delay
	call ReadKey	
	jz w2
	jmp introLabel

izl:
	invoke ExitProcess,0
main endp
end 