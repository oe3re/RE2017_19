include Irvine32.inc

;------------------------------SHAPE PROTOS---------------------------
InitShape PROTO STDCALL orgShp:PTR POINT, destShp:PTR POINT

PointsToCoords PROTO STDCALL points:PTR POINT, coords:PTR COORD, center:COORD

ROTL PROTO STDCALL points:PTR POINT, coords:PTR COORD, center:COORD, table:PTR BYTE

DrawShape PROTO STDCALL coords:PTR COORD, hnd:DWORD, poc:COORD

DeleteShape PROTO STDCALL coords:PTR COORD, hnd:DWORD, poc:COORD

;------------------------------crtanje PROTOS---------------------------

Draw PROTO STDCALL bafer: PTR BYTE, pocKoord: COORD, hnd:DWORD, vrste:DWORD, kolone:DWORD

Delete PROTO STDCALL pocKoord: COORD, hnd:DWORD, vrste:DWORD, kolone:DWORD

;------------------------------GameLogic PROTOS---------------------------

ClearLines PROTO STDCALL table:PTR BYTE, top:DWORD

Table2Graphics PROTO STDCALL table:PTR BYTE, graphT:PTR BYTE

Transfer2Table PROTO STDCALL coords:PTR COORD, table:PTR BYTE

ColisionLeft PROTO STDCALL coords: PTR COORD
ColisionRight PROTO STDCALL coords: PTR COORD
ColisionBottom PROTO STDCALL coords: PTR COORD
ColisionHit PROTO STDCALL table:PTR BYTE, coords:PTR COORD
OutOfBounds PROTO STDCALL coords:PTR COORD

MoveLeft PROTO STDCALL objCent: PTR COORD, coords:PTR COORD, points:PTR POINT, table:PTR BYTE
MoveRight PROTO STDCALL objCent: PTR COORD, coords:PTR COORD, points:PTR POINT, table:PTR BYTE
MoveDown PROTO STDCALL objCent: PTR COORD, coords:PTR COORD, points:PTR POINT, table:PTR BYTE

BottomStop PROTO STDCALL table:PTR BYTE, coords:PTR COORD
GameEnd PROTO STDCALL coords:PTR COORD


InitTable PROTO STDCALL table:PTR BYTE

POINT STRUCT
	x SWORD ?
	y SWORD ?
POINT ENDS

;--------------golobalne konstante---------------------
;KEY CODES IN AH
UP_ARROW EQU  48h
DOWN_ARROW EQU 50h
LEFT_ARROW EQU 4Bh
RIGHT_ARROW EQU 4Dh
ESC_KEY EQU 1h
ENTER_KEY EQU 1Ch
;
TEREN_WIDTH EQU 10
TEREN_HEIGHT EQU 22



;-------------makroi-----------------------------------


MoveCoord MACRO source, dest
	
ENDM

AddCoord MACRO source, dest
	
ENDM

SubCoord MACRO source, dest
	
ENDM