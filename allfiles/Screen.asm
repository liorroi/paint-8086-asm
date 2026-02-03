;this of paint squre 
;===========================
;description:it print picsel 
;input:push first color than x than y 
;output:screen 
;REgistered used: none 
;===========================
ColorP equ [bp+8]  
XP12 equ [bp+6] 
YP12 equ [bp+4] 
Proc Picsel 
	 push bp 
	 mov bp,sp 
	 pusha  
	 mov ax,yp12 
	 mov cx,320 
	 mul cx 
	 add ax,Xp12 
	 mov bx,ax 
	 mov al,ColorP 
	 mov [es:bx],al  
	 popa 
	 pop bp 
	 ret 6 
endp PIcsel
Proc Picsel1 
	 push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,yp12 
	 cmp ax,21
	 jb @@Finish
     mov ax,3 
     int 33h 
	 shr cx,1 
	 cmp cx,21 
	 jbe @@Check
	 jmp @@check5   
@@Check: 
     mov ax,xp12 
	 cmp ax,300 
	 jae @@finish  
@@Check5: 
     mov ax,3
     int 33h 
	 shr cx,1 
	 cmp cx,0 
	 jae @@Check6 
	 jmp @@Continue   
@@Check6: 
     mov ax,Xp12 
	 cmp ax,320 
	 jae @@Finish 
@@Continue: 
	 mov ax,yp12 
	 mov cx,320 
	 mul cx 
	 add ax,Xp12 
	 mov bx,ax 
	 mov al,ColorP 
	 mov [es:bx],al 
@@Finish: 
	 popa 
	 pop bp 
	 ret 6 
endp PIcsel1
     ;===========================
     ;description:it print row on screen  
     ;input:push first color 
	 ;than the x of start point 
	 ;than the y of start point 
	 ;than the x of End point 
     ;output:screen 
     ;REgistered used: none 
     ;===========================
     RXS equ [bp+8]
	 RYS equ [bp+6]
	 RXE equ [bp+4]
	 colorR equ [bp+10]
proc row 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,RXS 
	 mov cx,RXE 
	 sub cx,ax 
	 mov dx,RYs 
	 mov bx,colorR 
@@Back: 
      push bx
	  push ax 
	  push dx 
	  call Picsel
	  add ax,1 
loop @@Back 
	 popa 
	 pop bp 
	 ret 8 
endp row 
proc row1 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,RXS 
	 mov cx,RXE 
	 sub cx,ax 
	 mov dx,RYs 
	 mov bx,colorR 
@@Back: 
      push bx
	  push ax 
	  push dx 
	  call Picsel1
	  add ax,1 
loop @@Back 
	 popa 
	 pop bp 
	 ret 8 
endp row1 
;==========================
;decription:draw squre on screen 
;input push color 
;than XS 
;than YS 
;than XE 
;than YE 

;        |      |<(XS,YS) 
;        |      |
;        |      |
;(XE,YE)>|      |
;output:screen 
;registered used:none 
XS equ [bp+10]
YS equ [bp+8]
XE equ [bp+6]
YE equ [bp+4]
color3 equ [Bp+12] 
proc Cube 
     push bp 
	 mov bp,sp 
	 pusha 
     mov ax,YS 
	 mov bx,YS 
	 mov cx,YE 
	 sub cx,bx 
@@Back: 
      
     mov dx,color3
     push dx
	 mov dx,XS 
	 push dx 
	 push ax 
	 mov dx,XE 
	 push dx 
	 call Row 
     add ax,1 	
	 loop @@Back 
	 popa 
	 pop bp 
	 ret 10 
endp Cube
proc Cube1
     push bp 
	 mov bp,sp 
	 pusha 
     mov ax,YS 
	 mov bx,YS 
	 mov cx,YE 
	 sub cx,bx 
@@Back: 
     mov dx,color3
     push dx
	 mov dx,XS 
	 push dx 
	 push ax 
	 mov dx,XE 
	 push dx 
	 call Row1
     add ax,1 	
	 loop @@Back 
	 popa 
	 pop bp 
	 ret 10 
