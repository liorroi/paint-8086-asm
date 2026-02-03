;============================
;description:create bmp File that include your paint 
;input:push the  name of file 
;OutPut:create a new bmp File 
;Register used:none 
;============================
proc saveFile 
     push bp 
	 mov bp,sp 
      pusha 
	  mov ax,57280   
	  push [bp+4] 
	  call StartFile
      pop bx  	  
	  mov cx,179 
@@BAck: 
	  push ax 
	  call CopyLineToData 
	  push bx 
	  call CopyLine 
	  sub ax,320
     loop @@BAck 
	 mov ah,03eh 
	 int 21h 
	  pop bp 
	  popa 
	  ret 2 
endp SaveFile 
;=============================
;description:open File for read and write
;input Push offset of path of file 
;it have to end with 0 
;OutPut:its back the Handle on Stack 
;register used:none 
;=============================
File equ [bp+4] 
proc openFile 
      push bp 
	  mov bp,sp 
      pusha 
	  mov ah,03dh 
	  mov al,2 
	  mov dx,File 
	  int 21h 
	  mov File,ax 
	  popa 
	  pop bp 
	  ret  
endp OpenFile 
;=========================
;description:close File 
;input:push the Hand;e of the File 
;OutPut:none 
;Register Used:none 
;==========================
proc CloseFile 
     push bp 
	 mov bp,sp 
     pusha 
	 mov ah,03Eh 
	 mov bx,File 
	 int 21h 
	 popa 
	 pop bp 
	 ret 2 
endp CloseFile 
;========================= 
;description:read bytes From File
;Input:push Number of byte to read 
;than place on DASG to put it 
;than push the HAndle 
;OutPut:int araay in DASG 
;Register Used:none 
;=========================
DAsg equ [bp+6] 
Read equ [bp+8] 
proc readFile 
      push bp 
	  mov bp,sp 
	  pusha 
	  mov ah,03fh 
	  mov bx,File 
	  mov cx,Read 
	  mov dx,DAsg 
	  int 21h 
	  popa 
	  pop bp 
	  ret 6 
endp readFile 
;=============================
;description:write TO file 
;input: push Numer of Byte To Write 
;push place On DASg to write 
;push push the HAndle 
;OutPut:none 
;Register Used:none 
;==============================
proc WriteFile 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ah,40h 
	 mov bx,File 
	 mov cx,Read 
	 mov dx,DASG 
	 int 21h 
	 popa 
	 pop bp 
	 ret 6 
endp WriteFile 
;===========================
;description:create file 
;input:push the offset of File path 
;output:HAndle on the Stack   
;Regiter Used:none 
;=========================== 
proc CreateFile1 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ah,03ch 
	 mov cx,5 
	 mov dx,File 
	 int 21h 
	 mov File,ax 
	 popa 
	 pop bp 
	 ret  
endp CreateFile1 
;to use that have to create a array in DASG call CopyFrom consist  
;the word "E.bmp",0 
;array of 1078 Byte call StartDAta  
;=============================
;description:Create File ant Write TO him the Start of File 
;Input:push file Name 
;OutPut: HAnde on stack 
;Reguster Used:none 
;============================= 
proc StartFile 
     push bp 
	 mov bp,sp 
	 pusha 
	 push offset CopyFrom 
	 call OpenFile 
	 pop ax 
	 push 1078 
	 push offset StartDAta 
	 push ax 
	 call readFile 
	 push ax 
	 call CloseFile 
	 push file 
	 call CreateFile1 
	 pop ax 
	 push 1078 
	 push offset StartData    
	 push ax 
	 call WriteFile 
	 mov File,ax 
	 popa 
	 pop bp 
	 ret 
endp StartFile 
;==========================
;description:copy 1 Line To File From DASG call LineCopy 
;input:push HAndle  
;OutPut:array in DASg call LineCopy  
;Register Used:none 
;===========================
proc Copyline  
     push bp 
	 mov bp,sp 
	 pusha 
	 push 320 
	 push offset LineCopy 
	 push File 
	 call WriteFile 
	 popa 
	 pop bp 
	 ret 2 
endp CopyLine
;=============================
;description:copy the screan to array in dASG call SAveSCreen 
;input:none 
;OutPut:array in DASG call SAvescrean
;Register USed :None 
;=============================
proc CopyTODAta 
     pusha 
	 mov ax,2 
	 int 33h 
	 mov bx,offset SAvescrean 
	 mov cx,57600 
	 mov ax,6400 
