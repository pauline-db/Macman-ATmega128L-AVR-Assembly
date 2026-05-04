

.macro	DETECT_10		; port,pin,timeout-addr	; Wait for 1-0 transition	
	ldi r16,59			; reset timout counter
p0:	dec	r16	
	brne PC+2			; decrement timeout counter
	rjmp	@2			; jump to timeout-addr if 0
	sbis	@0,@1		; loop back if 0, skip if 1
	rjmp	p0
	clr	r16				; reset timout counter
p1:	dec	r16				; decrement timeout counter
	brne PC+2
	rjmp	@2			; jump to timeout-addr if 0
	sbic	@0,@1		; loop back if 1, skip if 0
	rjmp	p1
.endmacro