endp Cube1 
proc OpenShowBmp                           
     push bp 
	call OpenBmpFile
	cmp [ErrorFile],1
	je @@ExitProc
	
	call ReadBmpHeader
	
	call ReadBmpPalette
	
	call CopyBmpPalette
	
	call ShowBMP
	
	 
	call CloseBmpFile
@@ExitProc:
    pop bp 
	ret
endp OpenShowBmp

 
 
	
; input dx filename to open
proc OpenBmpFile	near						 
	mov ah, 3Dh
	xor al, al
	int 21h
	jc @@ErrorAtOpen
	mov [FileHandle], ax
	jmp @@ExitProc
	
@@ErrorAtOpen:
	mov [ErrorFile],1
@@ExitProc:	
	ret
endp OpenBmpFile
 
 
 



proc CloseBmpFile near
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
	ret
endp CloseBmpFile




; Read 54 bytes the Header
proc ReadBmpHeader	near					
	push cx
	push dx
	
	mov ah,3fh
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	
	pop dx
	pop cx
	ret
endp ReadBmpHeader



proc ReadBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	push cx
	push dx
	
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	
	pop dx
	pop cx
	
	ret
endp ReadBmpPalette


; Will move out to screen memory the colors
; video ports are 3C8h for number of first color
; and 3C9h for all rest
proc CopyBmpPalette		near					
										
	push cx
	push dx
	
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0  ; black first							
	out dx,al ;3C8h
	inc dx	  ;3C9h
CopyNextColor:
	mov al,[si+2] 		; Red				
	shr al,2 			; divide by 4 Max (cos max is 63 and we have here max 255 ) (loosing color resolution).				
	out dx,al 						
	mov al,[si+1] 		; Green.				
	shr al,2            
	out dx,al 							
	mov al,[si] 		; Blue.				
	shr al,2            
	out dx,al 							
	add si,4 			; Point to next color.  (4 bytes for each color BGR + null)				
								
	loop CopyNextColor
	
	pop dx
	pop cx
	
	ret
endp CopyBmpPalette


 
 
proc DrawHorizontalLine	near
	push si
	push cx
DrawLine:
	cmp si,0
	jz ExitDrawLine	
	 
    mov ah,0ch	
	int 10h    ; put pixel
	 
	
	inc cx
	dec si
	jmp DrawLine
	
	
ExitDrawLine:
	pop cx
    pop si
	ret
endp DrawHorizontalLine



proc DrawVerticalLine	near
	push si
	push dx
 
DrawVertical:
	cmp si,0
	jz @@ExitDrawLine	
	 
    mov ah,0ch	
	int 10h    ; put pixel
	
	 
	
	inc dx
	dec si
	jmp DrawVertical
	
	
@@ExitDrawLine:
	pop dx
    pop si
	ret
endp DrawVerticalLine



; cx = col dx= row al = color si = height di = width 
proc Rect
	push cx
	push di
NextVerticalLine:	
	
	cmp di,0
	jz @@EndRect
	
	cmp si,0
	jz @@EndRect
	call DrawVerticalLine
	inc cx
	dec di
	jmp NextVerticalLine
	
	
@@EndRect:
	pop di
	pop cx
	ret
endp Rect








 
   
proc  SetGraphic
	mov ax,13h   ; 320 X 200 
				 ;Mode 13h is an IBM VGA BIOS mode. It is the specific standard 256-color mode 
	int 10h
	ret
endp 	SetGraphic

 

 
 
 


proc ShowBMP 
; BMP graphics are saved upside-down.
; Read the graphic line by line (BmpRowSize lines in VGA format),
; displaying the lines from bottom to top.
	push cx
	
	mov ax, 0A000h
	mov es, ax
	
	mov cx,[BmpRowSize]
	
 
	mov ax,[BmpColSize] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
	xor dx,dx
	mov si,4
	div si
	cmp dx,0
	mov bp,0
	jz @@row_ok
	mov bp,4
	sub bp,dx

@@row_ok:	
	mov dx,[BmpLeft]
	