@@BAck: 
     push ax 
	 push bx 
	 call CopyPicsel 
	 add ax,1 
	 add bx,1 
	 loop @@BACk 
	 popa 
	 ret 
endp CopyTOData 
;==============================
;description:copy picsel 
;input:push place of picsl than push place to put him 
;OutPut:Byte in DASG 
;Register Used:none 
;==============================
P equ [bp+6]
D equ [bp+4] 
proc CopyPicsel 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,0A000h 
	 mov es,ax 
	 mov bx,P 
	 mov al,[es:bx] 
	 mov bx,D 
	 mov [bx],al 
	 popa 
	 pop bp 
	 ret 4 
endp CopyPicsel  
;========================
;dcription:put 1 picsel from array call Savescrean to Screan 
;input:place of picsel 
;push place to take from 
;OutPut:screen 
;Register Used:none 
;========================
proc SetPicsel 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov ax,0A000h 
	 mov es,ax 
	 mov bx,D 
	 mov al,[ds:bx] 
	 mov bx,p 
	 mov [es:bx],al 
	 popa 
	 pop bp 
	 ret 4 
endp SetPicsel
;=========================
;description:set the screan 
;Input:none 
;OutPut:screan 
;Register Used:none 
;========================
proc SetSCrean 
   pusha 
	 mov bx,offset SAvescrean 
	 mov cx,57600 
	 mov ax,6400 
@@BAck: 
     push ax 
	 push bx 
	 call SetPicsel  
	 add ax,1 
	 add bx,1 
	 loop @@BACk 
	 popa 
	 ret 
endp SetScrean 
;=======================
;description:copy 1 Line  from array in DASG call SAvescrean to array in 
;DASG call LineCopy 
;Input first Byte in array 
;OutPut:array in DASG call LineCopy 
;Register Used:none 
;======================= 
proc CopyLineTOData  
     push bp 
	 mov bp,sp 
	 pusha
     mov cx,320      
	 mov bx,offset LineCopy 
	 mov si,offset SAveScrean 
	 add si,[bp+4] 
@@BAck: 
	 mov al,[si] 
	 mov [bx],al 
     add si,1 
	 add bx,1 
	 loop @@BAck 
	 popa 
	 pop bp 
	 ret 2 
endp CopyLineToData 
;============================
;description:Write message and get what you write 
;input:none 
;OutPut:screen ,Byte in DASg call File2 
;Register USed:none 
;============================ 
proc FinishSAve 
     pusha 
	 push 0 
	 call GEtPAth 
	 pop ax
	 mov bx,offset File2 
	 add bx,ax 
	 push bx  
	 call SetbmpEnd
	 popa 
	 ret 
endp FinishSave 
;========================
;description:write message to screen 
;and get what wroten it back on stack rhe count of byte you write 
;input:push something 
;OutPut:on stack and Byte in DASg call 
;Register Used:none 
;========================= 
proc GetPAth 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov dx,offset NAmeMassage 
	 mov ah,9 
	 int 21h 
	 mov bx,offset FileName5 
	 mov [byte ptr bx],101  
	 mov dx,offset FileNAme5 
	 mov ah,0ah 
	 int 21h 
	 mov al,[bx+1] 
	 mov [bp+4],al  
	 mov cl,al 
	 mov ch,0 
	 mov si,offset File2 
	 mov bx,offset FileNAme5 
	 add bx,2 
@@BAck: 
     mov al,[byte ptr bx] 
	 mov  [si],al 
	 add si,1 
	 add bx,1 
	 loop @@BACk 
	 popa 
	 pop bp 
	 ret 
endp GetPath 
;=========================
;decription:put on DASG the word .bmp0
;Input:start Byte On DAsg  
;OutPut:DASg 
;Reguister Used:none 
;========================= 
proc SetbmpEnd 
     push bp 
	 mov bp,sp 
	 pusha 
	 mov bx,[bp+4] 
	 mov [Byte ptr bx],'.' 
	 mov [Byte ptr bx+1],'b' 
	 mov [Byte ptr bx+2],'m' 
	 mov [Byte ptr bx+3],'p' 
	 mov [Byte ptr bx+4],0  
	 popa 
	 pop bp 
	 ret 2 
endp SetbmpEnd
;==================== 
;decriptin:save File 
;Input:push something 
;Oytput:saveFile 
;Register USed:None 
;====================  
proc SAve 
     pusha 
	 push offset File2 
	 call saveFile  
	 popa 
	 ret 
endp SAve 
