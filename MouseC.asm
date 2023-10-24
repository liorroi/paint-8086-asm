;============================
;description:push someting this fanction back the resul on stack 
;input:push simething 
;output:stack just pop it
;registered Used:None 
;============================
return equ [bp+4] 
proc MOuseClick2
	 push bp
	 mov bp,sp 
	 pusha 
	 mov ax,3 
	 int 33h 
	 and bx,1 
	 mov return,bx 
	 popa
	 pop bp 
	 ret 
endp MOuseClick2 
;=========================
;description:check if mouse position in the Quaition MArk 
;if the mouse position is in it it return Screan picture 
;input:none 
;Output:on Stack you just nead to pop it 
;Register used:none
;========================= 
proc MOuseClickQ 
	 push bp
	 mov bp,sp 
	 pusha 
	 mov bx,offset ScreenS  
	 cmp [byte ptr bx],0 
	 je @@DO 
	 jmp @@Finish 
@@Do: 
	 mov ax,3 
	 int 33h 
	 shr cx,1 
	 cmp dx, 20 
	 jbe @@Check2 
	 jmp @@Put0 
@@Check2:
     cmp cx,308 
	 jae @@PUT1 
	 jmp @@Put0 
@@PUt1: 
     call CopyTOData
     call ?Mark
	 mov bx,offset ScreenS  
	 mov [byte ptr bx],1
@@PUT0: 

@@Finish: 
	 popa
	 pop bp 
	 ret 
endp MOuseClickQ 
;=============================
;description:check if mouse position on back 
;input:none 
;OutPut:screan 
;register used:none 
;=============================
proc MouseClickB 
     push bp
	 mov bp,sp 
	 pusha 
	 mov bx,offset ScreenS  
	 cmp [byte ptr bx],1 
	 je @@DO 
	 jmp @@Finish 
@@Do: 
	 mov ax,3 
	 int 33h 
	 shr cx,1 
	 cmp dx,160 
	 jae @@Check2 
	 jmp @@Put0 
@@Check2:
     cmp cx,40 
	 jbe @@PUT1 
	 jmp @@Put0 
@@PUt1:  
     mov ax,0 
	 int 33h 
	 call SetScrean
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
	 mov bx,offset Color1 
	 mov dl,[bx] 
	 mov dh,[bx] 
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
	 call CheckMouse 
	 mov bx,offset ScreenS  
	 mov [byte ptr bx],0  
@@PUT0: 
    
@@Finish: 
	 popa
	 pop bp 
	 ret 
endp MouseClickB 
;===========================
;description:Check if mouse  on squre 
;input:push first sopush SX1 than SY1 than XE1 than YE1 
;OutPut:screan 
;register Used:none 
;=========================== 
SX1 equ [word ptr bp+10] 
SY1 equ [word ptr bp+8] 
XE1 equ [word ptr bp+6] 
YE1 equ [word ptr bp+4] 
proc CheckMSqure  
	 push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,3 
	 int 33h 
	 shr cx,1 
	 cmp cx,SX1 
	 jae @@Check1 
	 jmp @@finish 
@@Check1: 
     cmp cx,XE1 
	 jbe @@Check2 
	 jmp @@Finish 
@@Check2: 
     cmp dx,SY1 
	 jae @@Check3
     jmp @@Put0  
	 
@@Check3: 
     cmp dx,YE1 
	 jbe @@Put1 
	 jmp @@Finish 	 
@@Put1: 
     mov SX1,1
	 jmp @@Finish 
@@PUT0: 
     mov SX1,0 
@@Finish: 
	 popa 
	 pop bp 
	 ret 6 
endp CheckMSqure 
;======================================
;description:check if mouse in Brash 
;the bigest one is 2 the Last is 8 
;its BAck Number accord to Size 
;Input:Push Something to check it  
;OutPut:Number betwean 1 to 8 
;just pop it 
;Register Used:none 
;======================================
proc BrashMouse 
     push bp
	 mov bp,sp 
	 pusha  
	 mov bx,offset ScreenS 
	 cmp [byte ptr bx],0 
	 je @@Next 
	 jmp @@Finish 