@@NextLine:
	push cx
	push dx
	
	mov di,cx  ; Current Row at the small bmp (each time -1)
	add di,[BmpTop] ; add the Y on entire screen
	
 
	; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
	dec di
	mov cx,di
	shl cx,6
	shl di,8
	add di,cx
	add di,dx
	 
	; small Read one line
	mov ah,3fh
	mov cx,[BmpColSize]  
	add cx,bp  ; extra  bytes to each row must be divided by 4
	mov dx,offset ScrLine
	int 21h
	; Copy one line into video memory
	cld ; Clear direction flag, for movsb
	mov cx,[BmpColSize]  
	mov si,offset ScrLine
	rep movsb ; Copy line to the screen
	
	pop dx
	pop cx
	 
	loop @@NextLine
	
	pop cx
	ret
endp ShowBMP 
;=========================
;descruption:its print the tools 
;input:pudh color 
;Output:screan: 
;register used:none 
;=========================
TColor equ [bp+4]  
proc Tools 
     push bp 
	 mov bp,sp
     pusha  
	 call Black 
	 mov dx, offset FileName 
	 mov [BmpLeft],308 
	 mov [BmpTop],0
	 mov [BmpColSize], 10
	 mov [BmpRowSize] ,20
	 call OpenShowBmp
	 mov dx, offset FileName2
	 mov [BmpLeft],15
	 mov [BmpTop],0 
	 mov [BmpColSize],35 
	 mov [BmpRowSize] ,9  
	 call OpenShowBmp
	 mov ax,0A000h 
	 mov es,ax
	 mov dx,TColor  
	 push 4 
	 push 0 
	 push 20 
	 push 320 
	 call Row
	 push dx  
	 call PaintBrash 
	 call ColorG 
     call White
     popa 	 
	 pop bp 
	 ret 2 
	  
endp Tools
;========================
;description:paint the brash 
;input:color 
;outPut:Screen 
;register Used: None 
;======================== 
color2 equ [bp+4] 
proc PaintBrash 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov dx,Color2 
	 push dx 
	 push 2 
	 push 10 
	 push 10 
	 push 18 
	 call Cube 
	 push dx 
	 push 12 
	 push 11 
	 push 19 
	 push 18
	 call Cube 
	 push dx 
	 push 21 
	 push 12 
	 push 27 
	 push 18 
	 call Cube 
	 push dx 
	 push 29 
	 push 13 
	 push 34 
	 push 18 
	 call Cube 
	 push dx 
	 push 36 
	 push 14 
	 push 40 
	 push 18 
	 call Cube 
	 push dx 
	 push 42
	 push 15 
	 push 45
	 push 18 
	 call Cube 
	 push dx 
	 push 47
	 push 16 
	 push 49 
	 push 18
	 call Cube 
	 push 7 
	 push 5
	 push 2
	 push 15 
	 push 8 
	 call Cube 
	 push 255 
	 push 0 
	 push 2 
	 push 5 
	 push 8 
	 call Cube 
	 popa 
	 pop bp 
	 ret 2 
endp PaintBrash 
;========================
;description:this fabctuon paint squre 4 by 4 
;input push Color push SX and SY(look At desciption of proc..cube about SY) 
;outPut:screan 
;Registeed used:none 
;========================
color12 equ [bp+8] 
TYS equ [bp+4]
TXS equ [bp+6]  
proc Cube4 
	 push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,color12 
	 mov bx,TXS 
	 mov dx,TYS 
	 push ax 
	 push bx 
	 push dx 
	 add bx,4 
	 push bx 
	 add dx,4 
	 push dx 
	 call Cube 
	 popa 
	 pop bp 
	 ret 6 
endp Cube4 
;==========================
;descruption:print all color  
;input: none 
;OutPut:scren 
;registered Used:none 
;==========================
proc  ColorG 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,0 
	 mov bx,50 ;the x of start 
	 mov dx,4 ;the y 
	 mov cx,4 ;4 Line 
	 push cx 
	 mov cx,64 
	 jmp @@Back 
@@Back2: 
     mov bx,50
     push cx 
	 mov cx,64 
	 add dx,4 
@@Back: 
	 push ax 
	 push bx 
	 push dx 
	 call Cube4 
	 add ax,1 
	 add bx,4 
	 loop @@Back 
	 pop cx 
     loop @@Back2 
	 popa 
	 pop bp 
	 ret 
endp ColorG 
;============================
;description:this fanction paint the acrean on white 
;input:none 
;OutPut:screan 
;registered used:none 
;============================
proc White 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,20 ;the y
	 mov cx,180  
