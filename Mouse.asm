;to read informaition about the hot spots and grafic cursor
;tach here c://tasm//Mouse.txt
;to sea just how to use them tach here c://tasm//MouseHelp.txt
;---------------------------
; Procudures area
;---------------------------
;===========================
;description:this fanction get array on Dasg and put him on mouse Grafic Cursor 
;input:starting of array in DASG 
;outPut:Grafic cursor 
;registered Used:none 
;===========================
StartMask equ [bp+4] 
proc setGraficM
	 push bp 
	 mov bp,sp 
	 pusha
	 mov ax,9h
	 push ds 
	 pop es
	 mov bx,8 
	 mov cx,8
	 mov dx,StartMask 
	 int 33h 
	 popa 
	 pop bp 
	 ret 2 
endp setGraficM
;===========================
;description:this fanction get number on Dasg and put him on mouse Grafic Cursor;betwean 1-8  
;input:starting of array in DASG 
;outPut:Grafic cursor 
;registered Used:none 
;===========================
num equ [bp+4] 
proc SetGraficCube 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,num 
	 cmp ax,2
	 je @@w2
	 cmp ax,3
	 je @@w3
	 cmp ax,4 
	 je @@w4
	 cmp ax,5 
	 je @@w5
	 cmp ax,6 
	 je @@w6
	 cmp ax,7 
	 je @@w7
	 cmp ax,8 
	 je @@w8
 
@@w2: 
     push offset cursor2
	 call setGraficM 
	 jmp @@Finish 
@@w3: 
     push offset cursor3
	 call setGraficM 
	 jmp @@Finish 
@@w4: 
     push offset cursor4
	 call setGraficM 
	 jmp @@Finish 
@@w5: 
     push offset cursor5
	 call setGraficM 
	 jmp @@Finish 
@@w6: 
     push offset cursor6
	 call setGraficM 
	 jmp @@Finish 
@@w7: 
     push offset cursor7
	 call setGraficM 
	 jmp @@Finish 
@@w8: 
     push offset cursor8 
	 call setGraficM 
	 jmp @@Finish 
@@Finish: 
	 popa 
	 pop bp 
	 ret 2 
endp SetGraficCube 
;=============================
;description:chnge the mouse Grfic cursor accord to 
;Byte in DAsg call MouseG 
;if if this Number equl to 10 its mean the rgular mouse Grafic 
;input:none 
;outPut:screan 
;reister used:none 
;=============================
proc MouseGM ;mouse grafic-memory 
     pusha 
	 mov bx,offset MouseG 
	 mov al,[bx] 
	 cmp al,10 
	 je RegularMouse
     mov ah,0 	 
	 push ax 
	 call SetGraficCube 
	 jmp @@FInish 
RegularMouse: 
     mov ax,0 
	 int 33h 
     mov ax,1
	 int 33h 
@@Finish: 
	 popa 
	 ret 
endp MouseGM
;==============================
;decsription:if mouse arrive less than 25 on y it change him to regylar one 
;input:none 
;OutPut:mouse 
;Register used:none 
;==============================
proc CheckMOuse
     pusha  
	 mov bx,offset ScreenS  
	 cmp [byte ptr bx],0 
	 je @@DO 
	 jmp @@Finish 
@@Do1: 
     push 0 
	 call MouseClick2 
	 pop ax 
	 cmp ax,1 
	 jne @@Do 
	 jmp @@Finish 
@@Do: 
	 mov ax,3 
	 int 33h 
	 cmp dx,20 
	 jg @@Check3 	 
	 jmp @@CHeck1 
@@Check3: 
     mov bx,offset Mouseg1 
     cmp [byte ptr bx],1 
     je @@PUT1 
     jmp @@Finish 	 
@@Check1: 
     mov bx,offset mous 
	 cmp [byte ptr bx],1 
	 je @@Check2 
	 jmp @@Finish 
@@Check2: 
     mov [byte ptr bx],0 
     mov bx,offset Mouseg1              
	 mov [byte ptr bx],1 
	 mov ax,3 
	 int 33h 
     mov ax,0 
	 int 33h 
	 mov ax,4 
	 int 33h 
	 mov ax,1 
	 int 33h 
	 jmp @@Finish 
@@Put1: 
     mov bx,offset Mous 
	 mov [byte ptr bx],1 
	 mov bx,offset Mouseg1 
	 mov [byte ptr bx],0 
     call MouseGM 
	 jmp @@Finish 
@@Hide: 
     mov ax,2 
	 int 33h 
@@Finish: 
	 popa 
	 ret 
endp CheckMouse 
