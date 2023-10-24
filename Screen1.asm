;SCrean1-screan after start 
;=============================
;descruptin:print the screen after you tach on Quaition MArk 
;input:none 
;OutPut:Screen 
;register used:none 
;============================= 
proc ?Mark 
     pusha 
	 mov ax,0 
	 int 33h 
	 mov ax,0A000h 
	 mov es,ax 
	 mov dx, offset FileName1
	 mov [BmpLeft],0 
	 mov [BmpTop],0
	 mov [BmpColSize], 320 
	 mov [BmpRowSize] ,200 
	 call OpenShowBmp
	 mov ax,1 
	 int 33h 
	 popa 
	 ret 
endp ?Mark  
;=========================
;description:print the start screan and wain 3 secend 
;Input:none 
;OutPut:screen 
;Register USed:none 
;=========================
proc starting  
     pusha 
	  mov dx, offset File10 
	 mov [BmpLeft],0 
	 mov [BmpTop],0
	 mov [BmpColSize], 320 
	 mov [BmpRowSize] ,200 
	 call OpenShowBmp
	 call startSound 
	 	 mov ax, 40h
     

	 popa 
     ret 
endp starting 