@@BAck2:  
     push cx 
     add ax,1 	
	 mov bx,0;the x 
	 mov cx,320 
@@Back: 
     push 255 
	 push bx 
	 push ax 
	 call Picsel 
	 add bx,1 
loop @@Back 
     pop cx 
loop @@BAck2
	 popa 
	 pop bp 
	 ret 
endp White 
;======================
;description:paint 20 First LIne in BAlack 
;input:none 
;outPut:acreen 
;Register Used:none 
;====================== 
proc Black 
     pusha  
	 mov ax,0 
	 mov cx,20 
@@BACk: 
	 push 0
	 push 0
	 push ax 
	 push 320 
	 call Row 
	 add ax,1 
	 loop @@BACk 
	 popa 
	 ret 
endp Black 
;=====================
;description:show the screan state after press finish 
;input:none 
;OutPut:screen 
;Register Used:none 
;===================== 
proc SCreanFinish 
     pusha 
	 call CopyTOData 
	 mov ax,2 
	 int 10h 
@@Again: 
	 mov dx,offset PrintF 
	 mov ah,9 
	 int 21h 
	 mov ah,1 
	 int 21h 
	 cmp al,'e' 
	 je @@Out1
	 cmp al,'E'
	 je @@Out1 
	 cmp al,'s' 
	 je @@SAve1
	 cmp al,'S' 
	 je @@Save1
	 cmp al,'c' 
	 je @@sav 
	 cmp al,'C' 
	 je @@sav 
	 jmp @@Again 
@@OUT1:
     jmp @@Out 
@@SAve1:
     jmp @@SAve 
@@sav1:
     jmp @@sav 
@@SAV:  
     push offset File2 
     call SaveFile 
	 mov ax,13h 
	 int 10h  
	 call SetSCrean 
	  call Black 
	 mov dx, offset FileName 
	 mov [BmpLeft],308 
	 mov [BmpTop],0
	 mov [BmpColSize], 10
	 mov [BmpRowSize] ,20
	 call OpenShowBmp
	 mov dx, offset FileName2
	 mov [BmpLeft],15
	 mov [BmpTop],0 
	 mov [BmpColSize],35 
	 mov [BmpRowSize] ,9  
	 call OpenShowBmp
	 mov ax,0A000h 
	 mov es,ax
 mov bx ,offset Color1 
	 mov [byte ptr bx],dl
	 mov dh,0 
	 push 4 
	 push 0 
	 push 20 
	 push 320 
	 call Row
	 push dx  
	 call PaintBrash 
	 call ColorG 
	 mov bx,offset SCreens 
	 mov [byte ptr bx],0 
	 mov bx,offset SCreens 
	 mov [byte ptr bx],0 
	 mov dx, offset FileName
	 mov [BmpLeft],15
	 mov [BmpTop],0 
	 mov [BmpColSize],35 
	 mov [BmpRowSize] ,9  
	 call OpenShowBmp
	  mov dx, offset FileName2
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
	 mov ax,1 
	 int 33h 	 
@@BAck11:
     call CheckMouse
     push 0 	 
     call MouseClick2 
	 pop ax 
	 cmp ax,1 
	 je @@continue1 
	 jmp @@ShowMouse1 
@@continue1: 
     call MouseClickQ 
	 call MouseClickB 
     call HideMouse ;hide cursor just if his y litele than 20
     call PrintOnCursor 
	 call GetColor 
	 call BrashMouse
	 call CheckDeletor
	 call CheckFinish 	 
	; check if mouse isnt press if it is the mouse will show again 
	 jmp @@End2 
@@ShowMouse1: 
     mov ax,1 
	 int 33h 
@@END2: 
    jmp @@Back11 
	 jmp @@Finish 
