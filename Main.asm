
IDEAL
MOUSE_COLORred equ 127 ; red
MOUSE_COLORgreen equ 255 ; green
MOUSE_COLORblue equ 127 ; blue
Macro Screen 
     mov ax,1 
	 mov ds,ax 
endm screen 
macro Data
     mov ax,@data 
	 mov ds,ax  
endm Data
MACRO PUT_CHAR   MY_CHAR
	mov dl,MY_CHAR
	mov ah,2
	int 21h
ENDM 
MODEL small
STACK 100h 
FILE_NAME_IN  equ 'MyPic.bmp'
 
BMP_WIDTH = 320
BMP_HEIGHT = 200

SMALL_BMP_HEIGHT = 40
SMALL_BMP_WIDTH = 40
MaxFloodStackDepth = 50

Fill_Color = 8
Fill_Color_Border = 0
DATASEG
Cursor2 dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111001111111b
dw 1111111001111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b 
dw 1111111111111111b
dw 1111111111111111b
;background 
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b 
dw 0000000000000000b
dw 0000000000000000b
Cursor3 dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111110001111111b
dw 1111110001111111b
dw 1111110001111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b 
dw 1111111111111111b
dw 1111111111111111b
;background 
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b 
dw 0000000000000000b
dw 0000000000000000b
Cursor4 dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111110000111111b
dw 1111110000111111b
dw 1111110000111111b
dw 1111110000111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b 
dw 1111111111111111b
dw 1111111111111111b
;background 
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b 
dw 0000000000000000b
dw 0000000000000000b
Cursor5 dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111100000111111b
dw 1111100000111111b
dw 1111100000111111b
dw 1111100000111111b
dw 1111100000111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b 
dw 1111111111111111b
dw 1111111111111111b
;background 
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b 
dw 0000000000000000b
dw 0000000000000000b
Cursor6 dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111100000011111b
dw 1111100000011111b
dw 1111100000011111b
dw 1111100000011111b
dw 1111100000011111b
dw 1111100000011111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b 
dw 1111111111111111b
dw 1111111111111111b
;background 
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b 
dw 0000000000000000b
dw 0000000000000000b
Cursor7 dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111000000011111b
dw 1111000000011111b
dw 1111000000011111b
dw 1111000000011111b
dw 1111000000011111b
dw 1111000000011111b
dw 1111000000011111b
dw 1111111111111111b
dw 1111111111111111b 
dw 1111111111111111b
dw 1111111111111111b
;background 
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b 
dw 0000000000000000b
dw 0000000000000000b
Cursor8 dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111111111111111b
dw 1111000000001111b
dw 1111000000001111b
dw 1111000000001111b
dw 1111000000001111b
dw 1111000000001111b
dw 1111000000001111b
dw 1111000000001111b
dw 1111000000001111b
dw 1111111111111111b
dw 1111111111111111b 
dw 1111111111111111b
dw 1111111111111111b
;background 
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b
dw 0000000000000000b 
dw 0000000000000000b
dw 0000000000000000b 

	
	
