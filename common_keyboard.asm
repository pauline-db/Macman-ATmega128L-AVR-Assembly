; file	common_keyboard.asm   target ATmega128L-4MHz-STK300		
; purpose interfacing the PC AT keyboard
; module: M4, input port: PORTF

;macro qui detecte les 8 bits envoyé

	

main_keyboard:
	sei
	rcall detect_loop8	; detect stop-bit
	rcall handle_normal_code
	ret		; jump back to main


;puts us in different loops depending on the char


break_loop: ;makes sure break codes are ignored
	rcall detect_loop8
	rcall detect_loop8
	cpi r20, 0xE0 ;check for special character
	brne PC+2
	rcall detect_loop8
	ret

;boucle qui interprète un caractère du clavier
handle_normal_code:

	call init_z
	ld w, z
	cpi w,1
	brne PC+2
	ret
	
	cpi r20, 0x69;1
	brne PC+2
	rjmp player_1

	cpi r20, 0x72; 2
	brne PC+2
	rjmp player_2

	cpi r20, 0x7a;3
	brne PC+2
	rjmp player_3

	cpi r20, 0x6b;4
	brne PC+2
	rjmp player_4
	cpi r20, 0x29
	brne PC+2
	rjmp space_key

	ret
	
;selectionne le bon profil en fonction de la touche appuyé (1, 2, 3 ou 4)

player_1:

	ldi w,1
	sts player_mem,w
	rcall break_loop
	ret
	

player_2:

	ldi w,2
	sts player_mem,w
	rcall break_loop
	ret
	

player_3:

	ldi w,3
	sts player_mem,w
	rcall break_loop
	ret
	

player_4:

	ldi w,4
	sts player_mem,w
	rcall break_loop
	ret
	
;action de la touche espace
space_key:
	lds w,player_mem
	cpi w,0
	breq break_space_key
	lds w, mode_mem
	inc w
	sts mode_mem,w

break_space_key:
	rcall break_loop
	ret