@@Out: 
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
@@SAve:
     push offset  File2 
	 call FinishSave 
     call SaveFile 
	 mov ax,13h 
	 int 10h  
	 call SetSCrean 
	  call Black 
	 mov dx, offset FileName 
	 mov [BmpLeft],308 
	 mov [BmpTop],0
	 mov [BmpColSize], 10
	 mov [BmpRowSize] ,20
	 call OpenShowBmp
	 mov dx, offset FileName2
	 mov [BmpLeft],15
	 mov [BmpTop],0 
	 mov [BmpColSize],35 
	 mov [BmpRowSize] ,9  
	 call OpenShowBmp
	 mov ax,0A000h 
	 mov es,ax
 mov bx ,offset Color1 
	 mov [byte ptr bx],dl
	 mov dh,0 
	 push 4 
	 push 0 
	 push 20 
	 push 320 
	 call Row
	 push dx  
	 call PaintBrash 
	 call ColorG 
	 mov bx,offset SCreens 
	 mov [byte ptr bx],0 
	 mov bx,offset SCreens 
	 mov [byte ptr bx],0 
	 mov dx, offset FileName
	 mov [BmpLeft],15
	 mov [BmpTop],0 
	 mov [BmpColSize],35 
	 mov [BmpRowSize] ,9  
	 call OpenShowBmp
	  mov dx, offset FileName2
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
	 mov ax,1 
	 int 33h 	 
@@BAck1:
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
	; check if mouse isnt press if it is the mouse will show again 
	 jmp @@End1 
@@ShowMouse: 
     mov ax,1 
	 int 33h 
@@END1: 
    jmp @@Back1 
@@Finish: 
	 popa 
	 ret 
endp SCreanFinish 
;==========================
;description:show start screan 
;input:none 
;OutPut:screan 
;Register used:none 
;==========================
proc StartSC 
     pusha 
	 mov dx, offset BlueB 
	 mov [BmpLeft],0
	 mov [BmpTop],0 
	 mov [BmpColSize],320 
	 mov [BmpRowSize] ,200 
	 call OpenShowBmp
	 mov dx, offset Filenew 
	 mov [BmpLeft],70 
	 mov [BmpTop],2 
	 mov [BmpColSize],170 
	 mov [BmpRowSize] ,45 
	 call OpenShowBmp
	 mov dx,offset FileOpen 
	 mov [BmpLeft],70
	 mov [BmpTop],49 
	 mov [BmpColSize],170 
	 mov [BmpRowSize] ,45 
	 call OpenShowBmp
	  mov dx,offset FileExit  
	 mov [BmpLeft],70
	 mov [BmpTop],96 
	 mov [BmpColSize],170 
	 mov [BmpRowSize] ,45 
	 call OpenShowBmp
	  mov dx,offset FileHow   
	 mov [BmpLeft],70
	 mov [BmpTop],143 
	 mov [BmpColSize],170 
	 mov [BmpRowSize] ,45 
	 call OpenShowBmp
	 mov bx,offset SCreens 
	 mov [byte ptr bx],2 
	 popa 
	 ret 
endp StartSC 
;================================
;descruiption:loop of opening file 
;input:none 
;OutPut:screan 
;REgister USed:none 
;================================ 
proc OpenExsist
pusha 
     mov bx,offset screens 
	 mov [byte ptr bx],0 
     call FinishSAve  
	 mov ax,13h 
	 int 33h 
	 mov ax,2 
	 int 33h 
	 mov dx, offset File2 
	 mov [BmpLeft],0 
	 mov [BmpTop],21 
	 mov [BmpColSize], 320 
	 mov [BmpRowSize] ,179 
	 call OpenShowBmp
	  call Black 
	 mov dx, offset FileName 
	 mov [BmpLeft],308 
	 mov [BmpTop],0
	 mov [BmpColSize], 10
	 mov [BmpRowSize] ,20
	 call OpenShowBmp
	 mov dx, offset FileName2
	 mov [BmpLeft],15
	 mov [BmpTop],0 
	 mov [BmpColSize],35 
	 mov [BmpRowSize] ,9  
	 call OpenShowBmp
	 mov ax,0A000h 
	 mov es,ax
	 mov bx,offset color1 
	 mov dl,[bx] 
	 mov dh,0 
	 push 4 
	 push 0 
	 push 20 
	 push 320 
	 call Row
	 push dx  
	 call PaintBrash 
	 call ColorG
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
	 call CheckBS
	; check if mouse isnt press if it is the mouse will show again 
	 jmp @@End1 
@@ShowMouse: 
     mov ax,1 
	 int 33h 
@@END1: 
    jmp @@Back 	 
popa 
ret 
endp openExsist 