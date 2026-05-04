
 ;detecte un byte de donnée venant du clavier (un caractère)
detect_loop8:
	
	DETECT_10 PINF,KB_CLK,detect_loop8	; detect start-bit
	;clr r21 ;0= pas de E0 reçu
	ldi	r17,8
	loop_macro:	
	DETECT_10 PINF,KB_CLK,detect_loop8	; detect data-bit
	P2C	PINF,KB_DAT		; pin to carry
	ror	r20	; roll carry to MSB
	dec	r17
	breq PC+2
	rjmp loop_macro
	DETECT_10 PINF,KB_CLK,detect_loop8	; detect parity-bit
	DETECT_10 PINF,KB_CLK,detect_loop8	; detect stop-bit
	ret