@@Next: 
	 push 0 
	 push 0 
	 push 60 
	 push 25 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1  
	 je @@Continue 
	 jmp @@Finish
@@Continue: 
     mov bx,offset Screens 
	 cmp [byte ptr bx],0 
	 je @@Continue2 
	 jmp @@Finish 
@@Continue2: 
;check if the Mouse Position in the 8 by 8 squre 
     push 2 
	 push 10 
	 push 10 
	 push 18 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@PUT8 
	 push 12 
	 push 11 
	 push 19 
	 push 18 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@PUT7
	 push 21 
	 push 12 
	 push 27 
	 push 18 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@PUT6
	 push 29 
	 push 13 
	 push 34 
	 push 18 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@PUT5 
	 push 36 
	 push 14
	 push 40 
	 push 18 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@PUT4 
	 push 42 
	 push 15 
	 push 45 
	 push 18 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@PUT3 
	 push 47 
	 push 16
	 push 49 
	 push 18     
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@PUT2 
	 jmp @@Finish 
@@Put8: 
     mov bx,offset MouseG 
	 mov [byte ptr bx],8 
	 call BrashSound
	 jmp @@Finish 
@@Put5: 
     mov bx,offset MouseG 
	 mov [byte ptr bx],5
	 	 call BrashSound
	 jmp @@Finish 
@@Put6: 
     mov bx,offset MouseG 
	 mov [byte ptr bx],6
	 	 call BrashSound
	 jmp @@Finish 
@@Put7: 
     mov bx,offset MouseG 
	 mov [byte ptr bx],7
	 	 call BrashSound
	 jmp @@Finish 
@@Put2: 
     mov bx,offset MouseG 
	 mov [byte ptr bx],2 
	 	 call BrashSound
	 jmp @@Finish 
@@Put3: 
     mov bx,offset MouseG 
	 mov [byte ptr bx],3
	 	 call BrashSound
	 jmp @@Finish 
@@Put4: 
     mov bx,offset MouseG 
	 mov [byte ptr bx],4
	 	 call BrashSound
	 jmp @@Finish 
@@Finish: 
	 popa 
	 pop bp 
	 ret 
endp BrashMouse 
;===========================
;description:calculate the Number of color mouse position 
;is pn it  
;input:none 
;Output:it back the result on Byte in DASG call Color 
;reistered used:none 
;===========================
proc GetColor  
     push bp 
	 mov bp,sp 
	 pusha 
	 push 50 
	 push 4 
	 push 306  
	 push 19 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@Continue 
	 jmp @@Finish 
@@Continue: 
     mov bx,offset screens 
	 mov al,[bx] 
	 cmp al,0 
	 je @@Continue1 
     jmp @@Finish 
@@Continue1: 
     mov ax,3 
	 int 33h 
	 mov bx,offset Deletor 
	 mov [byte ptr bx],0 
	 shr cx,1 
	 shr dx,2 
	 sub dx,1 
	 sub cx,50  
	 shr cx,2 ;divided by 64 
	 shl dx,6;mul by 64 
	 add dx,cx 
	 mov bx ,offset Color1 
	 mov [byte ptr bx],dl
	 mov dh,0 
	 mov ax,0A000h 
	 mov es,ax
	 cmp dx,0 
	 je @@Finish 
	 push dx 
	 call PaintBrash 
	 call colorsound 
@@FINish: 
	 popa 
	 pop bp 
	 ret 
endp GetColor 
;=========================
;description:when mouse y is litele than 20 this fanction Hise the mouse 
;input:none 
;OutPut:mouseCurssor 
;Registered Used:none 
;=========================
proc HideMouse 
     pusha 
	 mov ax,3 
	 int 33h 
	 cmp dx,20 
	 jae @@Hide 
	 jmp @@Show  