;BMP File data
     OneBmpLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer
   
    ScrLine 	db BMP_WIDTH dup (0)  ; One Color line read buffer

	;BMP File data
	FileName 	db "Help.bmp" ,0
	FileHandle	dw ?
	Header 	    db 54 dup(0)
	Palette 	db 400h dup (0)
	
	SmallPicName db 'Pic48X78.bmp',0
	
	
	BmpFileErrorMsg    	db 'Error At Opening Bmp File ',FILE_NAME_IN, 0dh, 0ah,'$'
	ErrorFile           db 0
    BB db "BB..",'$'
	; array for mouse int 33 ax=09 (not a must) 64 bytes
	
	 
	Color db ?
	Xclick dw ?
	Yclick dw ?
	Xp dw ?
	Yp dw ?
	SquareSize dw ?
	BmpLeft dw ?
	BmpTop dw ?
	BmpColSize dw ?
	BmpRowSize dw ?
	;my data 
    FileName1 db "explain.bmp",0 
	FileName2 db "Finish.bmp",0 
	Filehow db "howto.bmp",0 
	Filenew db "new.bmp",0 
	Fileopen db "open.bmp",0 
	FileExit db "Exit.bmp",0 
	BlueB db "BlueB.bmp",0 
	screenS db 0 ;state of screen 
	;0=main screan  
	;1=help screan 
	;2=start screan 
	color1 db 5 
	;color you choos the defolt is 5 
	deletor db 0 ;its like Bool 
	;0=Not choos 1=choos 
	mouseClick  db 0 ;bool that become 1 if mouse click it chnge to 0 
	;when mouse get up 
	;from Mouse.asm 
	MOuseG db 4
	Mous db 0 
	Mouseg1 db 1
	;its print to screan when the user press finish 
	PrintF db "press E to close this project without Saving",0dh,0ah  
	db "press S  Save as",0dh,0ah  
	db "press c to save",0dh,0ah,'$'
	;array from SAve.asm 
	 CopyFrom db "E.bmp",0  
File2 db 105 dup (5) 
StartDAta db 1078 dup (0) 
LineCopy db 320 dup (1) 
SAveScrean db 57600 dup (0) 
FileName5 db 103 dup (1)  
NAmeMassage db 0ah,0dh,"write your file name",0dh,0ah 
db "or the all path",0dh,0Ah 
db"if you just write your file Name",0dh,0ah 
db "it will save/open on c:tasm",0dh,0ah,'$' 
Clock equ es:6Ch
 File10 db "start.bmp",0 

    T_1_sec = 18 
CODESEG
p286 


    ORG 100h
start:
     mov ax,@Data  
	 mov ds,ax  
	 mov ah,0 
	 mov al,13h 
	 int 10h  
	 call Starting 
	 call Startsc 
	 mov ax,1 
	 int 33h
	 push 0 
@@BACk: 
	 call MouseClick2 
	 pop ax 
	 cmp ax,1 
	 je @@do 
	 jmp @@Back 
@@do: 
	 call CheckStart 
	 call CheckBS 
	 mov ax,1 
	 int 33h 
	 jmp @@BACk 
;---------------------------
; Procudures area
;---------------------------
proc createFile 
     mov bx,offset SCreens 
	 mov [byte ptr bx],0 
	 mov dx, offset FileName
	 mov [BmpLeft],15
	 mov [BmpTop],0 
	 mov [BmpColSize],35 
	 mov [BmpRowSize] ,9  
	 call OpenShowBmp
     mov ax,0A000h 
	 mov es,ax 	 
	 mov bx,12
	 mov ax,0A000h 
	 mov es,ax 
     mov bx,offset color1 
	 mov bl,[bx] 
	 mov bh,0 
	 push bx 
	 call Tools 

	 mov ax,1 
	 int 33h 	 
@@BAck:
     call CheckMouse
     push 0 	 
     call MouseClick2 
	 pop ax 
	 cmp ax,1 
	 je @@continue 
	 jmp @@ShowMouse 
@@continue: 
     call MouseClickQ 
	 call MouseClickB 
     call HideMouse ;hide cursor just if his y litele than 20
     call PrintOnCursor 
	 call GetColor 
	 call BrashMouse
	 call CheckDeletor
	 call CheckFinish
	 call Checkbs 
	; check if mouse isnt press if it is the mouse will show again 
	 jmp @@End1 
@@ShowMouse: 
     mov ax,1 
	 int 33h 
@@END1: 
    jmp @@Back 
 EXIT:
	 mov ax, 4C00h ; returns control to dos
  	 int 21h 
endp createFile 
 include "Mouse.asm"
 include "screen.asm"
 include "screen1.asm"
 include "MouseC.asm" 
 include "SAve.asm" 
 include "sound.asm" 
 
  ;to open that file click here 
  ;c://tasm//Mouse.asm
  ;to sea just how to use the procdure click here 
  ;c://tasm//MouseHelp.txt  
END start