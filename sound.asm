;====================
;description:craete the start sound 
;input:none 
;Output:sound 
;Register Used:none 
;====================
proc startSound 
     pusha 
     in al,61h 
	 or al,00000011b
     out 61h,al 
     mov al,0b6h 
	 out 43h,al  
	 mov al,50
	 out 42h,al
	 mov al,50 
	 out 42h,al 
	 
	      mov cx,10000
@@Again1: 
     push cx 
	      mov cx,100 
@@Again: 
     loop @@again 
	 pop cx 
	 loop @@Again1 
 mov al,55 
	 out 42h,al
	 mov al,30 
	 out 42h,al 
	 
	      mov cx,10000
@@Again11: 
     push cx 
	      mov cx,100 
@@Again111: 
     loop @@again111
	 pop cx 
	 loop @@Again11 
mov al,55 
	 out 42h,al
	 mov al,20  
	 out 42h,al 
	 
	      mov cx,10000
@@Again1111: 
     push cx 
	      mov cx,100 
@@Again11111: 
     loop @@again11111
	 pop cx 
	 loop @@Again1111 	 
     in al,61h 
	 and al,11111100b 
	 out 61h,al 
@@Finish: 
	 popa 
	 ret 
endp startSound 
;===================
;description:create the sound of the end 
;input:none 
;OutPut:sound 
;Register Used:none 
;=================== 
proc lastsound 
     pusha 
	 in al,61h 
	 or al,00000011b
     out 61h,al 
     mov al,0b6h 
	 out 43h,al  
	 mov al,55 
	 out 42h,al
	 mov al,20  
	 out 42h,al 
	 
	      mov cx,10000
@@Again1111: 
     push cx 
	      mov cx,100 
@@Again11111: 
     loop @@again11111
	 pop cx 
	 loop @@Again1111 
	  mov al,55 
	 out 42h,al
	 mov al,30 
	 out 42h,al 
	 
	      mov cx,10000
@@Again11: 
     push cx 
	      mov cx,100 
@@Again111: 
     loop @@again111
	 pop cx 
	 loop @@Again11 
	 mov al,50
	 out 42h,al
	 mov al,50 
	 out 42h,al 
	 
	      mov cx,10000
@@Again1: 
     push cx 
	      mov cx,100 
@@Again: 
     loop @@again 
	 pop cx 
	 loop @@Again1 
     in al,61h 
	 and al,11111100b 
	 out 61h,al 
@@Finish: 
	 popa 
	 ret 
endp lastsound 
;=======================
;description:the sound of choos the deletor 
;input:none 
;OutPut:screan 
;Register Used:none 
;=======================
proc DeletorSound 
     pusha 
     in al,61h 
	 or al,00000011b
     out 61h,al 
     mov al,0b6h 
	 out 43h,al  
     mov al,100
	 out 42h,al
	 mov al,100 
	 out 42h,al 
	 
	      mov cx,10000
@@Again1: 
     push cx 
	      mov cx,30 
@@Again: 
     loop @@again 
	 pop cx 
	 loop @@Again1 
	 in al,61h 
	 and al,11111100b 
	 out 61h,al 
	 popa 
	 ret 
endp DeletorSound 
;========================
;description:create sound of choos brash  
;input:none 
;OutPut:sound  
;register Used:none 
;========================
proc BrashSound 
        pusha 
     in al,61h 
	 or al,00000011b
     out 61h,al 
     mov al,0b6h 
	 out 43h,al  
     mov al,100
	 out 42h,al
	 mov al,50 
	 out 42h,al 
	 
	      mov cx,10000
@@Again1: 
     push cx 
	      mov cx,30 
@@Again: 
     loop @@again 
	 pop cx 
	 loop @@Again1 
	 in al,61h 
	 and al,11111100b 
	 out 61h,al 
	 popa 
	 ret  
endp BrashSound 
;======================
;descriptin:create choos color sound 
;Input:none 
;OutPut:sound 
;Register Used:none 
;====================== 
proc ColorSound 
        pusha 
     in al,61h 
	 or al,00000011b
     out 61h,al 
     mov al,0b6h 
	 out 43h,al  
     mov al,50
	 out 42h,al
	 mov al,80 
	 out 42h,al 
	 
	      mov cx,10000
@@Again1: 
     push cx 
	      mov cx,30 
@@Again: 
     loop @@again 
	 pop cx 
	 loop @@Again1 
	 in al,61h 
	 and al,11111100b 
	 out 61h,al 
	 popa 
	 ret  
endp ColorSound 