@@Hide: 
     mov bx,offset screens 
	 cmp [byte ptr bx],0 
	 je @@Continue 
	 jmp @@Finish 
@@Continue: 
     mov ax,2 
	 int 33h 
	 jmp @@Finish 
@@Show: 
     mov ax,1 
	 int 33h 
@@Finish: 
	 popa 
	 ret 
endp HideMouse 
;=========================
;description:prinr onmouse From zugi  
;input:none 
;OutPut:screen 
;Register used:none 
;========================= 
proc PrintOnCursorZ 
     push bp 
	 mov bp,sp 
     pusha 
	 mov ax,3 
	 int 33h 
	 cmp dx,20 
	 jae @@Continue 
	 jmp @@Finish 
@@Continue: 
	  mov ax,0A000h 
	 mov es,ax 	 
	 mov bx,offset Color1 
     mov al,[bx] 
	 mov bx,offset deletor 
	 cmp [byte ptr bx],1 
	 je @@Del 
	 jmp @@Continue1 
@@del: 
     mov al,255 
@@Continue1: 
     mov ah,0 
     push ax 	 
	 mov bx,offset MouseG 
	 mov al,[bx]
     mov ah,0 	 
	 mov ax,3 
	 int 33h 
	 shr cx,1 
	 mov bx,offset MouseG 
	 mov al,[bx]
	 shr ax,1 
	 sub cx,ax
	 sub dx,ax 
	 push cx 
	 push dx 
	 mov bx,offset MouseG  
     mov al,[bx] 
     mov ah,0 
	 add cx,ax 
	 add dx,ax 
	 push cx 
	 push dx 
	 call Cube1 
@@Finish: 
	 popa 
	 pop bp 
	 ret 
endp PrintOnCursorZ 
;=========================
;description:prinr on mouse for ea zugi  
;input:none 
;OutPut:screen 
;Register used:none 
;========================= 
proc PrintOnCursorE 
     push bp 
	 mov bp,sp 
     pusha 
	 mov ax,3 
	 int 33h 
	 cmp dx,20 
	 jae @@Continue 
	 jmp @@Finish 
@@Continue: 
	  mov ax,0A000h 
	 mov es,ax 	 
	 mov bx,offset Color1 
     mov al,[bx] 
	 mov bx,offset deletor 
	 cmp [byte ptr bx],1 
	 je @@Del 
	 jmp @@Continue1 
@@del: 
     mov al,255 
@@Continue1: 
     mov ah,0 
     push ax 	 
	 mov bx,offset MouseG 
	 mov al,[bx]
     mov ah,0 	 
	 mov ax,3 
	 int 33h 
	 shr cx,1 
	 mov bx,offset MouseG 
	 mov al,[bx]
	 shr ax,1 
	 sub cx,ax
	 sub dx,ax 
	 sub cx,1 
	 push cx 
	 push dx 
	 mov bx,offset MouseG  
     mov al,[bx] 
     mov ah,0 
	 add cx,ax 
	 add dx,ax 
	 push cx 
	 push dx 
	 call Cube1 
@@Finish: 
	 popa 
	 pop bp 
	 ret 
endp PrintOnCursorE 
;=========================
;description:prinr on mouse 
;input:none 
;OutPut:screen 
;Register used:none 
;========================= 
proc PrintOnCursor
     pusha 
	 mov bx,offset screens 
	 cmp [byte ptr bx],0 
	 je @@Continue 
	 jmp @@Finish 
@@Continue:      
     mov bx,offset MouseG 
	 mov al,[bx] 
	 mov ah,0  
	 mov bl,2 
	 div bl 
	 ;check if it zugi ot eazugi 
	 cmp ah,0 
	 je Zugi 
	 jmp EAZugi 
Zugi: 
     call PrintOnCursorZ 
	 jmp @@Finish 
eaZugi: 
     call PrintOnCursorE 
@@Finish: 
     popa 
	 ret 
endp PrintOnCursor
;=====================
;description:check if you tach on deletor if you tach it made it 
;input:none 
;OutPut:put Number 255 on Byte in DASG call Color1 
;Register Used:none 
;===================== 
proc CheckDeletor 
     pusha  
	 mov BX,OFFSET screens 
	 mov al,[bx] 
	 cmp al,1 
	 je @@FInish 
	 
@@cONTINUE: 
	 push 0 
	 push 2 
	 push 14 
	 push 8 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 jne @@Finish 
@Put255: 
     mov bx,offset deletor 
	 mov [byte ptr bx],1 
	 call deletorSound
@@Finish: 
	 popa 
	 ret 
endp CheckDeletor 
;=========================
;description:check if mouse position in Finish 
;if it is call to screanFinish
;input:none 
;OutPut:screan
;Register used:none 
;========================= 
proc CheckFinish 
     pusha 
	 mov bx ,offset screenS 
	 cmp [byte ptr bx],0 
	 je @@Do1 
	 jmp @@Finish 
@@DO1: 
	 push 15 
	 push 0 
	 push 49 
	 push 9 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@Do 
	 jmp @@Finish 
@@Do: 
     call CopyTOData  
     call SCreanFinish 
	 call Setscrean 
	 @@BAck1:
	 jmp @@BAck1  
@@Finish: 
	 popa 
	 ret 
endp CheckFinish 
;=========================
;description:check where the mouse ont screanS 2  
;Input:none 
;OutPut:screan 
;Register USed:none 
;=====================
proc CheckStart 
     pusha 
	 mov bx,offset ScreenS 
	 cmp [byte ptr bx],2 
	 je @@Continue 
	 jmp @@Finish 
	 mov ax,1 
	 int 33h 
@@Continue: 
     push 70 
	 push 2
	 push 240 
	 push 47 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@New 
	 push 70 
	 push 49 
	 push 240 
	 push 94 
	 call CheckMSqure
	 pop ax 
	 cmp ax,1 
	 je @@open 
	 push 70 
	 push 96 
	 push 240 
	 push 141 
	 call CheckMSqure 
	 pop ax 
	 cmp ax,1 
	 je @@Exit  
	 push 70 
	 push 143 
	 push 240 
	 push 178 
	 call CheckMsqure 
	 pop ax 
	 cmp ax,1 
	 je @@How 
	 jmp @@Finish 
@@HOW: 
     call ?mark 
	 mov bx,offset screens 
	 mov [byte ptr bx],1
	 
	 jmp @@FInish
@@new: 
     mov ax,0 
	 int 33h 
     call createFile 
     jmp @@Finish 	 
@@Open:  
     call OpenExsist
	 jmp @@Finish 
@@Exit: 
     call LastSound 
	 mov ax,12h 
	 int 10h 
     jmp Exit 
	 jmp @@Finish 
@@Finish:
	 popa 
	 ret 
endp CheckStart 
;==============================
;description:check if back press if it press it back to start position
;input:none 
;OutPut:screan 
;Register Used:none 
;==============================
proc checkBS
     pusha 
     mov bx,offset ScreenS  
	 cmp [byte ptr bx],1 
	 je @@DO 
	 jmp @@Finish 
@@Do: 
	 mov ax,3 
	 int 33h 
	 shr cx,1 
	 cmp dx,160 
	 jae @@Check2 
	 jmp @@Put0 
@@Check2:
     cmp cx,40 
	 jbe @@PUT1 
	 jmp @@Put0 
@@PUt1:  
	 mov ax,0  
	 int 33h 
	 mov ax,2
	 int 33h 
	 call StartSC 
	 mov ax,1 
	 int 33h 
	 mov bx,offset ScreenS  
	 mov [byte ptr bx],2 
@@PUT0: 
    
@@Finish: 
	 popa 
	 ret 
endp CheckBS
